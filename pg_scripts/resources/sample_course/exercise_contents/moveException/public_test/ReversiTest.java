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
    public void testInitialization() throws IncorrectGameConfigFileException {
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


}