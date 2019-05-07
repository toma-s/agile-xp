package left;

import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();


    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
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
        assertEquals("playground on initial game config", Player.B, getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
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
    public void test10bInit() {
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

        assertArrayEquals(getEmptyPlayground(), game.playground);
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

    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = rev;
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


    // isEmpty

    @Test
    public void testIsEmptyInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        assertFalse("is game over on init", game.isGameOver());
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

        assertEquals(Player.B, getPiece(game, 3, 3));
        assertEquals(Player.B, getPiece(game, 3, 2));
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
        Reversi game = getRevWithPlayground();
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


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.B, game.onTurn);
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


    // execute

    @Test
    public void testExecute() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        assertEquals("check if flipped", Player.B, getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.B, getPiece(game, 3, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        assertArrayEquals("check if didn't change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 39, game.getLeftW());
        assertEquals("B left", 25, game.getLeftB());
        assertEquals("winner", Player.W, game.winner);
    }


    // utility functions

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
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

}
