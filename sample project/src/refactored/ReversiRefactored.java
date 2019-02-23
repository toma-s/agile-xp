package refactored;

import exception.IncorrectGameConfigFileException;
import exception.NotPermittedMoveException;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

class ReversiRefactored {

    private static final int SIZE = 8;
    Player[][] playground;
    private HashMap<Player, Integer> left = new HashMap<>() {{ put(Player.B, 0); put(Player.W, 0); }};
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    ReversiRefactored(String gameFilename) {
        try {
            String[] gameConfig = readGameConfig(gameFilename);
            initGame(gameConfig);
            initTilesCount();
        } catch (IncorrectGameConfigFileException e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(String gameFilename) throws IncorrectGameConfigFileException {
        String[] gameConfig;
        try {
            File gameFile = new File("./game_config/" + gameFilename);
            if (! gameFile.exists()) {
                throw new IncorrectGameConfigFileException("Game configuration file does not exist.");
            }
            Path path = gameFile.toPath();
            gameConfig = Files.readAllLines(path).toArray(new String[0]);
        } catch (IOException e) {
            throw new IncorrectGameConfigFileException("Could not open game configuration file.", e);
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) throws IncorrectGameConfigFileException {
        if (gameConfig == null || gameConfig.length != 3) {
            throw new IncorrectGameConfigFileException("Game configuration file is incorrect.");
        }
        setOnTurn(gameConfig[0]);
        fillPlayground(gameConfig);
    }


    void setOnTurn(String player) throws IncorrectGameConfigFileException {
        if (!isOnTurnInputCorrect(player)) {
            throw new IncorrectGameConfigFileException("Incorrect player on turn input.");
        }
        onTurn = Player.valueOf(player);
    }

    void fillPlayground(String[] gameConfig) throws IncorrectGameConfigFileException {
        if (gameConfig == null || gameConfig.length != 3) {
            throw new IncorrectGameConfigFileException("Game configuration file is incorrect.");
        }
        playground = new Player[SIZE][SIZE];
        for (int r = 0; r < SIZE; r++) {
            for (int c = 0; c < SIZE; c++) {
                playground[r][c] = Player.NONE;
            }
        }
        for (int i = 1; i < 3; i++) {
            String[] tiles = gameConfig[i].split(" ");
            for (String tile : tiles) {
                setTile(tile, players[i - 1]);
            }
        }
    }

    void printPlayground() {
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

    private void initTilesCount() {
        for (int r = 0; r < SIZE; r++) {
            for (int c = 0; c < SIZE; c++) {
                if (playground[r][c] == Player.B) {
                    left.put(Player.B, left.get(Player.B) + 1);
                } else if (playground[r][c] == Player.W) {
                    left.put(Player.W, left.get(Player.W) + 1);
                }
            }
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftW() {
        return left.get(Player.W);
    }

    int getLeftB() {
        return left.get(Player.B);
    }

    Player getTile(Alpha c0, int r0) {
        return playground[r0-1][c0.getValue()];
    }

    void setTile(String tile, Player player) throws IncorrectGameConfigFileException {
        if (!isTileInputCorrect(tile)) {
            throw new IncorrectGameConfigFileException("Incorrect tile input");
        }
        int r = Integer.parseInt(tile.substring(1, 2)) - 1;
        int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
        playground[r][c] = player;
    }

    private boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn.matches("[B|W]");
    }

    boolean isTileInputCorrect(String tile) {
        String r = tile.substring(1, 2);
        String c = tile.substring(0, 1);
        return r.matches("[1-8]") && c.matches("[A-H]");
    }

    void execute(String tile) {
        try {
            if (isTileInputCorrect(tile)) {
                int r = Integer.parseInt(tile.substring(1, 2));
                Alpha c = Alpha.valueOf(tile.substring(0, 1));
                move(c, r);
            }
        } catch (NotPermittedMoveException e) {
            System.out.println(e.getMessage());
        }
    }

    void move(Alpha c0, int r0) throws NotPermittedMoveException {
        System.out.printf("Move on tile (%s%s):\n\n", c0, r0);
        int r = r0 - 1;
        int c = c0.getValue();

        if (!(withinPlayground(r, c))) {
            throw new NotPermittedMoveException("Move out of bounds is not permitted");
        }
        if (playground[r][c] != Player.NONE) {
            throw new NotPermittedMoveException("Move on not empty tile is not permitted");
        }
        if (winner != Player.NONE) {
            throw new NotPermittedMoveException("The game is over. No moves are permitted");
        }

        ArrayList<ArrayList<Integer>> tilesToFlip = getTilesToFlip(r, c);
        if (tilesToFlip.size() == 0) {
            throw new NotPermittedMoveException("Move is not permitted");
        }
        flipTiles(tilesToFlip);

        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
        if (! areValidMoves()) gameOver();
        printPlayground();
    }

    private ArrayList<ArrayList<Integer>> getTilesToFlip(int r0, int c0) {
        ArrayList<ArrayList<Integer>> toFLip = new ArrayList<>();
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
            if (withinPlayground(r, c) && playground[r][c] != opposite) continue;
            r += direction[0];
            c += direction[1];
            if (!withinPlayground(r, c)) continue;
            while (playground[r][c] == opposite) {
                r += direction[0];
                c += direction[1];
                if (!withinPlayground(r, c)) break;
            }
            if (!withinPlayground(r, c)) continue;
            if (playground[r][c] != onTurn) continue;
            while (true) {
                r -= direction[0];
                c -= direction[1];
                if (r == r0 && c == c0) {
                    break;
                }
                toFLip.add(new ArrayList<>(List.of(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (toFLip.size() != 0) toFLip.add(new ArrayList<>(List.of(r0, c0)));
        return toFLip;
    }

    private boolean withinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < SIZE && c < SIZE;
    }

    private void flipTiles(ArrayList<ArrayList<Integer>> tiles) {
        tiles.forEach(tile -> {
            Player previous = playground[tile.get(0)][tile.get(1)];
            playground[tile.get(0)][tile.get(1)] = onTurn;
            if (previous == Player.NONE) {
                left.put(onTurn, left.get(onTurn) + 1);
            }
            else if (previous != onTurn) {
                left.put(previous, left.get(previous) - 1);
                left.put(onTurn, left.get(onTurn) + 1);
            }
        });
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
                if (getTilesToFlip(r,c).size() != 0) {
                    String rString = String.valueOf(r + 1);
                    String cString = Alpha.values()[c].toString();
                    tiles.add(cString.concat(rString));
                }
            }
        }
        System.out.println(tiles);
        return tiles;
    }

    private void gameOver() {
        printTilesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }

    private void run() {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
//        String fileName = "game_init.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
        String fileName = "game_all_alpha.txt";
        ReversiRefactored rev = new ReversiRefactored(fileName);

        rev.run();
    }

}
