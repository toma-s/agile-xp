package com.agilexp.docker;

public class DockerControllerException extends Exception {

    public DockerControllerException(String message) {
        super(message);
    }

    public DockerControllerException(Throwable cause) {
        super(cause);
    }

    public DockerControllerException(String message, Throwable cause) {
        super(message, cause);
    }
}
