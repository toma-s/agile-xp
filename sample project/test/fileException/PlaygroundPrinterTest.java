package fileException;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }


    // hints

    @Test
    public void testPrintHints8bInit() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ _ B W o _ _ " + System.lineSeparator() +
                "5 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8wInit() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ o _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ o B W _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints10bInit() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "4 _ _ _ o W B _ _ _ _ " + System.lineSeparator() +
                "5 _ _ _ _ B W o _ _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ o _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bAlmostComplete() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B W B B W W B B " + System.lineSeparator() +
                "1 W W B W B W W W " + System.lineSeparator() +
                "2 B W B W B B W B " + System.lineSeparator() +
                "3 W W B B o W W B " + System.lineSeparator() +
                "4 B B B W B B B B " + System.lineSeparator() +
                "5 W W B W W W W W " + System.lineSeparator() +
                "6 B B B W B B W B " + System.lineSeparator() +
                "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHints8bComplete() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 B B B B B B B B " + System.lineSeparator() +
                "1 B W W W W W W B " + System.lineSeparator() +
                "2 B W W B W B W B " + System.lineSeparator() +
                "3 B B W W B W B B " + System.lineSeparator() +
                "4 B B B W B B W B " + System.lineSeparator() +
                "5 B B W W B W W B " + System.lineSeparator() +
                "6 B B B B B B W B " + System.lineSeparator() +
                "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintHintsExecuteB54() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ _ W B o _ _ " + System.lineSeparator() +
                "4 _ _ _ B B _ _ _ " + System.lineSeparator() +
                "5 _ _ _ o B o _ _ " + System.lineSeparator() +
                "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }

    @Test
    public void testPrintHintsExecuteB54W53() throws IncorrectGameConfigFileException {
        Reversi reversi = new Reversi(GameConfig.game8bInit);
        reversi.execute("5 4");
        reversi.execute("5 3");
        PlaygroundPrinter.printHints(reversi.playground, reversi.size, reversi.getPossibleMoves());
        String expected = "Possible moves:" + System.lineSeparator() +
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                "2 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "3 _ _ o W B _ _ _ " + System.lineSeparator() +
                "4 _ _ o W B _ _ _ " + System.lineSeparator() +
                "5 _ _ o W B _ _ _ " + System.lineSeparator() +
                "6 _ _ o _ _ _ _ _ " + System.lineSeparator() +
                "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertTrue(outContent.toString().contains(expected));
    }
}
