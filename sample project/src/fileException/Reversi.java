package fileException;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private HashMap<Player, Integer> left = new HashMap<Player, Integer>() {{ put(Player.B, 0); put(Player.W, 0); }};
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) throws IncorrectGameConfigFileException {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            checkLength(gameConfig);
            initGame(gameConfig);
            initPiecesCount();
        } catch (IncorrectGameConfigFileException e) {
            ended = true;
            throw new IncorrectGameConfigFileException(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) throws IncorrectGameConfigFileException {
        String[] gameConfig;
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            throw new IncorrectGameConfigFileException("Game configuration file does not exist");
        } catch (IOException e) {
            throw new IncorrectGameConfigFileException("Could not read game configuration file");
        }
        return gameConfig;
    }

    void checkLength(String[] gameConfig) throws IncorrectGameConfigFileException {
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            throw new IncorrectGameConfigFileException("Game configuration must contain " + configFileLinesNumber + " lines");
        }
    }

    void initGame(String[] gameConfig) throws IncorrectGameConfigFileException {
        setSize(gameConfig[0]);
        setOnTurn(gameConfig[1]);
        createPlayground();
        fillPlayground(gameConfig);
    }

    void setSize(String size) throws IncorrectGameConfigFileException {
        if (!size.matches("[0-9]+")) {
            throw new IncorrectGameConfigFileException("Incorrect size input");
        }
        this.size = Integer.parseInt(size);
    }

    void setOnTurn(String onTurn) throws IncorrectGameConfigFileException {
        if (!isOnTurnInputCorrect(onTurn)) {
            throw new IncorrectGameConfigFileException("Incorrect player on turn input");
        }
        if ("B".equals(onTurn)) {
            this.onTurn = Player.B;
        } else if ("W".equals(onTurn)) {
            this.onTurn = Player.W;
        }
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    private void createPlayground() {
        playground = new Player[size][size];
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) throws IncorrectGameConfigFileException {
        try {
            for (int i = 2; i < 4; i++) {
                String[] pieces = gameConfig[i].split(",");
                for (String piece : pieces) {
                    if (!isPieceInputCorrect(piece)) {
                        throw new IncorrectGameConfigFileException("Incorrect piece input");
                    }
                    int[] coordinates = getCoordinates(piece);
                    setPiece(coordinates, players[i - 2]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            throw new IncorrectGameConfigFileException("Game configuration file is incorrect");
        }
    }

    boolean isPieceInputCorrect(String piece) {
        return piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String piece) {
        String[] coordinates = piece.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void setPiece(int[] coordinates, Player player) throws IncorrectGameConfigFileException {
        int r = coordinates[0];
        int c = coordinates[1];
        if (r >= size || c >= size) {
            throw new IncorrectGameConfigFileException("Incorrect piece input");
        }
        playground[r][c] = player;
    }

    void initPiecesCount() throws IncorrectGameConfigFileException {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.NONE) {
                        continue;
                    }
                    left.put(playground[r][c], left.get(playground[r][c]) + 1);
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            throw new IncorrectGameConfigFileException("Playground  is not valid", e);
        }
    }

    void run() throws IncorrectGameConfigFileException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printHints(playground, size, getPossibleMoves());
                PlaygroundPrinter.printPlayground(playground, size);
                PlaygroundPrinter.printMoveOnTurn(onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            throw new IncorrectGameConfigFileException("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    void execute(String line) {
        if (!isPieceInputCorrect(line)) {
            System.out.println("Incorrect piece input");
            return;
        }
        int[] coordinates = getCoordinates(line);
        move(coordinates[0], coordinates[1]);
        if (! areValidMoves()) {
            endGame();
        }
    }

    private void printPiecesLeftCount() {
        PlaygroundPrinter.printPiecesNumber(getLeftB(), getLeftW());
    }

    int getLeftB() {
        return left.get(Player.B);
    }

    int getLeftW() {
        return left.get(Player.W);
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        List<List<Integer>> piecesToFlip = getPiecesToFlip(r, c);
        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        flipPieces(piecesToFlip);

        swapPlayerOnTurn();
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    List<List<Integer>> getPiecesToFlip(int r0, int c0) {
        List<List<Integer>> toFlip = new ArrayList<>();
        playground[r0][c0] = onTurn;
        Player opposite = Player.NONE;
        if (onTurn == Player.W) opposite = Player.B;
        else if (onTurn == Player.B) opposite = Player.W;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int r = r0;
            int c = c0;
            r += direction[0];
            c += direction[1];
            if (isWithinPlayground(r, c) && playground[r][c] != opposite) continue;
            r += direction[0];
            c += direction[1];
            if (!isWithinPlayground(r, c)) continue;
            while (playground[r][c] == opposite) {
                r += direction[0];
                c += direction[1];
                if (!isWithinPlayground(r, c)) break;
            }
            if (!isWithinPlayground(r, c)) continue;
            if (playground[r][c] != onTurn) continue;
            while (true) {
                r -= direction[0];
                c -= direction[1];
                if (r == r0 && c == c0) break;
                toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (!toFlip.isEmpty()) {
            toFlip.add(new ArrayList<>(Arrays.asList(r0, c0)));
        }
        return toFlip;
    }

    void flipPieces(List<List<Integer>> pieces) {
        pieces.forEach(piece -> {
            Player previous = playground[piece.get(0)][piece.get(1)];
            playground[piece.get(0)][piece.get(1)] = onTurn;
            if (previous == Player.NONE) {
                left.put(onTurn, left.get(onTurn) + 1);
            } else if (previous != onTurn) {
                left.put(previous, left.get(previous) - 1);
                left.put(onTurn, left.get(onTurn) + 1);
            }
        });
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    boolean areValidMoves() {
        int movesNum = getPossibleMoves().size();
        return movesNum != 0;
    }

    List<String> getPossibleMoves() {
        List<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getPiecesToFlip(r, c).isEmpty()) continue;
                pieces.add(String.format("%s %s", r,  c));
            }
        }
        return pieces;
    }

    void endGame() {
        printPiecesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev;
        try {
            rev = new Reversi(gameFilePath);
            rev.run();
        } catch (IncorrectGameConfigFileException e) {
            PlaygroundPrinter.printIncorrectConfig(e);
        }

    }

}
