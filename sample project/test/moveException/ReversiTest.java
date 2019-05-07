package moveException;

import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    // Player

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }


    // readGameConfig

    @Test
    public void testReadGameConfig8bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file does not exist");
        game.readGameConfig(GameConfig.gameNotExisting);
    }


    @Test
    public void testReadGameConfigFiveLines() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }


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
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
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

        assertEquals("set player B on piece 00", Player.B, getPiece(game, 0, 0));
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
        Reversi game = getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"one"};
        Reversi game = getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(gameConfig);
    }

    @Test
    public void testFillPlaygroundNull() throws IncorrectGameConfigFileException {
        Reversi game = getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(null);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = getRevWithPlayground();

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

        assertEquals("init playground on initial game config", 8, game.size);
        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getPiece(game, 3, 4));
        assertEquals("init playground on initial game config", Player.B, getPiece(game, 4, 3));
        assertEquals("init playground on initial game config", Player.W, getPiece(game, 3, 3));
        assertEquals("init playground on initial game config", Player.W, getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 8, game.size);
        assertEquals("init playground on initial game config", Player.W, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getPiece(game, 3, 4));
        assertEquals("init playground on initial game config", Player.B, getPiece(game, 4, 3));
        assertEquals("init playground on initial game config", Player.W, getPiece(game, 3, 3));
        assertEquals("init playground on initial game config", Player.W, getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 10, game.size);
        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getPiece(game, 4, 5));
        assertEquals("init playground on initial game config", Player.B, getPiece(game, 5, 4));
        assertEquals("init playground on initial game config", Player.W, getPiece(game, 4, 4));
        assertEquals("init playground on initial game config", Player.W, getPiece(game, 5, 5));
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


    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameEmpty);
    }

    @Test
    public void testNotExisting() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file does not exist");
        new Reversi(GameConfig.gameNotExisting);
    }

    @Test
    public void testFiveLines() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameFiveLines);
    }

    @Test
    public void testAlpha() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        new Reversi(GameConfig.gameAlpha);
    }

    @Test
    public void testNoSize() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoSize);
    }

    @Test
    public void testNoOnTurn() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoOnTurn);
    }

    @Test
    public void testNoPieces() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoPieces);
    }


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = rev;
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() throws IncorrectGameConfigFileException {
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
    public void testGetPiecesToFlipInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals(Player.B, getPiece(game, 3, 3));
        assertEquals(Player.B, getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.B, game.onTurn);
    }


    // endGame

    @Test
    public void testEndGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        assertTrue(game.ended);
        assertEquals(Player.B, game.winner);
    }


    // move

    @Test
    public void testMoveOnNotEmpty() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move on not empty piece is not permitted");
        game.move(4, 4);
    }

    @Test
    public void testMoveOutOfBoundsBelow() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move out of bounds is not permitted");
        game.move(8, 0);
    }

    @Test
    public void testMoveOutOfBoundsAbove() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move out of bounds is not permitted");
        game.move(-1, 0);
    }

    @Test
    public void testMoveOnNotAdjacent() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move is not permitted");
        game.move(0, 0);
    }

    @Test
    public void testMoveFlipRight() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        assertEquals("check if flipped", Player.B, getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.B, getPiece(game, 3, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        assertEquals("check if flipped", Player.B, getPiece(game, 4, 4));
        assertEquals("check if flipped", Player.B, getPiece(game, 5, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        assertEquals("check if flipped", Player.B, getPiece(game, 4, 4));
        assertEquals("check if flipped", Player.B, getPiece(game, 4, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        assertEquals("check if flipped", Player.B, getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.B, getPiece(game, 2, 3));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getPiece(game, 5, 3));
        assertEquals("check if flipped", Player.B, getPiece(game, 6, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getPiece(game, 4, 4));
        assertEquals("check if flipped", Player.W, getPiece(game, 5, 5));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getPiece(game, 2, 4));
        assertEquals("check if flipped", Player.B, getPiece(game, 1, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.W, getPiece(game, 2, 2));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", Player.W, getPiece(game, 2, 3));
        assertEquals("check if flipped (E,4) correctly", Player.W, getPiece(game, 3, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 39, game.getLeftW());
        assertEquals("B left", 25, game.getLeftB());
        assertEquals("winner", Player.W, game.winner);
    }

    @Test
    public void testMovesCompleteGame() throws IncorrectGameConfigFileException, NotPermittedMoveException {
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
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // execute

    @Test
    public void testExecute() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        assertEquals("check if flipped", Player.B, getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.B, getPiece(game, 3, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
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


    // utility functions

    private Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    private Reversi setMoves(List<List<Integer>> moves) throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) throws IncorrectGameConfigFileException {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    private Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    private Player[][] getInitPlayground() {
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
}
