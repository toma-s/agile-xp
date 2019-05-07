package moveException;

import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    //setSize

    @Test
    public void testSetSize8() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect size input");
        game.setSize("-8");
    }

    @Test
    public void testSetSizeA() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect size input");
        game.setSize("A");
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
    public void testSetOnTurnB() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setOnTurn("B");

        assertEquals("set player on turn: B", Player.B, game.onTurn);
    }

    @Test
    public void testSetOnTurnW() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setOnTurn("W");

        assertEquals("set player on turn: W", Player.W, game.onTurn);
    }

    @Test
    public void testSetOnTurnA() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn("A");
    }

    @Test
    public void testSetOnTurnNone() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn("NONE");
    }

    @Test
    public void testSetOnTurnnull() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn(null);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = ReversiTest.getRevWithPlayground();

        assertArrayEquals("create empty playground", ReversiTest.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[] {0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, ReversiTest.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[] {8, 0}, Player.B);
    }

    @Test
    public void testSetPiece08() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[] {0, 8}, Player.B);
    }

    @Test
    public void testSetPiece88() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[] {8, 8}, Player.B);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() throws IncorrectGameConfigFileException {
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
    public void testFillPlaygroundConfigLen1() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"one"};
        Reversi game = ReversiTest.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(gameConfig);
    }

    @Test
    public void testFillPlaygroundNull() throws IncorrectGameConfigFileException {
        Reversi game = ReversiTest.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(null);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = ReversiTest.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.fillPlayground(gameConfig);
    }
    
    
    // initGame

    @Test
    public void testInitGame8bInit() throws IncorrectGameConfigFileException {
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
    public void testInitGame8wInit() throws IncorrectGameConfigFileException {
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
    public void testInitGame10bInit() throws IncorrectGameConfigFileException {
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
    public void testInitGameEmpty() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameFiveLines() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameAlpha() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNoSize() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNoOnTurn() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNoPieces() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNull() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration is null");
        game.initGame(null);
    }

}