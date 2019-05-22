package com.estimator.tester;

import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

import java.util.List;


public class TestResult {

    private int ignoreCount;
    private int failureCount;
    private List<Failure> failures;
    private long runTime;
    private int testsNumber;
    private boolean wasSuccessful;

    TestResult(Result result) {
        this.ignoreCount = result.getIgnoreCount();
        this.failures = result.getFailures();
        this.runTime = result.getRunTime();
        this.failureCount = result.getFailureCount();
        this.wasSuccessful = result.wasSuccessful();
    }

    public int getIgnoreCount() {
        return ignoreCount;
    }

    public List<Failure> getFailures() {
        return failures;
    }

    public int getFailureCount() {
        return failureCount;
    }

    public long getRunTime() {
        return runTime;
    }

    public boolean wasSuccessful() {
        return wasSuccessful;
    }

    public int getTestsNumber() {
        return testsNumber;
    }

    void setTestsNumber(int testsNumber) {
        this.testsNumber = testsNumber;
    }
}
