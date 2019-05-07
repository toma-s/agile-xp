package oneThing;

import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertArrayEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();

    
    //setSize

    @Test
    public void testSetSize8() {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() {
        Reversi game = rev;
        game.setSize("-8");

        assertEquals("set size -8", 0, game.size);
    }

    @Test
    public void testSetSizeA() {
        Reversi game = rev;
        game.setSize("A");

        assertEquals("set size A", 0, game.size);
    }


    // setOnTurn

    @Test
    public void testSetOnTurnB() {
        Reversi game = rev;
        game.setOnTurn("B");

        assertEquals("set player on turn: B", Player.B, game.onTurn);
    }

    @Test
    public void testSetOnTurnW() {
        Reversi game = rev;
        game.setOnTurn("W");

        assertEquals("set player on turn: W", Player.W, game.onTurn);
    }

    @Test
    public void testSetOnTurnA() {
        Reversi game = rev;
        game.setOnTurn("A");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnNone() {
        Reversi game = rev;
        game.setOnTurn("NONE");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnnull() {
        Reversi game = rev;
        game.setOnTurn(null);

        assertEquals(Player.NONE, game.onTurn);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = ReversiTest.getRevWithPlayground();

        assertArrayEquals("create empty playground", ReversiTest.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D 3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, ReversiTest.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 0}, Player.B);

        Player[][] expectedPlayground = ReversiTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece08() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 8}, Player.B);

        Player[][] expectedPlayground = ReversiTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece88() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 8}, Player.B);

        Player[][] expectedPlayground = ReversiTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = ReversiTest.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, ReversiTest.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, ReversiTest.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, ReversiTest.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, ReversiTest.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[]{"one"};
        Reversi game = ReversiTest.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = ReversiTest.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = ReversiTest.getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = ReversiTest.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = ReversiTest.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = ReversiTest.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, ReversiTest.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, ReversiTest.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, ReversiTest.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, ReversiTest.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, ReversiTest.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, ReversiTest.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, ReversiTest.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, ReversiTest.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, ReversiTest.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, ReversiTest.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, ReversiTest.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, ReversiTest.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFiveLines() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(ReversiTest.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoSize() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoPieces() {
        String[] gameConfig = new String[]{"8", "B"};
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