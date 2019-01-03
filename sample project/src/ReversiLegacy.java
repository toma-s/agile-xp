import java.util.ArrayList;
import java.util.List;

class ReversiLegacy {

    public int[][] playground = new int[8][8];
    public int onTurn = 1;
    public int winner = -1;
    public int leftO = 2;
    public int leftX = 2;

    ReversiLegacy() {
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                playground[r][c] = -1;
            }
        }
        playground[8/2-1][8/2-1] = 1 - onTurn;
        playground[8/2-1][8/2] = onTurn;
        playground[8/2][8/2] = 1 - onTurn;
        playground[8/2][8/2-1] = onTurn;
        printPlayground();
        printOnTurn();
    }

    private void printPlayground() {
        System.out.println("  0 1 2 3 4 5 6 7");
        for (int r = 0; r < 8; r++) {
            System.out.print(r  + " ");
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
        System.out.println("State: X: " + leftX + "; O: " + leftO);
    }

    boolean move(int r, int c) {
        System.out.printf("Tile (%s; %s):\n", r, c);
        if (winner != -1) {
            System.out.println("The game isn't running");
            return false;
        }

        boolean valid = check(r, c, true);
        if (valid) {
            if (onTurn == 1) onTurn = 0;
            else if (onTurn == 0) onTurn = 1;
            printPlayground();
            printState();
            return true;
        }
        System.out.println("Move is not valid");
        return false;
    }

    private boolean check(int r, int c, boolean flip) {
        int opposite = -1;
        if (onTurn == 1) opposite = 0;
        else if (onTurn == 0) opposite = 1;
        boolean valid = false;

        if (r <= 8 && c <= 8 && playground[r][c] == -1) {
            int step = 1;
            ArrayList<ArrayList<Integer>> toFlip = new ArrayList<>();

            // right
            if (c + step < 8 && playground[r][c + step] == opposite) {
                while (c + step < 8 && playground[r][c + step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r, c + step)));
                        step++;
                    }
                }
                if (step > 1 && c + step < 8 && playground[r][c + step] != -1) {
                    if (flip) {
                        turn(r, c);
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [1]
//                    return true; // commented out with intention
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
                if (step > 1 && r - step > 0 && c + step < 8 && playground[r - step][c + step] != -1) {
                    if (flip) {
                        turn(r, c);
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [1]
//                    return true; // commented out with intention
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
                if (step > 1 && r - step > 0 && playground[r - step][c] != -1) {
                    if (flip) {
                        turn(r, c);
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [1]
//                    return true; // commented out with intention
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
                if (step > 1 && r - step > 0 && c - step > 0 && playground[r - step][c - step] != -1) {
                    if (flip) {
                        turn(r, c);
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [1]
//                    return true; // commented out with intention
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
                if (step > 1 && c - step > 0 && playground[r][c - step] != -1) {
                    if (flip) {
                        turn(r, c);
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [1]
//                    return true; // commented out with intention
                }
            }
            // left down
            step = 1;
            toFlip = new ArrayList<>();
            if (r + step < 8 && c - step > 0 && playground[r + step][c - step] == opposite) {
                while (r + step < 8 && c - step > 0 && playground[r + step][c - step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r + step, c - step)));
                    }
                    step++;
                }
                if (step > 1 && r + step < 8 && c - step > 0 && playground[r + step][c - step] != -1) {
                    if (flip) {
                        turn(r, c);
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [1]
//                    return true; // commented out with intention
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
                        turn(r, c);
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [1]
//                    return true; // commented out with intention
                }
            }
            // right down
            step = 1;
            toFlip = new ArrayList<>();
            if (r + step < 8 && c + step > 0 && playground[r + step][c + step] == opposite) {
                while (r + step < 8 && c + step < 8 && playground[r + step][c + step] == opposite) {
                    if (flip) {
                        toFlip.add(new ArrayList<>(List.of(r + step, c + step)));
                    }
                    step++;
                }
                if (step > 1 && r + step < 8 && c + step < 8 && playground[r + step][c + step] != -1) {
                    if (flip) {
                        turn(r, c);
                        flipTiles(toFlip);
                    }
                    valid = true; // debugging [1]
//                    return true; // commented out with intention
                }
            }
        } else {
            valid = true; // debugging [1]
//            return false; // commented out with intention
        }
//        return true; // commented out with intention
        return valid;  // debugging
    }

    private void turn(int r, int c) {
        if (playground[r][c] == onTurn) return; // debugging [2]
        playground[r][c] = onTurn;
        if (onTurn == 1) leftX++;
        else if (onTurn == 0) leftO++;
    }

    private void flipTiles(ArrayList<ArrayList<Integer>> toFlip) {
//        int opposite = -1;
//        if (onTurn == 1) opposite = 0;
//        else if (onTurn == 0) opposite = 1;  // commented out with intention

        for (int i = 0; i < toFlip.size(); i++) {
            ArrayList<Integer> tile = toFlip.get(i);
            playground[tile.get(0)][tile.get(1)] = 1 ^ playground[tile.get(0)][tile.get(1)];
//            playground[tile.get(0)][tile.get(1)] = opposite; // commented out with intention
            if (onTurn == 1) {
                leftX++;
                leftO--;
            } else {
                leftO++;
                leftX--;
            }
        }
    }

    ArrayList<ArrayList<Integer>> getPossibleMoves() {
        ArrayList<ArrayList<Integer>> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] == -1) {
//                    if (validToFlip(r,c).size() != 0) {
//                        tiles.add(new ArrayList<>(List.of(r, c)));
//                    }
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
        if (leftX > leftO) winner = 1;
        else if (leftO > leftX) winner = 0;
    }

}
