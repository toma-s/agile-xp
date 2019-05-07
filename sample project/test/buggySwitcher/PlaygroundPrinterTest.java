package buggySwitcher;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

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
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground);
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
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground);
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
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground);
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
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground);
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
}
