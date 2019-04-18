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
                execute(line);
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
            setOnTurn(gameConfig[0]);
            createPlayground();
            fillPlayground(gameConfig);
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
    }

    void setOnTurn(String player) {
        if (!isOnTurnInputCorrect(player)) {
            System.out.println("Incorrect player on turn input.");
            return;
        }
        onTurn = Player.valueOf(player);
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    void createPlayground() {
        playground = new Player[SIZE][SIZE];
        for (int r = 0; r < SIZE; r++) {
            for (int c = 0; c < SIZE; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) {
        try {
            for (int i = 1; i < 3; i++) {
                String[] tiles = gameConfig[i].split(" ");
                for (String tile : tiles) {
                    setTile(tile, players[i - 1]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect.");
        }
    }

    void setTile(String tile, Player player) {
        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[1-8]") &&  tile.substring(0, 1).matches("[A-H]"))) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(1, 2)) - 1;
        int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
        playground[r][c] = player;
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

    void execute(String tile) {
        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[1-8]") &&  tile.substring(0, 1).matches("[A-H]"))) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(1, 2));
        Alpha c = Alpha.valueOf(tile.substring(0, 1));
        move(c, r);
    }

//    boolean isTileInputCorrect(String tile) {
//        if (tile.length() != 2) return false;
//        String r = tile.substring(1, 2);
//        String c = tile.substring(0, 1);
//        return r.matches("[1-8]") && c.matches("[A-H]");
//    }

    void move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();

        if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = getTilesToFlip(r, c);
        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        flipTiles(tilesToFlip);

        swapPlayerOnTurn();
        if (! areValidMoves()) endGame();
    }

//    boolean isWithinPlayground(int r, int c) {
//        return r >= 0 && c >= 0 && r < SIZE && c < SIZE;
//    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    ArrayList<List<Integer>> getTilesToFlip(int r0, int c0) {
        ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
            if (r >= 0 && c >= 0 && r < SIZE && c < SIZE && playground[r][c] != opposite) continue;
            r += direction[0];
            c += direction[1];
            if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) continue;
            while (playground[r][c] == opposite) {
                r += direction[0];
                c += direction[1];
                if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) break;
            }
            if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) continue;
            if (playground[r][c] != onTurn) continue;
            while (true) {
                r -= direction[0];
                c -= direction[1];
                if (r == r0 && c == c0) break;
                toFLip.add(new ArrayList<>(List.of(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (toFLip.size() != 0) {
            toFLip.add(new ArrayList<>(List.of(r0, c0)));
        }
        return toFLip;
    }

    void flipTiles(List<List<Integer>> tiles) {
        for (List<Integer> tile : tiles) {
            int r = tile.get(0);
            int c = tile.get(1);
            if (playground[r][c] == onTurn) break;
            if (playground[r][c] == Player.NONE) {
                playground[r][c] = onTurn;
                if (onTurn == Player.B) leftB++;
                else if (onTurn == Player.W) leftW++;
            } else {
                playground[r][c] = onTurn;
                if (onTurn == Player.B) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }
    }

    boolean areValidMoves() {
        int movesNum = getPossibleMoves().size();
        return movesNum != 0;
    }

    ArrayList<String> getPossibleMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getTilesToFlip(r,c).size() == 0) continue;
                String rString = String.valueOf(r + 1);
                String cString = Alpha.values()[c].toString();
                tiles.add(cString.concat(rString));
            }
        }
        return tiles;
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    void endGame() {
        printTilesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }


    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("./game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}