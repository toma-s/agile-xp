import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class ReversiRefactoredTest {
    private ReversiRefactored revRef = new ReversiRefactored();

    @Test
    public void testInit() {
        ReversiRefactored game = revRef;
        assertEquals("on turn", Player.X, game.getOnTurn());
        assertEquals("playground init", Player.O, game.getTile(3, 3));
        assertEquals("playground init", Player.X, game.getTile(3, 4));
        assertEquals("playground init", Player.X, game.getTile(4, 3));
        assertEquals("playground init", Player.O, game.getTile(4, 4));
        assertEquals("left X init", 2, game.getLeftX());
        assertEquals("left O init", 2, game.getLeftO());
    }

    @Test
    public void testInitValidMoves() {
        ReversiRefactored game = revRef;
        assertTrue("valid moves", game.areValidMoves());
    }

    @Test
    public void testNotValidMoves() {
        ReversiRefactored game = revRef;

        assertFalse("move on not empty tile (e,5)", game.move(4, 4));
        assertEquals("check if didn't change", Player.O, game.getTile(4, 4));

        assertFalse("move on tile out of bounds (a,9)", game.move(0, 8));
        assertFalse("move on tile out of bounds (a,0)", game.move(0, -1));

        assertFalse("not valid move (a,1)", game.move(0, 0));
        assertEquals("check if didn't change", Player.NONE, game.getTile(0, 0));
    }

    @Test
    public void testFlipRight() {
        ReversiRefactored game = revRef;

        assertTrue("move to flip (c,4)", game.move(3, 2));
        assertEquals("check if flipped",Player.X, game.getTile(3, 3));
        assertEquals("check if flipped", Player.X, game.getTile(3, 2));

        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());
    }

    @Test
    public void testFlipUp() {
        ReversiRefactored game = revRef;

        assertTrue("move to flip", game.move(5, 4));
        assertEquals("check if flipped",Player.X, game.getTile(4, 4));
        assertEquals("check if flipped", Player.X, game.getTile(5, 4));

        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());
    }

    @Test
    public void testFlipLeft() {
        ReversiRefactored game = revRef;

        assertTrue("move to flip", game.move(4, 5));
        assertEquals("check if flipped",Player.X, game.getTile(4, 4));
        assertEquals("check if flipped", Player.X, game.getTile(4, 5));

        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());
    }

    @Test
    public void testFlipDown() {
        ReversiRefactored game = revRef;

        assertTrue("move to flip", game.move(2, 3));
        assertEquals("check if flipped",Player.X, game.getTile(3, 3));
        assertEquals("check if flipped", Player.X, game.getTile(2, 3));

        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());
    }

    @Test
    public void testFlipRightUp() {
        ReversiRefactored game = revRef;

        assertTrue("move to flip", game.move(5, 4));
        assertEquals("check if flipped",Player.X, game.getTile(4, 4));
        assertEquals("check if flipped", Player.X, game.getTile(5, 4));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());

        assertTrue("move to flip", game.move(5, 3));
        assertEquals("check if flipped",Player.O, game.getTile(4, 3));
        assertEquals("check if flipped", Player.O, game.getTile(5, 3));
        assertEquals("on turn", Player.X, game.getOnTurn());
        assertEquals("O left", 3, game.getLeftO());
        assertEquals("X left", 3, game.getLeftX());

        assertTrue("move to flip", game.move(6, 2));
        assertEquals("check if flipped",Player.X, game.getTile(5, 3));
        assertEquals("check if flipped", Player.X, game.getTile(6, 2));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 2, game.getLeftO());
        assertEquals("X left", 5, game.getLeftX());
    }

    @Test
    public void testFlipLeftUp() {
        ReversiRefactored game = revRef;

        assertTrue("move to flip", game.move(5, 4));
        assertEquals("check if flipped",Player.X, game.getTile(4, 4));
        assertEquals("check if flipped", Player.X, game.getTile(5, 4));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());

        assertTrue("move to flip", game.move(5, 5));
        assertEquals("check if flipped",Player.O, game.getTile(4, 4));
        assertEquals("check if flipped", Player.O, game.getTile(5, 5));
        assertEquals("on turn", Player.X, game.getOnTurn());
        assertEquals("O left", 3, game.getLeftO());
        assertEquals("X left", 3, game.getLeftX());
    }

    @Test
    public void testFlipLeftDown() {
        ReversiRefactored game = revRef;

        assertTrue("move to flip", game.move(2, 3));
        assertEquals("check if flipped",Player.X, game.getTile(3, 3));
        assertEquals("check if flipped", Player.X, game.getTile(2, 3));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());

        assertTrue("move to flip", game.move(2, 4));
        assertEquals("check if flipped",Player.O, game.getTile(3, 4));
        assertEquals("check if flipped", Player.O, game.getTile(2, 4));
        assertEquals("on turn", Player.X, game.getOnTurn());
        assertEquals("O left", 3, game.getLeftO());
        assertEquals("X left", 3, game.getLeftX());

        assertTrue("move to flip", game.move(1, 5));
        assertEquals("check if flipped",Player.X, game.getTile(2, 4));
        assertEquals("check if flipped", Player.X, game.getTile(1, 5));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 2, game.getLeftO());
        assertEquals("X left", 5, game.getLeftX());
    }

    @Test
    public void testFlipRightDown() {
        ReversiRefactored game = revRef;

        assertTrue("move to flip", game.move(2, 3));
        assertEquals("check if flipped",Player.X, game.getTile(3, 3));
        assertEquals("check if flipped", Player.X, game.getTile(2, 3));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());

        assertTrue("move to flip", game.move(2, 2));
        assertEquals("check if flipped",Player.O, game.getTile(3, 3));
        assertEquals("check if flipped", Player.O, game.getTile(2, 2));
        assertEquals("on turn", Player.X, game.getOnTurn());
        assertEquals("O left", 3, game.getLeftO());
        assertEquals("X left", 3, game.getLeftX());
    }

    @Test
    public void testDoubleFlip() {
        ReversiRefactored game = revRef;

        assertTrue(game.move(2, 3));
        assertTrue(game.move(2, 2));
        assertTrue(game.move(3, 2));
        assertTrue(game.move(2, 4));

        assertEquals("check if flipped (D,3) correctly",Player.O, game.getTile(2, 3));
        assertEquals("check if flipped (E,4) correctly",Player.O, game.getTile(3, 4));
        assertEquals("O left", 5, game.getLeftO());
        assertEquals("X left", 3, game.getLeftX());
    }

    @Test
    public void testGame1() {
        ReversiRefactored game = revRef;

        assertTrue("if the are valid moves", game.areValidMoves());

        assertTrue(game.move(4, 5)); assertTrue(game.move(5, 3)); assertTrue(game.move(3, 2));
        assertTrue(game.move(2, 3)); assertTrue(game.move(2, 2)); assertTrue(game.move(3, 5));
        assertTrue(game.move(4, 2)); assertTrue(game.move(2, 1)); assertTrue(game.move(1, 2));
        assertTrue(game.move(5, 4)); assertTrue(game.move(5, 2)); assertTrue(game.move(3, 1));

        assertEquals("O left", 7, game.getLeftO());
        assertEquals("X left", 9, game.getLeftX());

        assertTrue(game.move(4, 1)); assertTrue(game.move(1, 3)); assertTrue(game.move(2, 4));
        assertTrue(game.move(5, 0)); assertTrue(game.move(0, 2)); assertTrue(game.move(5, 1));
        assertTrue(game.move(2, 5)); assertTrue(game.move(5, 5)); assertTrue(game.move(6, 5));
        assertTrue(game.move(0, 4)); assertTrue(game.move(1, 4)); assertTrue(game.move(0, 5));

        assertEquals("O left", 17, game.getLeftO());
        assertEquals("X left", 11, game.getLeftX());

        assertTrue(game.move(6, 4)); assertTrue(game.move(2, 6)); assertTrue(game.move(6, 2));
        assertTrue(game.move(3, 6)); assertTrue(game.move(4, 6)); assertTrue(game.move(7, 3));
        assertTrue(game.move(3, 7)); assertTrue(game.move(6, 3)); assertTrue(game.move(0, 3));
        assertTrue(game.move(0, 1)); assertTrue(game.move(7, 1)); assertTrue(game.move(7, 2));

        assertEquals("O left", 23, game.getLeftO());
        assertEquals("X left", 17, game.getLeftX());

        assertTrue(game.move(7, 4)); assertTrue(game.move(1, 5)); assertTrue(game.move(2, 7));
        assertTrue(game.move(5, 6)); assertTrue(game.move(4, 7)); assertTrue(game.move(1, 6));
        assertTrue(game.move(2, 0)); assertTrue(game.move(7, 5)); assertTrue(game.move(7, 6));
        assertTrue(game.move(3, 0)); assertTrue(game.move(0, 7)); assertTrue(game.move(1, 0));

        assertTrue("if the are valid moves", game.areValidMoves());
        assertEquals("O left", 27, game.getLeftO());
        assertEquals("X left", 25, game.getLeftX());

        assertTrue(game.move(0, 6)); assertTrue(game.move(5, 7)); assertTrue(game.move(6, 1));
        assertTrue(game.move(7, 0)); assertTrue(game.move(6, 0)); assertTrue(game.move(7, 7));
        assertTrue(game.move(4, 0)); assertTrue(game.move(1, 7)); assertTrue(game.move(0, 0));
        assertTrue(game.move(1, 1)); assertTrue(game.move(6, 7)); assertTrue(game.move(6, 6));

        assertFalse("if the are valid moves", game.areValidMoves());
        game.gameOver();
        assertEquals("winner", Player.X, game.getWinner());
        assertEquals("O left", 28, game.getLeftO());
        assertEquals("X left", 36, game.getLeftX());
        assertFalse("game is over", game.move(0, 1));
    }
}
