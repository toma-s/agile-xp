package left;

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

    // setOnTurnInputCorrect

    @Test
    public void testIsOnTurnInputCorrectB() {
        Reversi game = rev;

        assertTrue("on turn value of config file: B", game.isOnTurnInputCorrect("B"));
    }

    @Test
    public void testIsOnTurnInputCorrectW() {
        Reversi game = rev;

        assertTrue("on turn value of config file: W", game.isOnTurnInputCorrect("W"));
    }

    @Test
    public void testIsOnTurnInputCorrectA() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("A"));
    }

    @Test
    public void testIsOnTurnInputCorrectNONE() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("NONE"));
    }

    @Test
    public void testIsOnTurnInputCorrectnull() {
        Reversi game = rev;

        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect(null));
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
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
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
        assertFalse("piece input: D3", game.isPieceInputCorrect("D 3"));
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

        assertEquals("set player B on piece 00", Player.B, TestUtils.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 0}, Player.B);

        Player[][] expectedPlayground = InitGameTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece08() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 8}, Player.B);

        Player[][] expectedPlayground = InitGameTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece88() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 8}, Player.B);

        Player[][] expectedPlayground = InitGameTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[] {"one"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() {
        String[] gameConfig = new String[] {"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGamer

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
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

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
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

    static Player[][] getInitPlayground() {
        Player[][] init = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = Player.NONE;
            }
        }
        init[3][3] = Player.W;
        init[4][4] = Player.W;
        init[3][4] = Player.B;
        init[4][3] = Player.B;
        return init;
    }

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }
}