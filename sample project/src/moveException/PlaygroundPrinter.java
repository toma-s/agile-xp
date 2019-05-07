package moveException;

import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r + 1, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", (i + 1)));
        }
        System.out.print("\n");
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size).length(), " ")));
    }
}
