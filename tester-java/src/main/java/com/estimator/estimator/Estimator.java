package com.estimator.estimator;

import com.estimator.compiler.Compiler;
import com.estimator.compiler.exception.CompilationFailedException;
import com.estimator.estimation.Estimation;
import com.estimator.tester.TestResult;
import com.estimator.tester.Tester;
import com.estimator.tester.exception.TestFailedException;
import com.estimator.utils.FilesUtils;
import com.estimator.utils.exception.FilesUtilsException;
import org.junit.Test;

import java.io.File;
import java.lang.reflect.Method;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public abstract class Estimator {

    Estimation estimation;

    Estimator() {
        estimation = new Estimation();
    }

    public abstract Estimation estimate();

    void compile(String[] compilationFilesDirectories) throws CompilationFailedException {
        try {
            List<Path> filesPaths = getFilesPaths(compilationFilesDirectories);
            Path outDirectory = Paths.get("out");
            FilesUtils.prepareDirectory(outDirectory.toFile());
            Compiler.compile(filesPaths, outDirectory);
            estimation.setCompilationResult("Compiled successfully");
            estimation.setCompiled(true);
        } catch (FilesUtilsException e) {
            throw new CompilationFailedException(e.getMessage());
        }
    }

    private static List<Path> getFilesPaths(String[] compilationFilesDirectories) throws FilesUtilsException {
        List<Path> filePaths = new ArrayList<>();
        for (String directory : compilationFilesDirectories) {
            File directoryFile = Paths.get(directory).toFile();
            File[] directoryListing = FilesUtils.listFiles(directoryFile);
            for (File file : directoryListing) {
                filePaths.add(file.toPath());
            }
        }
        return filePaths;
    }

    static List<String> getTestsFilenames() throws TestFailedException {
        try {
            List<String> testsFilenames = new ArrayList<>();
            String testDirectory = "tests";
            File directoryFile = Paths.get(testDirectory).toFile();
            File[] directoryListing = FilesUtils.listFiles(directoryFile);
            for (File file : directoryListing) {
                testsFilenames.add(file.getName());
            }
            return testsFilenames;
        } catch (FilesUtilsException e) {
            throw new TestFailedException(e.getMessage());
        }
    }

    static List<TestResult> testFiles(List<String> testsFilenames) throws TestFailedException {
        try {
            List<TestResult> testsResults = new ArrayList<>();
            File outPath = Paths.get("out").toFile();
            for (String testsFilename : testsFilenames) {
                Class<?> junitTest = Tester.getJunit(outPath, testsFilename);
                if (Tester.getTestsNumber(junitTest) == 0) {
                    continue;
                }
                TestResult testResult = Tester.runTests(junitTest);
                testsResults.add(testResult);
            }
            return testsResults;
        } catch (TestFailedException e) {
            throw new TestFailedException(e.getMessage());
        }
    }
}
