import java.util.ArrayList;
import java.util.List;

class ReversiRefactoredProtected {

    private final int SIZE = 8;
    Player[][] playground = new Player[SIZE][SIZE];
    Player onTurn = Player.B;
    Player winner = Player.NONE;
    int leftW = 2;
    int leftB = 2;

    ReversiRefactoredProtected() {
        initPlayground();
        printPlayground();
        printOnTurn();
    }

    Player getTile(Alpha c0, int r0) {
        return playground[r0-1][c0.getValue()];
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
        String[] abc = "abcdefgh".split("");
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
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", leftB, leftW);
    }

    boolean move(Alpha c0, int r0){
        int r = r0 - 1;
        int c = c0.getValue();

        if (r == 7 && c == 7) {
            System.out.println();
        }
        System.out.printf("Move on tile (%s; %s):\n\n", r, c);
        if (winner != Player.NONE) {
            System.out.println("The game isn't running");
            return false;
        }

        boolean valid = isValidMove(r, c, true);
        if (valid) {
            if (onTurn == Player.B) onTurn = Player.W;
            else if (onTurn == Player.W) onTurn = Player.B;
            printPlayground();
            printState();
            return true;
        }
        System.out.println("Move is not valid");
        printPlayground();
        printState();
        return false;
    }

    private boolean isValidMove(int r, int c, boolean flip) {
        Player opposite = Player.NONE;
        if (onTurn == Player.W) opposite = Player.B;
        else if (onTurn == Player.B) opposite = Player.W;
        boolean valid = false;

        if (r >= 0 && c >= 0 && r < SIZE && c < SIZE && playground[r][c] == Player.NONE) {
            int step = 1;
            ArrayList<ArrayList<Integer>> toFlip = new ArrayList<>();

            // right
            if (c + step < SIZE && playground[r][c + step] == opposite) {
                while (c + step < SIZE && playground[r][c + step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c + step)));
                    }
                    step++;
                }
                if (step > 1 && c + step < SIZE && playground[r][c + step] != Player.NONE) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true;
                }
            }
            // right up
            step = 1;
            toFlip = new ArrayList<>();
            if (r - step > 0 && c + step < SIZE && playground[r - step][c + step] == opposite) {
                while (r - step > 0 && c + step < SIZE && playground[r - step][c + step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r - step, c + step)));
                    }
                    step++;
                }
                if (step > 1 && r - step >= 0 && c + step < SIZE && playground[r - step][c + step] != Player.NONE) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true;
                }
            }
            // up
            step = 1;
            toFlip = new ArrayList<>();
            if (r - step > 0 && playground[r - step][c] == opposite) {
                while (r - step > 0 && playground[r - step][c] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r - step, c)));
                    }
                    step++;
                }
                if (step > 1 && r - step >= 0 && playground[r - step][c] != Player.NONE) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true;
                }
            }
            // left up
            step = 1;
            toFlip = new ArrayList<>();
            if (r - step > 0 && c - step > 0 && playground[r - step][c - step] == opposite) {
                while (r - step > 0 && c - step > 0 && playground[r - step][c - step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r - step, c - step)));
                    }
                    step++;
                }
                if (step > 1 && r - step >= 0 && c - step >= 0 && playground[r - step][c - step] != Player.NONE) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true;
                }
            }
            // left
            step = 1;
            toFlip = new ArrayList<>();
            if (c - step > 0 && playground[r][c - step] == opposite) {
                while (c - step > 0 && playground[r][c - step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c - step)));
                    }
                    step++;
                }
                if (step > 1 && c - step >= 0 && playground[r][c - step] != Player.NONE) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true;
                }
            }
            // left down
            step = 1;
            toFlip = new ArrayList<>();
            if (r + step < SIZE && c - step > 0 && playground[r + step][c - step] == opposite) {
                while (r + step < SIZE && c - step > 0 && playground[r + step][c - step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r + step, c - step)));
                    }
                    step++;
                }
                if (step > 1 && r + step < SIZE && c - step >= 0 && playground[r + step][c - step] != Player.NONE) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true;
                }
            }
            // down
            step = 1;
            toFlip = new ArrayList<>();
            if (r + step < SIZE && playground[r + step][c] == opposite) {
                while (r + step < SIZE && playground[r + step][c] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r + step, c)));
                    }
                    step++;
                }
                if (step > 1 && r + step < SIZE && playground[r + step][c] != Player.NONE) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true;
                }
            }
            // right down
            step = 1;
            toFlip = new ArrayList<>();
            if (r + step < SIZE && c + step < SIZE && playground[r + step][c + step] == opposite) {
                while (r + step < SIZE && c + step < SIZE && playground[r + step][c + step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r + step, c + step)));
                    }
                    step++;
                }
                if (step > 1 && r + step < SIZE && c + step < SIZE && playground[r + step][c + step] != Player.NONE) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true;
                }
            }
        } else {
            return valid;
        }
        return valid;
    }

    private void flipTiles(ArrayList<ArrayList<Integer>> toFlip) {
        for (int i = 0; i < toFlip.size(); i++) {
            ArrayList<Integer> tile = toFlip.get(i);
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
        return getPossibleMoves().size() != 0;
    }

    ArrayList<ArrayList<Integer>> getPossibleMoves() {
        ArrayList<ArrayList<Integer>> tiles = new ArrayList<>();
        for (int r = 0; r < SIZE; r++) {
            for (int c = 0; c < SIZE; c++) {
                if (playground[r][c] != Player.NONE) {
                    continue;
                }
                if (isValidMove(r, c, false)) {
                    tiles.add(new ArrayList<>(List.of(r, c)));
                }
            }
        }
        System.out.println(tiles);
        return tiles;
    }

    void gameOver() {
        printState();
        if (leftB > leftW) winner = Player.B;
        else if (leftW > leftB) winner = Player.W;
    }

}
