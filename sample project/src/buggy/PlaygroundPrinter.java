package buggy;

import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(int[][] playground) {
        printUpperEnumeration(8);
        for (int r = 0; r < 8; r++) {
            printLeftEnumeration(r, 8);
            for (int c = 0; c <= 7; c++) {
                if (playground[r][c] == -1) {
                    printPiece("_", 8);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", 8);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", 8);
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
}
