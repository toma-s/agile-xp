import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;

public class ReversiTest {

    // A JUnit 4 rule is a component that intercepts test method calls and
    // allows us to do something before a test method is run and after a
    // test method has been run.
    // The ExpectedException rule allows you to verify that your code throws
    // a specific exception.
    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testAssertEquals() {
        // JUnit 4 asserts examples
        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);

        int[] expectedArray = new int[] {1, 2, 3};
        int[] actualArray = new int[] {1, 2, 3};
        assertArrayEquals(expectedArray, actualArray);

        assertTrue(true);

        assertFalse(false);
    }

    @Test
    public void testInitialization() {
        // Reversi game initialization.
        // GameConfig stores paths to game configuration files
        Reversi game1 = new Reversi();
        Reversi game2 = new Reversi(GameConfig.game8bInit);
    }

    @Test
    public void testExpectedException() {
        expectedException.expect(ArithmeticException.class);
        expectedException.expectMessage("/ by zero");
        int result = 1 / 0;
    }

    // bug 1  (1)

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    // bug 1  (2)

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    // bug 2

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }



    private int[][] getInitPlayground() {
        int[][] init = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = -1;
            }
        }
        init[3][3] = 0;
        init[4][4] = 0;
        init[3][4] = 1;
        init[4][3] = 1;
        return init;
    }


}