package com.estimator.tester.exception;

public class TestFailedException extends Exception {

    public TestFailedException(String message) {
        super(message);
    }

    public TestFailedException(Throwable cause) {
        super(cause);
    }
}
