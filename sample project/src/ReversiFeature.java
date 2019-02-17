import java.util.ArrayList;
import java.util.List;

class ReversiFeature {

    public int[][] playground = new int[8][8];
    public int onTurn = 1;
    public int winner = -1;
    public int leftO = 2;
    public int leftX = 2;
    private String[] abc = "abcdefgh".split("");

    ReversiFeature() {
        initPlayground();
        printPlayground();
        printOnTurn();
    }

    int getTile(Alpha c0, int r0) {
        return playground[r0-1][c0.getValue()];
    }

    private void initPlayground() {
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                playground[r][c] = -1;
            }
        }
        playground[8/2-1][8/2-1] = 1 - onTurn;
        playground[8/2-1][8/2] = onTurn;
        playground[8/2][8/2] = 1 - onTurn;
        playground[8/2][8/2-1] = onTurn;
    }

    private void printPlayground() {
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r < 8; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] == -1)
                    System.out.print("_ ");
                else if (playground[r][c] == 1)
                    System.out.print("X ");
                else
                    System.out.print("O ");
            }
            System.out.println();
        }
    }

    private void printOnTurn() {
        if (onTurn == 0)
            System.out.println("On turn: O");
        else
            System.out.println("On turn: X");
    }

    private void printState() {
        System.out.printf("Number of tiles: X: %s; O: %s\n\n", leftX, leftO);
    }

//    boolean move(int r, int c) {
    boolean move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();

        if (r == 7 && c == 7) {
            System.out.println();
        }
        System.out.printf("Move on tile (%s; %s):\n\n", r, c);
        if (winner != -1) {
            System.out.println("The game isn't running");
            return false;
        }

        boolean valid = isValidMove(r, c, true);
        if (valid) {
            if (onTurn == 1) onTurn = 0;
            else if (onTurn == 0) onTurn = 1;
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
        int opposite = 1 ^ onTurn;
        boolean valid = false;  // debugging [1]

//        if (playground[r][c] == -1) { // original
        if (r >= 0 && c >= 0 && r < 8 && c < 8 && playground[r][c] == -1) { // debugging [2]
            int step = 1;
            ArrayList<ArrayList<Integer>> toFlip = new ArrayList<>();

            // right
            if (c + step < 8 && playground[r][c + step] == opposite) {
                while (c + step < 8 && playground[r][c + step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c + step)));
                    }
                    step++;
                }
                if (step > 1 && c + step < 8 && playground[r][c + step] != -1) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [3]
//                    return true; // original
                }
            }
            // right up
            step = 1;
            toFlip = new ArrayList<>();
            if (r - step > 0 && c + step < 8 && playground[r - step][c + step] == opposite) {
                while (r - step > 0 && c + step < 8 && playground[r - step][c + step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r - step, c + step)));
                    }
                    step++;
                }
                if (step > 1 && r - step >= 0 && c + step < 8 && playground[r - step][c + step] != -1) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [3]
//                    return true; // original
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
                if (step > 1 && r - step >= 0 && playground[r - step][c] != -1) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [3]
//                    return true; // original
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
                if (step > 1 && r - step >= 0 && c - step >= 0 && playground[r - step][c - step] != -1) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [3]
//                    return true; // original
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
                if (step > 1 && c - step >= 0 && playground[r][c - step] != -1) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [3]
//                    return true; // original
                }
            }
            // left down
            step = 1;
            toFlip = new ArrayList<>();
            if (r + step <= 7 && c - step > 0 && playground[r + step][c - step] == opposite) {
                while (r + step <= 7 && c - step > 0 && playground[r + step][c - step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r + step, c - step)));
                    }
                    step++;
                }
                if (step > 1 && r + step <= 7 && c - step >= 0 && playground[r + step][c - step] != -1) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [3]
//                    return true; // original
                }
            }
            // down
            step = 1;
            toFlip = new ArrayList<>();
            if (r + step < 8 && playground[r + step][c] == opposite) {
                while (r + step < 8 && playground[r + step][c] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r + step, c)));
                    }
                    step++;
                }
                if (step > 1 && r + step < 8 && playground[r + step][c] != -1) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [3]
//                    return true; // original
                }
            }
            // right down
            step = 1;
            toFlip = new ArrayList<>();
            if (r + step < 8 && c + step < 8 && playground[r + step][c + step] == opposite) {
                while (r + step < 8 && c + step < 8 && playground[r + step][c + step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r + step, c + step)));
                    }
                    step++;
                }
                if (step > 1 && r + step < 8 && c + step < 8 && playground[r + step][c + step] != -1) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c)));
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [3]
//                    return true; // original
                }
            }
        } else {
            return valid; // debugging [3]
//            return false; // debugging [1]
//            return true; // original
        }
//        return true; // original
        return valid;  // debugging
    }

    private void flipTiles(ArrayList<ArrayList<Integer>> toFlip) {
        for (int i = 0; i < toFlip.size(); i++) {
            ArrayList<Integer> tile = toFlip.get(i);
            int r = tile.get(0);
            int c = tile.get(1);
            if (playground[r][c] == onTurn) break; // debugging [4]
            if (playground[r][c] == -1) {
                playground[r][c] = onTurn;
                if (onTurn == 1) leftX++;
                else if (onTurn == 0) leftO++;
            } else {
                playground[r][c] = onTurn;
                if (onTurn == 1) {
                    leftX++;
                    leftO--;
                } else {
                    leftO++;
                    leftX--;
                }
            }
        }
    }

    boolean areValidMoves() {
        ArrayList<ArrayList<Integer>> tiles = new ArrayList<>();
        for (int r = 0; r <= 7; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] == -1) {
                    if (isValidMove(r, c, false)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    void gameOver() {
        printState();
        if (leftX > leftO) winner = 1;
        else if (leftO > leftX) winner = 0;
    }

}
