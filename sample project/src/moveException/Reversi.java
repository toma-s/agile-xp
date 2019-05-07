package moveException;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.*;

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
            initGame(gameConfig);
            initTilesCount();
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

    void initGame(String[] gameConfig) throws IncorrectGameConfigFileException {
        if (gameConfig == null) {
            throw new IncorrectGameConfigFileException("Game configuration is null");
        }
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            throw new IncorrectGameConfigFileException("Game configuration must contain " + configFileLinesNumber + " lines");
        }
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
                String[] tiles = gameConfig[i].split(",");
                for (String tile : tiles) {
                    if (!isTileInputCorrect(tile)) {
                        throw new IncorrectGameConfigFileException("Incorrect tile input");
                    }
                    int[] coordinates = getCoordinates(tile);
                    setTile(coordinates, players[i - 2]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            throw new IncorrectGameConfigFileException("Game configuration file is incorrect");
        }
    }

    boolean isTileInputCorrect(String tile) {
        return tile.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String tile) {
        String[] coordinates = tile.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void setTile(int[] coordinates, Player player) throws IncorrectGameConfigFileException {
        int r = coordinates[0];
        int c = coordinates[1];
        if (r >= size || c >= size) {
            throw new IncorrectGameConfigFileException("Incorrect tile input");
        }
        playground[r][c] = player;
    }

    void initTilesCount() throws IncorrectGameConfigFileException {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        left.put(Player.B, left.get(Player.B) + 1);
                    } else if (playground[r][c] == Player.W) {
                        left.put(Player.W, left.get(Player.W) + 1);
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            throw new IncorrectGameConfigFileException("Playground  is not valid", e);
        }
    }

    private void run() throws IncorrectGameConfigFileException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground, size);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                try {
                    execute(line);
                } catch (NotPermittedMoveException e) {
                    System.out.println(e.getMessage());
                    System.out.println("Try again");
                }
                printTilesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            throw new IncorrectGameConfigFileException("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return left.get(Player.B);
    }

    int getLeftW() {
        return left.get(Player.W);
    }

    void execute(String line) throws NotPermittedMoveException {
        if (!isTileInputCorrect(line)) {
            throw new NotPermittedMoveException("Incorrect tile input");
        }
        int[] coordinates = getCoordinates(line);
        move(coordinates[0], coordinates[1]);
    }

    void move(int r, int c) throws NotPermittedMoveException {
        if (!isWithinPlayground(r, c)) {
            throw new NotPermittedMoveException("Move out of bounds is not permitted");
        }
        if (!isEmpty(r, c)) {
            throw new NotPermittedMoveException("Move on not empty tile is not permitted");
        }
        if (isGameOver()) {
            throw new NotPermittedMoveException("The game is over. No moves are permitted");
        }

        ArrayList<List<Integer>> tilesToFlip = getTilesToFlip(r, c);
        if (tilesToFlip.isEmpty()) {
            throw new NotPermittedMoveException("Move is not permitted");
        }
        flipTiles(tilesToFlip);

        swapPlayerOnTurn();
        if (! areValidMoves()) {
            endGame();
        }
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

    ArrayList<List<Integer>> getTilesToFlip(int r0, int c0) {
        ArrayList<List<Integer>> toFlip = new ArrayList<>();
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

    void flipTiles(List<List<Integer>> tiles) {
        tiles.forEach(tile -> {
            Player previous = playground[tile.get(0)][tile.get(1)];
            playground[tile.get(0)][tile.get(1)] = onTurn;
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

    ArrayList<String> getPossibleMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getTilesToFlip(r, c).isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                tiles.add(cString.concat(rString));
            }
        }
        return tiles;
    }

    void endGame() {
        printTilesLeftCount();
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
            System.out.println(e.getMessage());
        }

    }

}
