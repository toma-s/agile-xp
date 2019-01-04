import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class ReversiLegacyBuggyTest {

    private ReversiLegacyBuggy revLegBuggy = new ReversiLegacyBuggy();

    @Test
    public void testInit() {
        ReversiLegacyBuggy game = revLegBuggy;

        assertEquals("on turn", 1, game.onTurn);
        assertEquals("playground init", 0, game.playground[3][3]);
        assertEquals("playground init", 1, game.playground[3][4]);
        assertEquals("playground init", 1, game.playground[4][3]);
        assertEquals("playground init", 0, game.playground[4][4]);
    }

    @Test
    public void testNotValidMoves() {
        ReversiLegacyBuggy game = revLegBuggy;

        assertFalse("move on not empty tile (4,4)", game.move(4,4));
        assertEquals("check if didn't change", 0, game.playground[4][4]);

        assertFalse("move on tile out of bounds (0,8)", game.move(0,8));
        assertFalse("move on tile out of bounds (0,-1)", game.move(0,-1));

        assertFalse("not valid move (0,0)", game.move(0,0));
        assertEquals("check if didn't change", -1, game.playground[0][0]);
    }

    @Test
    public void testFlipRight() {
        ReversiLegacyBuggy game = revLegBuggy;
        assertTrue("move to flip", game.move(3, 2));
        assertEquals("check if flipped", 1, game.playground[3][3]);
        assertEquals("check if flipped", 1, game.playground[3][2]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipUp() {
        ReversiLegacyBuggy game = revLegBuggy;
        assertTrue("move to flip", game.move(5, 4));
        assertEquals("check if flipped", 1, game.playground[4][4]);
        assertEquals("check if flipped", 1, game.playground[5][4]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipLeft() {
        ReversiLegacyBuggy game = revLegBuggy;
        assertTrue("move to flip", game.move(4, 5));
        assertEquals("check if flipped", 1, game.playground[4][4]);
        assertEquals("check if flipped", 1, game.playground[4][5]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipDown() {
        ReversiLegacyBuggy game = revLegBuggy;
        assertTrue("move to flip", game.move(2, 3));
        assertEquals("check if flipped", 1, game.playground[3][3]);
        assertEquals("check if flipped", 1, game.playground[2][3]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipRightUp() {
        ReversiLegacyBuggy game = revLegBuggy;
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
        ReversiLegacyBuggy game = revLegBuggy;
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
        ReversiLegacyBuggy game = revLegBuggy;
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
        ReversiLegacyBuggy game = revLegBuggy;
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
        ReversiLegacyBuggy game = revLegBuggy;

        assertTrue(game.move(2, 3));
        assertTrue(game.move(2, 2));
        assertTrue(game.move(3, 2));
        assertTrue(game.move(2, 4));

        assertEquals("check if flipped (2,3) correctly",0, game.playground[2][3]);
        assertEquals("check if flipped (3,4) correctly",0, game.playground[3][4]);
        assertEquals("O left", 5, game.leftO);
        assertEquals("X left", 3, game.leftX);
    }

    @Test
    public void testGame1() {
        ReversiLegacyBuggy game = revLegBuggy;

        assertTrue("if the are valid moves", game.areValidMoves());

        assertTrue(game.move(4, 5)); assertTrue(game.move(5, 3)); assertTrue(game.move(3, 2));
        assertTrue(game.move(2, 3)); assertTrue(game.move(2, 2)); assertTrue(game.move(3, 5));
        assertTrue(game.move(4, 2)); assertTrue(game.move(2, 1)); assertTrue(game.move(1, 2));
        assertTrue(game.move(5, 4)); assertTrue(game.move(5, 2)); assertTrue(game.move(3, 1));

        assertEquals("O left", 7, game.leftO);
        assertEquals("X left", 9, game.leftX);

        assertTrue(game.move(4, 1)); assertTrue(game.move(1, 3)); assertTrue(game.move(2, 4));
        assertTrue(game.move(5, 0)); assertTrue(game.move(0, 2)); assertTrue(game.move(5, 1));
        assertTrue(game.move(2, 5)); assertTrue(game.move(5, 5)); assertTrue(game.move(6, 5));
        assertTrue(game.move(0, 4)); assertTrue(game.move(1, 4)); assertTrue(game.move(0, 5));

        assertEquals("O left", 17, game.leftO);
        assertEquals("X left", 11, game.leftX);

        assertTrue(game.move(6, 4)); assertTrue(game.move(2, 6)); assertTrue(game.move(6, 2));
        assertTrue(game.move(3, 6)); assertTrue(game.move(4, 6)); assertTrue(game.move(7, 3));
        assertTrue(game.move(3, 7)); assertTrue(game.move(6, 3)); assertTrue(game.move(0, 3));
        assertTrue(game.move(0, 1)); assertTrue(game.move(7, 1)); assertTrue(game.move(7, 2));

        assertEquals("O left", 23, game.leftO);
        assertEquals("X left", 17, game.leftX);

        assertTrue(game.move(7, 4)); assertTrue(game.move(1, 5)); assertTrue(game.move(2, 7));
        assertTrue(game.move(5, 6)); assertTrue(game.move(4, 7)); assertTrue(game.move(1, 6));
        assertTrue(game.move(2, 0)); assertTrue(game.move(7, 5)); assertTrue(game.move(7, 6));
        assertTrue(game.move(3, 0)); assertTrue(game.move(0, 7)); assertTrue(game.move(1, 0));

        assertTrue("if the are valid moves", game.areValidMoves());
        assertEquals("O left", 27, game.leftO);
        assertEquals("X left", 25, game.leftX);

        assertTrue(game.move(0, 6)); assertTrue(game.move(5, 7)); assertTrue(game.move(6, 1));
        assertTrue(game.move(7, 0)); assertTrue(game.move(6, 0)); assertTrue(game.move(7, 7));
        assertTrue(game.move(4, 0)); assertTrue(game.move(1, 7)); assertTrue(game.move(0, 0));
        assertTrue(game.move(1, 1)); assertTrue(game.move(6, 7)); assertTrue(game.move(6, 6));

        assertFalse("if the are valid moves", game.areValidMoves());
        game.gameOver();
        assertEquals("winner", 0, game.winner);
        assertEquals("O left", 33, game.leftO);
        assertEquals("X left", 31, game.leftX);
        assertFalse("game is over", game.move(0, 1));
    }
}
