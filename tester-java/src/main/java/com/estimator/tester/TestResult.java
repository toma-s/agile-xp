package com.estimator.tester;

import org.junit.runner.Result;

public class TestResult extends Result {

    private int testsNumber;

    TestResult(Result result) {
        super();
    }

    public int getTestsNumber() {
        return testsNumber;
    }

    void setTestsNumber(int testsNumber) {
        this.testsNumber = testsNumber;
    }
}
