package moveException;

public class IncorrectGameConfigFileException extends Exception {

    public IncorrectGameConfigFileException(String message) {
        super(message);
    }

    public IncorrectGameConfigFileException(String message, Throwable cause) {
        super(message, cause);
    }
}
