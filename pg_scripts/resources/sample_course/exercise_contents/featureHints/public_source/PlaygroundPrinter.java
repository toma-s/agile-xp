import java.util.Collections;
import java.util.List;

class PlaygroundPrinter {

    static void printPlayground(int[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == -1) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }

    static void printMoveOnTurn(int onTurn) {
        System.out.format("Make a move. %s is on turn%n", onTurn);
    }

    static void printPiecesNumber(int leftB, int leftW) {
        System.out.printf("Number of pieces: B: %s; W: %s%n%n", leftB, leftW);
    }

}
