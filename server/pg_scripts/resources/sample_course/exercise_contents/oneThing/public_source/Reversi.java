import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    int leftB = 0;
    int leftW = 0;
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
            System.out.println("Could not open game configuration file.");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file.");
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
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines.");
            return;
        }
        try {
            if (!gameConfig[0].matches("[0-9]+")) {
                System.out.println("Incorrect size value.");
                return;
            }
            size = Integer.parseInt(gameConfig[0]);
            if (gameConfig[1] == null || !gameConfig[1].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input.");
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
            try {
                for (int i = 2; i < 4; i++) {
                    String[] tiles = gameConfig[i].split(" ");
                    for (String tile : tiles) {
                        if (!(tile.length() == 2 && tile.substring(0, 1).matches("[0-9]+") &&  tile.substring(1, 2).matches("[0-9]+"))) {
                            System.out.println("Incorrect tile input");
                            return;
                        }
                        int r = Integer.parseInt(tile.substring(0, 1));
                        int c = Integer.parseInt(tile.substring(1, 2));
                        playground[r][c] = players[i - 2];
                    }
                }
            } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
                System.out.println("Game configuration file is incorrect.");
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
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
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                if (!(line.length() == 2 && line.substring(0, 1).matches("[0-9]+") &&  line.substring(1, 2).matches("[0-9]+"))) {
                    System.out.println("Incorrect tile input");
                    return;
                }
                int r = Integer.parseInt(line.substring(0, 1));
                int c = Integer.parseInt(line.substring(1, 2));
                move(r, c);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
        }
    }

    private void printPlayground() {
        System.out.println("  " + getLine());
        for (int r = 0; r < size; r++) {
            System.out.print(r  + " ");
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE)
                    System.out.print("_ ");
                else if (playground[r][c] == Player.B)
                    System.out.print("B ");
                else
                    System.out.print("W ");
            }
            System.out.println();
        }
    }

    private String getLine() {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < size; i++) {
            builder.append(i).append(" ");
        }
        return builder.toString();
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
        if (!(r >= 0 && c >= 0 && r < size && c < size)) {
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
            if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                tilesToFlip.add(new ArrayList<>(List.of(dirR, dirC)));
            }
        }

        playground[r][c] = Player.NONE;
        if (tilesToFlip.size() != 0) {
            tilesToFlip.add(new ArrayList<>(List.of(r, c)));
        }

        if (tilesToFlip.size() == 0) {
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

    boolean areValidMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
                    if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFLip.add(new ArrayList<>(List.of(dirR, dirC)));
                    }
                }

                playground[r][c] = Player.NONE;
                if (toFLip.size() != 0) {
                    toFLip.add(new ArrayList<>(List.of(r, c)));
                }
                if (toFLip.size() == 0) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                tiles.add(cString.concat(rString));
            }
        }
        return tiles.size() != 0;
    }

    public static void main(String[] args) {
        String fileName = "game_8_b_init.txt.txt";

        File gameFile = new File("./game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}