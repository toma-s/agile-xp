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

    private static final int SIZE = 8;
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
                if (!(line.length() == 2 && line.substring(1, 2).matches("[1-8]") &&  line.substring(0, 1).matches("[A-H]"))) {
                    System.out.println("Incorrect tile input");
                    return;
                }
                int r = Integer.parseInt(line.substring(1, 2));
                Alpha c = Alpha.valueOf(line.substring(0, 1));
                move(c, r);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
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
        if (gameConfig.length != 3) {
            System.out.println("Game configuration must contain 3 lines.");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input.");
                return;
            }
            onTurn = Player.valueOf(gameConfig[0]);
            playground = new Player[SIZE][SIZE];
            for (int r = 0; r < SIZE; r++) {
                for (int c = 0; c < SIZE; c++) {
                    playground[r][c] = Player.NONE;
                }
            }
            try {
                for (int i = 1; i < 3; i++) {
                    String[] tiles = gameConfig[i].split(" ");
                    for (String tile : tiles) {
                        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[1-8]") &&  tile.substring(0, 1).matches("[A-H]"))) {
                            System.out.println("Incorrect tile input");
                            return;
                        }
                        int r = Integer.parseInt(tile.substring(1, 2)) - 1;
                        int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
                        playground[r][c] = players[i - 1];
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
            for (int r = 0; r < SIZE; r++) {
                for (int c = 0; c < SIZE; c++) {
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

    private void printPlayground() {
        String[] abc = "ABCDEFGH".split("");
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r < SIZE; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < SIZE; c++) {
                switch (playground[r][c]) {
                    case B: System.out.print("B "); break;
                    case W: System.out.print("W "); break;
                    case NONE: System.out.print("_ "); break;
                }
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

    void move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();

        if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) {
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
            if (dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
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
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != Player.NONE) continue;
                ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
                    if (dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
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
                String rString = String.valueOf(r + 1);
                String cString = Alpha.values()[c].toString();
                tiles.add(cString.concat(rString));
            }
        }
        return tiles.size() != 0;
    }

    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("upload-dir/12345/game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}