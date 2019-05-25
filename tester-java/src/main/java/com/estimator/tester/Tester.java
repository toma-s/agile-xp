package com.estimator.tester;

import com.estimator.tester.exception.TestFailedException;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;

import java.io.File;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;

public class Tester {

    public static Class<?> getJunit(File outDir, String testFilename) throws TestFailedException {
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

    public static TestResult runTests(Class<?> junitTest) {
        JUnitCore junit = new JUnitCore();
        Result result = junit.run(junitTest);
        TestResult testResult = new TestResult(result);
        int testsNumber = getTestsNumber(junitTest);
        testResult.setTestsNumber(testsNumber);
        return testResult;
    }

    public static int getTestsNumber(Class<?> junitTest) {
        int testsNumber = 0;
        Method[] methods = junitTest.getMethods();
        for (Method method : methods) {
            if (method.isAnnotationPresent(Test.class)) {
                testsNumber++;
            }
        }
        return testsNumber;
    }
}
