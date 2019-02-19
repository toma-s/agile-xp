import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

class ReversiRefactored {

    private final int SIZE = 8;
    private Player[][] playground = new Player[SIZE][SIZE];
    private Player onTurn = Player.B;
    private Player winner = Player.NONE;
    private String[] abc = "abcdefgh".split("");
    private HashMap<Player, Integer> left = new HashMap<>();

    ReversiRefactored() {
        initPlayground();
        initGame();
        printPlayground();
        printOnTurn();
    }

    Player getOnTurn() {
        return onTurn;
    }

    int getLeftW() {
        return left.get(Player.W);
    }

    int getLeftB() {
        return left.get(Player.B);
    }

    Player getTile(int r, int c) {
        return playground[r][c];
    }

    Player getWinner() {
        return winner;
    }

    Player getTile(Alpha c0, int r0) {
        return playground[r0-1][c0.getValue()];
    }

    private void initGame() {
        left.put(Player.B, 2);
        left.put(Player.W, 2);
    }

    private void initPlayground() {
        for (int r = 0; r < SIZE; r++) {
            for (int c = 0; c < SIZE; c++) {
                playground[r][c] = Player.NONE;
            }
        }
        playground[SIZE/2-1][SIZE/2-1] = Player.W;
        playground[SIZE/2-1][SIZE/2] = Player.B;
        playground[SIZE/2][SIZE/2] = Player.W;
        playground[SIZE/2][SIZE/2-1] = Player.B;
    }

    private void printPlayground() {
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r < SIZE; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < SIZE; c++) {
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

    private void printOnTurn() {
        if (onTurn == Player.W)
            System.out.println("On turn: W");
        else
            System.out.println("On turn: B");
    }

    private void printState() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    boolean move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();
        System.out.printf("Move on tile (%s; %s):\n\n", r, c);

        if (!(withinPlayground(r, c))) {
            System.out.println("Move out of bounds");
            return false;
        }
        if (playground[r][c] != Player.NONE) {
            System.out.println("Not valid move. The tile is not empty");
            return false;
        }
        if (winner != Player.NONE) {
            System.out.println("The game isn't running");
            return false;
        }

        ArrayList<ArrayList<Integer>> tilesToFlip = getTilesToFlip(r, c);
        if (tilesToFlip.size() == 0) {
            System.out.println("Not valid move");
            return false;
        }
        flipTiles(tilesToFlip);

        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;

        System.out.println("Move is valid");
        printPlayground();
        printState();
        return true;
    }

    private boolean withinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < SIZE && c < SIZE;
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
        return getPossibleMoves().size() != 0;
    }

    ArrayList<ArrayList<Integer>> getPossibleMoves() {
        ArrayList<ArrayList<Integer>> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getTilesToFlip(r,c).size() != 0) {
                    tiles.add(new ArrayList<>(List.of(r, c)));
                }
            }
        }
        System.out.println(tiles);
        return tiles;
    }

    void gameOver() {
        printState();
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }

}
