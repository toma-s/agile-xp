package fixed;

import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertArrayEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = ReversiTest.getRevWithPlayground();

        assertArrayEquals("create empty playground", ReversiTest.getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 1, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, ReversiTest.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, ReversiTest.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, ReversiTest.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, ReversiTest.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 0, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, ReversiTest.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, ReversiTest.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, ReversiTest.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, ReversiTest.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(ReversiTest.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoPieces() {
        String[] gameConfig = new String[]{"B"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        Assert.assertArrayEquals(null, game.playground);
    }
}