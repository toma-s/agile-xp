package feature;

import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;


public class ReversiTest {



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

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", 1, getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 0, getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", 0, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", 1, getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 0, getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("playground on initial game config", 1, getPiece(game, 4, 5));
        assertEquals("playground on initial game config", 1, getPiece(game, 5, 4));
        assertEquals("playground on initial game config", 0, getPiece(game, 4, 4));
        assertEquals("playground on initial game config", 0, getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
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


    // move


    // utility functions

    static int getPiece(Reversi game, int r0, int c0) {
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

    static int[][] getEmptyPlayground() {
        int[][] empty = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = -1;
            }
        }
        return empty;
    }

    static int[][] getInitPlayground() {
        int[][] init = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = -1;
            }
        }
        init[3][3] = 0;
        init[4][4] = 0;
        init[3][4] = 1;
        init[4][3] = 1;
        return init;
    }
}
