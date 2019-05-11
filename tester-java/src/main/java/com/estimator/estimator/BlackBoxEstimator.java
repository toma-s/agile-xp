package com.estimator.estimator;

import com.estimator.compiler.exception.CompilationFailedException;
import com.estimator.estimation.Estimation;
import com.estimator.tester.TestResult;
import com.estimator.tester.exception.TestFailedException;
import com.estimator.utils.FilesUtils;
import com.estimator.utils.exception.FilesUtilsException;
import org.junit.runner.Result;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

public class BlackBoxEstimator extends Estimator {

    public BlackBoxEstimator() {
        super();
    }

    @Override
    public Estimation estimate() {
        try {
            String[] compilationFilesDirectories = new String[]{"private-sources", "tests", "switcher"};
            System.out.println(Arrays.toString(FilesUtils.listFiles(Paths.get(".").toFile())));
            int bugsNumber = getBugsNumber();
            int bugsFound = 0;
            for (int i = 0; i < bugsNumber; i++) {
                prepareAlteringFlags(i);
                compile(compilationFilesDirectories);
                List<TestResult> testResults = test();

                prepareControlFlags();
                compile(compilationFilesDirectories);
                List<TestResult> controllingTestResults = test();

                if (bugWasFound(testResults, controllingTestResults)) {
                    bugsFound++;
                }
            }
            setResult(bugsFound, bugsNumber);
        } catch (CompilationFailedException e) {
            estimation.setCompilationResult(e.getMessage());
        } catch (TestFailedException e) {
            estimation.setTestsResult(e.getMessage());
        } catch (FilesUtilsException e) {
            e.printStackTrace();
        }
        return estimation;
    }

    private static int getBugsNumber() throws CompilationFailedException {
        try {
            Path bugsNumberFilePath = Paths.get("bugsNumber").resolve("bugsNumber");
            String text = new String(Files.readAllBytes(bugsNumberFilePath), StandardCharsets.UTF_8);
            return Integer.parseInt(text.trim());
        } catch (IOException | NumberFormatException e) {
            throw new CompilationFailedException(e.getMessage());
        }
    }

    private static void prepareAlteringFlags(int i) throws CompilationFailedException {
        File[] alteringFlags = Paths.get("altering-flags").toFile().listFiles();
        if (alteringFlags == null ||  alteringFlags.length <= i) {
            throw new CompilationFailedException("Altering flags files are invalid");
        }
        File flags = alteringFlags[i];
        storeFlags(flags.toPath());
    }

    private List<TestResult> test() throws TestFailedException {
        List<String> testsFilenames = getTestsFilenames();
        return testFiles(testsFilenames);
    }

    private static void prepareControlFlags() throws CompilationFailedException {
        Path controlFlags = Paths.get("control-flags").resolve("flags.txt");
        storeFlags(controlFlags);
    }

    private static void storeFlags(Path flags) throws CompilationFailedException {
        try {
            Path flagsDirectory = Paths.get("flags");
            FilesUtils.prepareDirectory(flagsDirectory.toFile());
            Path flagsFile = flagsDirectory.resolve("flags.txt");
            FilesUtils.createFile(flagsFile.toFile());
            FilesUtils.copyFileContent(flags, flagsFile);
        } catch (FilesUtilsException e) {
            throw new CompilationFailedException(e.getMessage());
        }
    }

    private static boolean bugWasFound(List<TestResult> testResults, List<TestResult> controllingTestResults) {
        int resultFailures = 0;
        int controllingResultFailures = 0;
        for (int j = 0; j < testResults.size(); j++) {
            Result result = testResults.get(j);
            Result controllingResult = controllingTestResults.get(j);
            resultFailures += result.getFailureCount();
            controllingResultFailures += controllingResult.getFailureCount();
        }
        return resultFailures - controllingResultFailures >= 1;
    }

    private void setResult(int bugsFound, int bugsNumber) {
        estimation.setTestsResult(String.format("Bugs found: %d/%d", bugsFound, bugsNumber));
        estimation.setTested(true);
        estimation.setSolved(bugsNumber == bugsFound);
        estimation.setValue(bugsFound / bugsNumber * 100);
    }

}
