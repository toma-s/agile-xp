package com.estimator.utils.exception;

public class JsonWriterException extends Exception {

    public JsonWriterException(String message) {
        super(message);
    }

    public JsonWriterException(String message, Throwable cause) {
        super(message, cause);
    }

    public JsonWriterException(Throwable cause) {
        super(cause);
    }
}
