package duplicity;

import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();



    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
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


    // initGame


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

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        assertEquals("check if flipped", Player.B, getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.B, getPiece(game, 3, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        assertEquals("check if flipped", Player.B, getPiece(game, 4, 4));
        assertEquals("check if flipped", Player.B, getPiece(game, 5, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        assertEquals("check if flipped", Player.B, getPiece(game, 4, 4));
        assertEquals("check if flipped", Player.B, getPiece(game, 4, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        assertEquals("check if flipped", Player.B, getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.B, getPiece(game, 2, 3));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
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
    public void testMoveFlipLeftUp() {
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
    public void testMoveFlipLeftDown() {
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
    public void testMoveFlipRightDown() {
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
    public void testMoveDoubleFlip() {
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
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 39, game.getLeftW());
        assertEquals("B left", 25, game.getLeftB());
        assertEquals("winner", Player.W, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5)); moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2)); moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2)); moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2)); moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2)); moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2)); moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1)); moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4)); moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2)); moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5)); moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5)); moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4)); moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4)); moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2)); moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6)); moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7)); moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3)); moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1)); moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4)); moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7)); moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7)); moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0)); moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6)); moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7)); moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6)); moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1)); moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0)); moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0)); moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0)); moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7)); moves.add(Arrays.asList(6, 6));
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
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
