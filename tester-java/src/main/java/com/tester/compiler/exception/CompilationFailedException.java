package com.tester.compiler.exception;


public class CompilationFailedException extends Exception {

    public CompilationFailedException(String message) {
        super(message);
    }

    public CompilationFailedException(Throwable cause) {
        super(cause);
    }

}
