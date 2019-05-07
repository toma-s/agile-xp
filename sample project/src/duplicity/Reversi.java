package duplicity;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            initGame(gameConfig);
            initTilesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines");
            return;
        }
        try {
            if (!gameConfig[0].matches("[0-9]+")) {
                System.out.println("Incorrect size input");
                return;
            }
            size = Integer.parseInt(gameConfig[0]);
            if (gameConfig[1] == null || !gameConfig[1].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[1])) {
                onTurn = Player.B;
            } else if ("W".equals(gameConfig[1])) {
                onTurn = Player.W;
            }
            playground = new Player[size][size];
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    playground[r][c] = Player.NONE;
                }
            }
            for (int i = 2; i < 4; i++) {
                String[] tiles = gameConfig[i].split(",");
                for (String tile : tiles) {
                    if (!isTileInputCorrect(tile)) {
                        System.out.println("Incorrect tile input");
                        return;
                    }
                    int[] coordinates = getCoordinates(tile);
                    int r = coordinates[0];
                    int c = coordinates[1];
                    if (r >= size || c >= size) {
                        return;
                    }
                    playground[r][c] = players[i - 2];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    boolean isTileInputCorrect(String tile) {
        return tile.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    private int[] getCoordinates(String tile) {
        String[] coordinates = tile.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void initTilesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        leftB++;
                    } else if (playground[r][c] == Player.W) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground, size);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                if (!isTileInputCorrect(line)) {
                    System.out.println("Incorrect tile input");
                    return;
                }
                int[] coordinates = getCoordinates(line);
                move(coordinates[0], coordinates[1]);
                printTilesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != Player.NONE) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (winner != Player.NONE) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        Player opposite = Player.NONE;
        if (onTurn == Player.W) opposite = Player.B;
        else if (onTurn == Player.B) opposite = Player.W;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (isWithinPlayground(dirR, dirC) && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!isWithinPlayground(dirR, dirC)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!isWithinPlayground(dirR, dirC)) break;
            }
            if (!isWithinPlayground(dirR, dirC)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                tilesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = Player.NONE;
        if (!tilesToFlip.isEmpty()) {
            tilesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (tilesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> tile : tilesToFlip) {
            int tileR = tile.get(0);
            int tileC = tile.get(1);
            if (playground[tileR][tileC] == onTurn) break;
            if (playground[tileR][tileC] == Player.NONE) {
                playground[tileR][tileC] = onTurn;
                if (onTurn == Player.B) leftB++;
                else if (onTurn == Player.W) leftW++;
            } else {
                playground[tileR][tileC] = onTurn;
                if (onTurn == Player.B) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
        if (! areValidMoves()) {
            printTilesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = Player.B;
            else if (getLeftW() > getLeftB()) winner = Player.W;
        }
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    boolean areValidMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                ArrayList<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                Player opposite  = Player.NONE;
                if (onTurn == Player.W) opposite = Player.B;
                else if (onTurn == Player.B) opposite = Player.W;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (isWithinPlayground(dirR, dirC) && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!isWithinPlayground(dirR, dirC)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!isWithinPlayground(dirR, dirC)) break;
                    }
                    if (!isWithinPlayground(dirR, dirC)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = Player.NONE;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                tiles.add(cString.concat(rString));
            }
        }
        return !tiles.isEmpty();
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
