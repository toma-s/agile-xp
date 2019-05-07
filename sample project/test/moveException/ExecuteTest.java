package moveException;

import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

public class ExecuteTest {

    @Test
    public void testExecute32() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        assertEquals("check if flipped", Player.B, ReversiTest.getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.B, ReversiTest.getPiece(game, 3, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn't change", ReversiTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testExecuteFinishGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 39, game.getLeftW());
        assertEquals("B left", 25, game.getLeftB());
        assertEquals("winner", Player.W, game.winner);
    }

}