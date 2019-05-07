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


    // execute


    // utility functions

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    static Reversi setMoves(List<List<Integer>> moves) throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) throws IncorrectGameConfigFileException {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
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
}
