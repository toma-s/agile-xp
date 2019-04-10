package com.agilexp.tester;

import com.agilexp.tester.exception.TestFailedException;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.file.Files;
import java.nio.file.Path;

public class Tester {

    public static Result test(Path outDirPath, String testFilename) throws TestFailedException {
        Class<?> junitTest = getJunit(outDirPath.resolve("out").toFile(), testFilename);
        return runTests(junitTest);
    }

    private static Class<?> getJunit(File outDir, String testFilename) throws TestFailedException {
        URL outUrl;
        try {
            outUrl = outDir.toURI().toURL();
        } catch (MalformedURLException e) {
            e.printStackTrace();
            throw new TestFailedException("MalformedURLException: " + e.getMessage());
        }

        URL[] outUrls = {outUrl};
        ClassLoader classLoader = new URLClassLoader(outUrls);
        Class<?> junitTest;

        try {
            String className = testFilename.substring(0, testFilename.lastIndexOf('.'));
            System.out.println(className);
            System.out.println(Files.isDirectory(outDir.toPath()));
            junitTest = Class.forName(className, true, classLoader);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new TestFailedException("ClassNotFoundException: " + e.getMessage());
        } catch (NullPointerException e) {
            e.printStackTrace();
            throw new TestFailedException("NullPointerException: " + e.getMessage());
        }

        return junitTest;
    }

    private static Result runTests(Class<?> junitTest) {
        JUnitCore junit = new JUnitCore();
        Result result = junit.run(junitTest);
        return result;
    }
}