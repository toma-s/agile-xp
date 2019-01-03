import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class ReversiTest {
    private Reversi rev = new Reversi();

    @Test
    public void testInit() {
        Reversi game = rev;
        assertEquals("on turn", Player.X, game.getOnTurn());
        assertEquals("playground init", Player.O, game.getTile(Alpha.D, 4));
        assertEquals("playground init", Player.X, game.getTile(Alpha.E, 4));
        assertEquals("playground init", Player.X, game.getTile(Alpha.D, 5));
        assertEquals("playground init", Player.O, game.getTile(Alpha.E, 5));
        assertEquals("left X init", 2, game.getLeftX());
        assertEquals("left O init", 2, game.getLeftO());
    }

    @Test
    public void testInitValidMoves() {
        Reversi game = rev;
        ArrayList<ArrayList<Integer>> tiles = game.getPossibleMoves();
        assertEquals("valid length", 4, tiles.size());
        assertEquals("valid moves", List.of(2, 3), tiles.get(0));
        assertEquals("valid moves", List.of(3, 2), tiles.get(1));
        assertEquals("valid moves", List.of(4, 5), tiles.get(2));
        assertEquals("valid moves", List.of(5, 4), tiles.get(3));
    }

    @Test
    public void testNotValidMoves() {
        Reversi game = rev;

        assertFalse("move on not empty tile (e,5)", game.move(Alpha.E,5));
        assertEquals("check if didn't change", Player.O, game.getTile(Alpha.E, 5));

        assertFalse("move on tile out of bounds (a,10)", game.move(Alpha.A,10));

        assertFalse("not valid move (a,1)", game.move(Alpha.A,1));
        assertEquals("check if didn't change", Player.NONE, game.getTile(Alpha.A, 1));
    }

    @Test
    public void testFlipRight() {
        Reversi game = rev;

        assertTrue("move to flip (c,4)", game.move(Alpha.C,4));
        assertEquals("check if flipped",Player.X, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.X, game.getTile(Alpha.C, 4));

        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());
    }

    @Test
    public void testFlipUp() {
        Reversi game = rev;

        assertTrue("move to flip", game.move(Alpha.E, 6));
        assertEquals("check if flipped",Player.X, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", Player.X, game.getTile(Alpha.E, 6));

        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());
    }

    @Test
    public void testFlipLeft() {
        Reversi game = rev;

        assertTrue("move to flip", game.move(Alpha.F, 5));
        assertEquals("check if flipped",Player.X, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", Player.X, game.getTile(Alpha.F, 5));

        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());
    }

    @Test
    public void testFlipDown() {
        Reversi game = rev;

        assertTrue("move to flip", game.move(Alpha.D, 3));
        assertEquals("check if flipped",Player.X, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.X, game.getTile(Alpha.D, 3));

        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());
    }

    @Test
    public void testFlipRightUp() {
        Reversi game = rev;

        assertTrue("move to flip", game.move(Alpha.E, 6));
        assertEquals("check if flipped",Player.X, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", Player.X, game.getTile(Alpha.E, 6));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());

        assertTrue("move to flip", game.move(Alpha.D, 6));
        assertEquals("check if flipped",Player.O, game.getTile(Alpha.D, 5));
        assertEquals("check if flipped", Player.O, game.getTile(Alpha.D, 6));
        assertEquals("on turn", Player.X, game.getOnTurn());
        assertEquals("O left", 3, game.getLeftO());
        assertEquals("X left", 3, game.getLeftX());

        assertTrue("move to flip", game.move(Alpha.C, 7));
        assertEquals("check if flipped",Player.X, game.getTile(Alpha.D, 6));
        assertEquals("check if flipped", Player.X, game.getTile(Alpha.C, 7));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 2, game.getLeftO());
        assertEquals("X left", 5, game.getLeftX());
    }

    @Test
    public void testFlipLeftUp() {
        Reversi game = rev;

        assertTrue("move to flip", game.move(Alpha.E, 6));
        assertEquals("check if flipped",Player.X, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", Player.X, game.getTile(Alpha.E, 6));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());

        assertTrue("move to flip", game.move(Alpha.F, 6));
        assertEquals("check if flipped",Player.O, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", Player.O, game.getTile(Alpha.F, 6));
        assertEquals("on turn", Player.X, game.getOnTurn());
        assertEquals("O left", 3, game.getLeftO());
        assertEquals("X left", 3, game.getLeftX());
    }

    @Test
    public void testFlipLeftDown() {
        Reversi game = rev;

        assertTrue("move to flip", game.move(Alpha.D, 3));
        assertEquals("check if flipped",Player.X, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.X, game.getTile(Alpha.D, 3));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());

        assertTrue("move to flip", game.move(Alpha.E, 3));
        assertEquals("check if flipped",Player.O, game.getTile(Alpha.E, 4));
        assertEquals("check if flipped", Player.O, game.getTile(Alpha.E, 3));
        assertEquals("on turn", Player.X, game.getOnTurn());
        assertEquals("O left", 3, game.getLeftO());
        assertEquals("X left", 3, game.getLeftX());

        assertTrue("move to flip", game.move(Alpha.F, 2));
        assertEquals("check if flipped",Player.X, game.getTile(Alpha.E, 3));
        assertEquals("check if flipped", Player.X, game.getTile(Alpha.F, 2));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 2, game.getLeftO());
        assertEquals("X left", 5, game.getLeftX());
    }

    @Test
    public void testFlipRightDown() {
        Reversi game = rev;

        assertTrue("move to flip", game.move(Alpha.D, 3));
        assertEquals("check if flipped",Player.X, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.X, game.getTile(Alpha.D, 3));
        assertEquals("on turn", Player.O, game.getOnTurn());
        assertEquals("O left", 1, game.getLeftO());
        assertEquals("X left", 4, game.getLeftX());

        assertTrue("move to flip", game.move(Alpha.C, 3));
        assertEquals("check if flipped",Player.O, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.O, game.getTile(Alpha.C, 3));
        assertEquals("on turn", Player.X, game.getOnTurn());
        assertEquals("O left", 3, game.getLeftO());
        assertEquals("X left", 3, game.getLeftX());
    }

    @Test
    public void testDoubleFlip() {
        Reversi game = rev;

        assertTrue(game.move(Alpha.D, 3));
        assertTrue(game.move(Alpha.C, 3));
        assertTrue(game.move(Alpha.C, 4));
        assertTrue(game.move(Alpha.E, 3));

        assertEquals("check if flipped (D,3) correctly",Player.O, game.getTile(Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly",Player.O, game.getTile(Alpha.E, 4));
        assertEquals("O left", 5, game.getLeftO());
        assertEquals("X left", 3, game.getLeftX());
    }

    @Test
    public void testGame1() {
        Reversi game = rev;

        assertTrue("if the are valid moves", game.areValidMoves());

        assertTrue(game.move(Alpha.E, 6)); assertTrue(game.move(Alpha.F, 4)); assertTrue(game.move(Alpha.D, 3));
        assertTrue(game.move(Alpha.C, 4)); assertTrue(game.move(Alpha.C, 3)); assertTrue(game.move(Alpha.D, 6));
        assertTrue(game.move(Alpha.E, 3)); assertTrue(game.move(Alpha.C, 2)); assertTrue(game.move(Alpha.B, 3));
        assertTrue(game.move(Alpha.F, 5)); assertTrue(game.move(Alpha.F, 3)); assertTrue(game.move(Alpha.D, 2));

        assertEquals("O left", 7, game.getLeftO());
        assertEquals("X left", 9, game.getLeftX());

        assertTrue(game.move(Alpha.E, 2)); assertTrue(game.move(Alpha.B, 4)); assertTrue(game.move(Alpha.C, 5));
        assertTrue(game.move(Alpha.F, 1)); assertTrue(game.move(Alpha.A, 3)); assertTrue(game.move(Alpha.F, 2));
        assertTrue(game.move(Alpha.C, 6)); assertTrue(game.move(Alpha.F, 6)); assertTrue(game.move(Alpha.G, 6));
        assertTrue(game.move(Alpha.A, 5)); assertTrue(game.move(Alpha.B, 5)); assertTrue(game.move(Alpha.A, 6));

        assertEquals("O left", 17, game.getLeftO());
        assertEquals("X left", 11, game.getLeftX());

        assertTrue(game.move(Alpha.G, 5)); assertTrue(game.move(Alpha.C, 7)); assertTrue(game.move(Alpha.G, 3));
        assertTrue(game.move(Alpha.D, 7)); assertTrue(game.move(Alpha.E, 7)); assertTrue(game.move(Alpha.H, 4));
        assertTrue(game.move(Alpha.D, 8)); assertTrue(game.move(Alpha.G, 4)); assertTrue(game.move(Alpha.A, 4));
        assertTrue(game.move(Alpha.A, 2)); assertTrue(game.move(Alpha.H, 2)); assertTrue(game.move(Alpha.H, 3));

        assertEquals("O left", 23, game.getLeftO());
        assertEquals("X left", 17, game.getLeftX());

        assertTrue(game.move(Alpha.H, 5)); assertTrue(game.move(Alpha.B, 6)); assertTrue(game.move(Alpha.C, 8));
        assertTrue(game.move(Alpha.F, 7)); assertTrue(game.move(Alpha.E, 8)); assertTrue(game.move(Alpha.B, 7));
        assertTrue(game.move(Alpha.C, 1)); assertTrue(game.move(Alpha.H, 6)); assertTrue(game.move(Alpha.H, 7));
        assertTrue(game.move(Alpha.D, 1)); assertTrue(game.move(Alpha.A, 8)); assertTrue(game.move(Alpha.B, 1));

        assertTrue("if the are valid moves", game.areValidMoves());
        assertEquals("O left", 27, game.getLeftO());
        assertEquals("X left", 25, game.getLeftX());

        assertTrue(game.move(Alpha.A, 7)); assertTrue(game.move(Alpha.F, 8)); assertTrue(game.move(Alpha.G, 2));
        assertTrue(game.move(Alpha.H, 1)); assertTrue(game.move(Alpha.G, 1)); assertTrue(game.move(Alpha.H, 8));
        assertTrue(game.move(Alpha.E, 1)); assertTrue(game.move(Alpha.B, 8)); assertTrue(game.move(Alpha.A, 1));
        assertTrue(game.move(Alpha.B, 2)); assertTrue(game.move(Alpha.G, 8)); assertTrue(game.move(Alpha.G, 7));

        assertFalse("if the are valid moves", game.areValidMoves());
        game.gameOver();
        assertEquals("winner", Player.X, game.getWinner());
        assertEquals("O left", 28, game.getLeftO());
        assertEquals("X left", 36, game.getLeftX());
        assertFalse("game is over", game.move(Alpha.A, 1));
    }
}
