package com.estimator.estimator;

import com.google.gson.Gson;
import com.estimator.compiler.Compiler;
import com.estimator.compiler.exception.CompilationFailedException;
import com.estimator.estimation.WhiteBoxEstimation;
import com.estimator.tester.Tester;
import com.estimator.tester.exception.TestFailedException;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class WhiteBoxFileEstimator extends Estimator {

    private WhiteBoxEstimation estimation;

    public WhiteBoxFileEstimator() {
        estimation = new WhiteBoxEstimation();
    }

    @Override
    public String estimate() {
        compile();
        test();
        return getJsonEstimation();
    }


    private void compile() {
        try {
            estimation.setCompiled(true);
            compileFiles();
            estimation.setCompilationResult("Compiled successfully");
        } catch (CompilationFailedException e) {
            estimation.setCompiled(false);
            estimation.setCompilationResult(e.getMessage());
        }
    }

    private void compileFiles() throws CompilationFailedException {
        try {
            List<Path> filePaths = getFilePaths();
            Path out = Paths.get("").resolve("out");
            boolean mkdir = out.toFile().mkdir();
            if (!mkdir) {
                throw new CompilationFailedException("Failed to create compiler output directory");
            }
            Compiler.compile(filePaths, out);
        } catch (CompilationFailedException e) {
            throw new CompilationFailedException(e.getMessage());
        }
    }

    private List<Path> getFilePaths() {
        List<Path> filePaths = new ArrayList<>();
        String[] directories = new String[] {
                "sources",
                "tests"};
        for (String directory : directories) {
            File directoryFile = Paths.get(directory).toFile();
            File[] dirListing = directoryFile.listFiles();
            if (dirListing != null) {
                for (File file : dirListing) {
                    filePaths.add(file.toPath());
                }
            }
        }
        return filePaths;
    }


    private void test() {
        try {
            estimation.setTested(true);
            List<String> testsFilenames = getTestsFilenames();
            List<Result> testResults = testFiles(testsFilenames);
            estimation.setTestsResult(getResult(testResults));
        } catch (TestFailedException e) {
            estimation.setTested(false);
            estimation.setTestsResult(e.getMessage());
        }
    }

    private List<String> getTestsFilenames() {
        List<String> testsFilenames = new ArrayList<>();
        String testDirectory = "tests";
        File directoryFile = Paths.get(testDirectory).toFile();
        File[] dirListing = directoryFile.listFiles();
        if (dirListing != null) {
            for (File file : dirListing) {
                testsFilenames.add(file.getName());
            }
        }
        return testsFilenames;
    }

    private List<Result> testFiles(List<String> testsFilenames) throws TestFailedException {
        List<Result> testsResults = new ArrayList<>();
        try {
            File outPath = Paths.get("out").toFile();
            for (String testsFilename : testsFilenames) {
                testsResults.add(Tester.test(outPath, testsFilename));
            }
        } catch (TestFailedException e) {
            throw new TestFailedException(e.getMessage());
        }
        return testsResults;
    }

    private String getResult(List<Result> exerciseTestsResults) {
        StringBuilder result = new StringBuilder();
        exerciseTestsResults.forEach(exerciseTestsResult -> {
                    result.append(getResultInfo(exerciseTestsResult));
                    result.append("\n\n");
                }
        );
        return result.toString();
    }

    private StringBuffer getResultInfo(Result result) {
        StringBuffer output = new StringBuffer();
        output.append("Test runtime: ").append(result.getRunTime()).append(" ms")
                .append("\nTest success: ").append(result.wasSuccessful())
                .append("\nFailures count: ").append(result.getFailureCount());
        if (result.getFailureCount() > 0) {
            output.append("\nFailures: ");
            List<Failure> failures = result.getFailures();
            for (int i = 0; i < failures.size(); i++) {
                Failure failure = failures.get(i);
                String detail = String.format(
                        "Test class: %s\nTest name: %s\nFailure cause: %s\n",
                        failure.getDescription().getClassName(),
                        failure.getDescription().getDisplayName(),
                        failure.getException().toString());
                output.append("\n").append(i + 1).append(") ").append(detail);
            }
        }
        output.append("\nIgnored count: ").append(result.getIgnoreCount());
        return output;
    }


    private String getJsonEstimation() {
        Gson gson = new Gson();
        return gson.toJson(estimation);
    }
}
