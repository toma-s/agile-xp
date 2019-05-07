package fixed;

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

    int[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private int[] players = new int[] { 1, 0 };
    int onTurn = -1;
    int winner = -1;
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
        int configFileLinesNumber = 3;
        if (gameConfig.length != configFileLinesNumber) {
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[0])) {
                onTurn = 1;
            } else if ("W".equals(gameConfig[0])) {
                onTurn = 0;
            }
            playground = new int[8][8];
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c < 8; c++) {
                    playground[r][c] = -1;
                }
            }
            for (int i = 1; i < 3; i++) {
                String[] tiles = gameConfig[i].split(" ");
                for (String tile : tiles) {
                    if (!(tile.length() == 2 && tile.substring(0, 1).matches("[0-7]") &&  tile.substring(1, 2).matches("[0-7]"))) {
                        System.out.println("Incorrect tile input");
                        return;
                    }
                    int r = Integer.parseInt(tile.substring(0, 1));
                    int c = Integer.parseInt(tile.substring(1, 2));
                    playground[r][c] = players[i - 1];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initTilesCount() {
        try {
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c <= 7; c++) {
                    if (playground[r][c] == 1) {
                        leftB++;
                    } else if (playground[r][c] == 0) {
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
                printPlayground();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!(line.length() == 2 && line.substring(0, 1).matches("[0-7]") &&  line.substring(1, 2).matches("[0-7]"))) {
                    System.out.println("Incorrect tile input");
                    return;
                }
                int r = Integer.parseInt(line.substring(0, 1));
                int c = Integer.parseInt(line.substring(1, 2));
                move(r, c);
                printTilesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPlayground() {
        System.out.println("  0 1 2 3 4 5 6 7");
        for (int r = 0; r < 8; r++) {
            System.out.print(r  + " ");
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] == -1)
                    System.out.print("_ ");
                else if (playground[r][c] == 1)
                    System.out.print("B ");
                else
                    System.out.print("W ");
            }
            System.out.println();
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
        if (!(r >= 0 && c >= 0 && r <= 7 && c < 8)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != -1) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        int opposite = -1;
        if (onTurn == 0) opposite = 1;
        else if (onTurn == 1) opposite = 0;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC < 8)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                tilesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
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
            if (playground[tileR][tileC] == -1) {
                playground[tileR][tileC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[tileR][tileC] = onTurn;
                if (onTurn == 1) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == 0) onTurn = 1;
        else if (onTurn == 1) onTurn = 0;
        if (! areValidMoves()) {
            printTilesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = 1;
            else if (getLeftW() > getLeftB()) winner = 0;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                ArrayList<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                int opposite  = -1;
                if (onTurn == 0) opposite = 1;
                else if (onTurn == 1) opposite = 0;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC <= 7)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
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
