import org.junit.Assert;
import org.junit.Test;

public class ExecuteTest {

    @Test
    public void testExecute32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn't change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }
}