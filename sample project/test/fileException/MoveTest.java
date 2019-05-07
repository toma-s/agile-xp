package fileException;

import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MoveTest {

    @Test
    public void testMoveOnNotEmpty() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn't change", ReversiTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn't change", ReversiTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn't change", ReversiTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn't change", ReversiTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = ReversiTest.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = ReversiTest.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, InitGameTest.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, InitGameTest.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = ReversiTest.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, InitGameTest.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = ReversiTest.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, InitGameTest.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, InitGameTest.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = ReversiTest.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, InitGameTest.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, InitGameTest.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }

    @Test
    public void testMovesCompleteGame() throws IncorrectGameConfigFileException {
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
        Reversi game = ReversiTest.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
        Assert.assertEquals("winner", Player.B, game.winner);
    }
}