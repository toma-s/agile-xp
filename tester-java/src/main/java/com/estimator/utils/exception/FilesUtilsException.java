package com.estimator.utils.exception;

public class FilesUtilsException extends Exception {

    public FilesUtilsException(String message) {
        super(message);
    }

    public FilesUtilsException(String message, Throwable cause) {
        super(message, cause);
    }

    public FilesUtilsException(Throwable cause) {
        super(cause);
    }
}
