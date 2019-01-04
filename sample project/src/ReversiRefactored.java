import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

class ReversiRefactored {

    private final int SIZE = 8;
    private Player[][] playground = new Player[SIZE][SIZE];
    private Player onTurn = Player.X;
    private Player winner = Player.NONE;
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

    int getLeftO() {
        return left.get(Player.O);
    }

    int getLeftX() {
        return left.get(Player.X);
    }

    Player getTile(int r, int c) {
        return playground[r][c];
    }

    Player getWinner() {
        return winner;
    }

    private void initGame() {
        left.put(Player.X, 2);
        left.put(Player.O, 2);
    }

    private void initPlayground() {
        for (int r = 0; r < SIZE; r++) {
            for (int c = 0; c < SIZE; c++) {
                playground[r][c] = Player.NONE;
            }
        }
        playground[SIZE/2-1][SIZE/2-1] = Player.O;
        playground[SIZE/2-1][SIZE/2] = Player.X;
        playground[SIZE/2][SIZE/2] = Player.O;
        playground[SIZE/2][SIZE/2-1] = Player.X;
    }

    private void printPlayground() {
        System.out.println("  0 1 2 3 4 5 6 7");
        for (int r = 0; r < SIZE; r++) {
            System.out.print(r  + " ");
            for (int c = 0; c < SIZE; c++) {
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
        System.out.printf("Number of tiles: X: %s; O: %s\n\n", getLeftX(), getLeftO());
    }

    boolean move(int r, int c) {
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

        if (onTurn == Player.O) onTurn = Player.X;
        else if (onTurn == Player.X) onTurn = Player.O;

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
        if (onTurn == Player.O) opposite = Player.X;
        else if (onTurn == Player.X) opposite = Player.O;
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
        ArrayList<ArrayList<Integer>> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != Player.NONE) {
                    continue;
                }
                if (getTilesToFlip(r,c).size() != 0) {
                    return true;
                }
            }
        }
        return false;
    }


    void gameOver() {
        printState();
        if (getLeftX() > getLeftO()) winner = Player.X;
        else if (getLeftO() > getLeftX()) winner = Player.O;
    }

}
