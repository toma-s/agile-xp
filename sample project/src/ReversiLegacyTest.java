import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class ReversiLegacyTest {

    private ReversiLegacy revLeg = new ReversiLegacy();

    @Test
    public void testInit() {
        ReversiLegacy game = revLeg;

        assertEquals("on turn", 1, game.onTurn);
        assertEquals("playground init", 0, game.playground[3][3]);
        assertEquals("playground init", 1, game.playground[3][4]);
        assertEquals("playground init", 1, game.playground[4][3]);
        assertEquals("playground init", 0, game.playground[4][4]);
    }

    @Test
    public void testNotValidMoves() {
        ReversiLegacy game = revLeg;

        assertFalse("move on not empty tile (e,5)", game.move(4,4));
        assertEquals("check if didn't change", 0, game.playground[4][4]);

        assertFalse("move on tile out of bounds (a,10)", game.move(0,10));

        assertFalse("not valid move (a,1)", game.move(0,0));
        assertEquals("check if didn't change", -1, game.playground[0][0]);
    }

    @Test
    public void testFlipRight() {
        ReversiLegacy game = revLeg;
        assertTrue("move to flip", game.move(3, 2));
        assertEquals("check if flipped", 1, game.playground[3][3]);
        assertEquals("check if flipped", 1, game.playground[3][2]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipUp() {
        ReversiLegacy game = revLeg;
        assertTrue("move to flip", game.move(5, 4));
        assertEquals("check if flipped", 1, game.playground[4][4]);
        assertEquals("check if flipped", 1, game.playground[5][4]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipLeft() {
        ReversiLegacy game = revLeg;
        assertTrue("move to flip", game.move(4, 5));
        assertEquals("check if flipped", 1, game.playground[4][4]);
        assertEquals("check if flipped", 1, game.playground[4][5]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipDown() {
        ReversiLegacy game = revLeg;
        assertTrue("move to flip", game.move(2, 3));
        assertEquals("check if flipped", 1, game.playground[3][3]);
        assertEquals("check if flipped", 1, game.playground[2][3]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipRightUp() {
        ReversiLegacy game = revLeg;
        assertTrue("move to flip", game.move(5, 4));
        assertEquals("check if flipped", 1, game.playground[4][4]);
        assertEquals("check if flipped", 1, game.playground[5][4]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);

        assertTrue("move to flip", game.move(5, 3));
        assertEquals("check if flipped", 0, game.playground[4][3]);
        assertEquals("check if flipped", 0, game.playground[5][3]);
        assertEquals("check on turn", 1, game.onTurn);
        assertEquals("O left", 3, game.leftO);
        assertEquals("X left", 3, game.leftX);

        assertTrue("move to flip", game.move(6, 2));
        assertEquals("check if flipped", 1, game.playground[5][3]);
        assertEquals("check if flipped", 1, game.playground[6][2]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 2, game.leftO);
        assertEquals("X left", 5, game.leftX);
    }

    @Test
    public void testFlipLeftUp() {
        ReversiLegacy game = revLeg;
        assertTrue("move to flip", game.move(5, 4));
        assertEquals("check if flipped", 1, game.playground[4][4]);
        assertEquals("check if flipped", 1, game.playground[5][4]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);

        assertTrue("move to flip", game.move(5, 5));
        assertEquals("check if flipped", 0, game.playground[4][4]);
        assertEquals("check if flipped", 0, game.playground[5][5]);
        assertEquals("check on turn", 1, game.onTurn);
        assertEquals("O left", 3, game.leftO);
        assertEquals("X left", 3, game.leftX);
    }

    @Test
    public void testFlipLeftDown() {
        ReversiLegacy game = revLeg;
        assertTrue("move to flip", game.move(2, 3));
        assertEquals("check if flipped", 1, game.playground[3][3]);
        assertEquals("check if flipped", 1, game.playground[2][3]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);

        assertTrue("move to flip", game.move(2, 4));
        assertEquals("check if flipped", 0, game.playground[3][4]);
        assertEquals("check if flipped", 0, game.playground[2][4]);
        assertEquals("check on turn", 1, game.onTurn);
        assertEquals("O left", 3, game.leftO);
        assertEquals("X left", 3, game.leftX);

        assertTrue("move to flip", game.move(1, 5));
        assertEquals("check if flipped", 1, game.playground[2][4]);
        assertEquals("check if flipped", 1, game.playground[1][5]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 2, game.leftO);
        assertEquals("X left", 5, game.leftX);
    }

    @Test
    public void testFlipRightDown() {
        ReversiLegacy game = revLeg;
        assertTrue("move to flip", game.move(2, 3));
        assertEquals("check if flipped", 1, game.playground[3][3]);
        assertEquals("check if flipped", 1, game.playground[2][3]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);

        assertTrue("move to flip", game.move(2, 2));
        assertEquals("check if flipped", 0, game.playground[3][3]);
        assertEquals("check if flipped", 0, game.playground[2][2]);
        assertEquals("check on turn", 1, game.onTurn);
        assertEquals("O left", 3, game.leftO);
        assertEquals("X left", 3, game.leftX);
    }

    @Test
    public void testDoubleFlip() {
        ReversiLegacy game = revLeg;

        assertTrue(game.move(2, 3));
        assertTrue(game.move(2, 2));
        assertTrue(game.move(3, 2));
        assertTrue(game.move(2, 4));

        assertEquals("check if flipped (2,3) correctly",0, game.playground[2][3]);
        assertEquals("check if flipped (3,4) correctly",0, game.playground[3][4]);
        assertEquals("O left", 5, game.leftO);
        assertEquals("X left", 3, game.leftX);
    }
}
