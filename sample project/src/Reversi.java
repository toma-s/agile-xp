import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

class Reversi {

    private int size = 8;
    private Player[][] playground = new Player[size][size];
    private Player onTurn = Player.X;
    private String[] abc = "abcdefgh".split("");
    private Player winner = Player.NONE;
    private HashMap<Player, Integer> left = new HashMap<>();

    Reversi() {
        initPlayground();
        initGame();
        printPlayground();
        printOnTurn();
    }

    int getLeftO() {
        return left.get(Player.O);
    }

    int getLeftX() {
        return left.get(Player.X);
    }

    Player getOnTurn() {
        return onTurn;
    }

    Player getWinner() {
        return winner;
    }

    Player getTile(Alpha c0, int r0) {
        return playground[r0-1][c0.getValue()];
    }

    private void initPlayground() {
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                playground[r][c] = Player.NONE;
            }
        }
        playground[size/2-1][size/2-1] = Player.O;
        playground[size/2-1][size/2] = Player.X;
        playground[size/2][size/2] = Player.O;
        playground[size/2][size/2-1] = Player.X;
    }

    private void initGame() {
        left.put(Player.X, 2);
        left.put(Player.O, 2);
    }

    private Player getOppositePlayer(Player player) {
        if (player.getValue() == Player.X.getValue()) return Player.O;
        else if (player.getValue() == Player.O.getValue()) return Player.X;
        else return Player.NONE;
    }

    private void printPlayground() {
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r < size; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE)
                    System.out.print("_ ");
                else if (playground[r][c] == Player.X)
                    System.out.print("X ");
                else
                    System.out.print("O ");
            }
            System.out.println();
        }
    }

    private void printOnTurn() {
        if (onTurn == Player.O)
            System.out.println("On turn: O");
        else
            System.out.println("On turn: X");
    }

    private void printState() {
        System.out.println("State: X: " + getLeftX() + "; O: " + getLeftO());
    }

    boolean move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();
        System.out.printf("Tile (%s; %s):\n", (r+1), abc[c]);
        if (!withinPlayground(r, c)) {
            System.out.println("Move out of bounds");
            return false;
        }
        if (playground[r][c] != Player.NONE) {
            System.out.println("Not valid move. The tile is not empty");
            return false;
        }
        if (winner != Player.NONE) return false;

        ArrayList<ArrayList<Integer>> tilesToFlip = validToFlip(r, c);
        if (tilesToFlip.size() == 0) {
            System.out.println("Not valid move");
            return false;
        }
        flipTiles(tilesToFlip);

        onTurn = getOppositePlayer(onTurn);
        System.out.println("Valid move");
        printPlayground();
        printState();
        return true;
    }

    private boolean withinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    private ArrayList<ArrayList<Integer>> validToFlip(int r0, int c0) {
        ArrayList<ArrayList<Integer>> toFLip = new ArrayList<>();
        playground[r0][c0] = onTurn;

        Player opposite = getOppositePlayer(onTurn);
        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int r = r0;
            int c = c0;
            r += direction[0];
            c += direction[1];
            if (withinPlayground(r, c) && playground[r][c] == opposite) {
                r += direction[0];
                c += direction[1];
                if (!withinPlayground(r, c)) continue;
                while (playground[r][c] == opposite) {
                    r += direction[0];
                    c += direction[1];
                    if (!withinPlayground(r, c)) break;
                }
                if (!withinPlayground(r, c)) continue;
                if (playground[r][c] == onTurn) {
                    while (true) {
                        r -= direction[0];
                        c -= direction[1];
                        if (r == r0 && c == c0) {
                            break;
                        }
                        toFLip.add(new ArrayList<>(List.of(r, c)));
                    }
                }
            }
        }

        playground[r0][c0] = Player.NONE;
        if (toFLip.size() != 0) toFLip.add(new ArrayList<>(List.of(r0, c0)));
        return toFLip;
    }

    private void flipTiles(ArrayList<ArrayList<Integer>> tiles) {
        tiles.forEach(tile -> {
            Player previous =  playground[tile.get(0)][tile.get(1)];
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

    ArrayList<ArrayList<Integer>> getPossibleMoves() {
        ArrayList<ArrayList<Integer>> tiles = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    if (validToFlip(r,c).size() != 0) {
                        tiles.add(new ArrayList<>(List.of(r, c)));
                    }
                }
            }
        }
        System.out.println(tiles);
        return tiles;
    }

    boolean areValidMoves() {
        return getPossibleMoves().size() != 0;
    }

    void gameOver() {
        printState();
        if (getLeftX() > getLeftO()) winner = Player.X;
        else if (getLeftO() > getLeftX()) winner = Player.O;
    }

}
