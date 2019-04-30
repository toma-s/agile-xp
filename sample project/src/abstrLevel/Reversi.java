package abstrLevel;

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
        setSize(gameConfig[0]);
        setOnTurn(gameConfig[1]);
        createPlayground();
        fillPlayground(gameConfig);
}

    void setSize(String size) {
        if (!size.matches("[0-9]+")) {
            System.out.println("Incorrect size input");
            return;
        }
        this.size = Integer.parseInt(size);
    }

    void setOnTurn(String onTurn) {
        if (!isOnTurnInputCorrect(onTurn)) {
            System.out.println("Incorrect player on turn input");
            return;
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

    void fillPlayground(String[] gameConfig) {
        try {
            for (int i = 2; i < 4; i++) {
                String[] tiles = gameConfig[i].split(" ");
                for (String tile : tiles) {
                    setTile(tile, players[i - 2]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect");
        }
    }

    void setTile(String tile, Player player) {
        if (!isTileInputCorrect(tile)) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(0, 1));
        int c = Integer.parseInt(tile.substring(1, 2));
        if (r >= size || c >= size) {
            return;
        }
        playground[r][c] = player;
    }

    boolean isTileInputCorrect(String tile) {
        return tile.length() == 2 && tile.substring(0, 1).matches("[0-9]+") && tile.substring(1, 2).matches("[0-9]+");
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
                execute(line);
                reader.close();
            }
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
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

    void execute(String line) {
        printTilesLeftCount();
        if (!isTileInputCorrect(line)) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(line.substring(0, 1));
        int c = Integer.parseInt(line.substring(1, 2));
        move(r, c);
        printTilesLeftCount();
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
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
        if (tilesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
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
                toFLip.add(new ArrayList<>(List.of(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (!toFLip.isEmpty()) {
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
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
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
        String fileName = "game_8_b_init.txt.txt";

        File gameFile = new File("./game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
