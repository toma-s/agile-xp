package oneThing;

import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;

public class MoveTest {


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(3, 2);
        List<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("pieces to flip on onit - (3, 2)", 2, pieces.size());
        assertEquals(expected.get(0).get(0), pieces.get(0).get(0));
        assertEquals(expected.get(0).get(1), pieces.get(0).get(1));
        assertEquals(expected.get(1).get(0), pieces.get(1).get(0));
        assertEquals(expected.get(1).get(1), pieces.get(1).get(1));
    }

    @Test
    public void testGetPiecesToFlipInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        ArrayList<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals("...", Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals("...", Player.B, TestUtils.getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        ArrayList<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        ArrayList<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }

    // endGame

    @Test
    public void testEndGame() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        assertTrue(game.ended);
        assertEquals(Player.B, game.winner);
    }
    
    
    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn't change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn't change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn't change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn't change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
        Assert.assertEquals("winner", Player.B, game.winner);
    }
}