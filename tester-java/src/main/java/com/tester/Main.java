package com.tester;

import com.tester.compiler.Compiler;
import com.tester.compiler.exception.CompilationFailedException;
import com.tester.tester.Tester;
import com.tester.tester.exception.TestFailedException;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {

    public static void main(String[] args) {

        String mode = args[0];
        System.out.println(mode);

        String result = "";

        switch (mode) {
            case "whitebox-file": {
                result = estimateSourceTestFile();
            }
        }

        System.out.println(result);
    }

    private static String estimateSourceTestFile() {
        System.out.println("Public estimation");
        String publicEstimation = estimatePublic();
        return String.format("Solved, Estimation: %s",
                publicEstimation);
    }

    private static String estimatePublic() {
        try {
            String compilationResult = compileFiles();
            List<Result> testResults = testSourceTestFile();
            String testResult = getResult(testResults);
            return String.format("Compilation result: %s\nTests result: %s",
                    compilationResult,
                    testResult);
        } catch (CompilationFailedException e) {
            return "Compilation failed: \n" + e.getMessage();
        } catch (TestFailedException e) {
            return "Test failed: \n" + e.getMessage();
        }
    }

    private static String compileFiles() throws CompilationFailedException {
        try {
            System.out.println("Files compilation");
            List<Path> filePaths = getFilePaths();
//            System.out.println(filePaths);

            Path outDirectory = Paths.get("");
//            System.out.println(outDirectory.toAbsolutePath().toFile().exists());
//            System.out.println(outDirectory.toAbsolutePath());

            Path out = outDirectory.resolve("out");
            boolean mkdir = out.toFile().mkdir();
//            System.out.println(mkdir);
//            System.out.println(out.toAbsolutePath().toFile().exists());
//            System.out.println(out.toAbsolutePath());

            Compiler.compile(filePaths, outDirectory);
            System.out.println("Compiled successfully");
            return "Compiled successfully";
        } catch (CompilationFailedException e) {
            return e.getMessage();
        }
        // TODO: 09-May-19 change return way
    }

    private static List<Path> getFilePaths() {
        List<Path> filePaths = new ArrayList<>();
        String[] directories = new String[] {
                "solution_source",
                "solution_test"};
        for (String directory : directories) {
            File directoryFile = Paths.get(directory).toFile();
//            System.out.println(Paths.get(directory).toAbsolutePath());
//            System.out.println(directoryFile.getName());
//            System.out.println(directoryFile.exists());
            File[] dirListing = directoryFile.listFiles();
//            System.out.println("dirListing: " + Arrays.toString(dirListing));
            if (dirListing != null) {
                for (File file : dirListing) {
                    filePaths.add(file.toPath());
//                    System.out.println("File path: " + file.toPath());
                }
            }
        }
        return filePaths;
    }

    private static List<Result> testSourceTestFile() throws TestFailedException {
        List<Result> testsResults = new ArrayList<>();
        try {
            File outPath = Paths.get("out").toFile();
            System.out.println("out exists: " + outPath.exists());

            String testDirectory = "solution_test";
            File directoryFile = Paths.get(testDirectory).toFile();
            File[] dirListing = directoryFile.listFiles();
            System.out.println("solution_test exists: " + directoryFile.exists());
            System.out.println("out/solution_test dirListing: " + Arrays.toString(dirListing));
            if (dirListing != null) {
                for (File file : dirListing) {
                    String testFilename = file.getName();
                    System.out.println("testFilename: " + testFilename);
                    System.out.println("file exists: " + file.exists());
                    Result testResult = Tester.test(outPath, testFilename);
                    testsResults.add(testResult);
                }
            }
        } catch (TestFailedException e) {
            // TODO: 09-May-19 handle
            throw new TestFailedException(e);
        }
        return testsResults;
    }

    private static String getResult(List<Result> exerciseTestsResults) {
        StringBuilder result = new StringBuilder();
        exerciseTestsResults.forEach(exerciseTestsResult -> {
                    result.append(getResultInfo(exerciseTestsResult));
                    result.append("\n\n");
                }
        );
        return result.toString();
    }

    private static StringBuffer getResultInfo(Result result) {
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
}
