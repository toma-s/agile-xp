package fixed;

import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();


    // readGameConfig

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 3, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "B", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "34 43", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "33 44", gameConfig[2]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 3, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "W", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "34 43", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "33 44", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigFourLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFourLines);

        assertEquals("Lines number of gameFourLines config file", 4, gameConfig.length);
        assertEquals("1st line of gameFourLines config file", "B", gameConfig[0]);
        assertEquals("2nd line of gameFourLines config file", "34 43", gameConfig[1]);
        assertEquals("3rd line of gameFourLines config file", "33 44", gameConfig[2]);
        assertEquals("4th line of gameFourLines config file", "33 44", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 3, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "B", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(2, gameConfig.length);
        assertEquals("34 43", gameConfig[0]);
        assertEquals("33 44", gameConfig[1]);
    }

    @Test
    public void testReadGameConfigNoTiles() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoTiles);

        assertEquals(1, gameConfig.length);
        assertEquals("B", gameConfig[0]);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[] {"B", "34 43", "33 44"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 1, game.onTurn);
        assertEquals("init playground on initial game config", 1, getTile(game, 3, 4));
        assertEquals("init playground on initial game config", 1, getTile(game, 4, 3));
        assertEquals("init playground on initial game config", 0, getTile(game, 3, 3));
        assertEquals("init playground on initial game config", 0, getTile(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[] {"W", "34 43", "33 44"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 0, game.onTurn);
        assertEquals("init playground on initial game config", 1, getTile(game, 3, 4));
        assertEquals("init playground on initial game config", 1, getTile(game, 4, 3));
        assertEquals("init playground on initial game config", 0, getTile(game, 3, 3));
        assertEquals("init playground on initial game config", 0, getTile(game, 4, 4));
    }


    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[] {"B", "34 43", "33 44", "33 44"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[] {"34 43", "33 44"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoTiles() {
        String[] gameConfig = new String[] {"B"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        assertArrayEquals(null, game.playground);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() {
        String[] gameConfig = new String[] {"B", "34 43", "33 44"};
        Reversi game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
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
        assertEquals("playground on initial game config", 0, getTile(game, 3, 3));
        assertEquals("playground on initial game config", 1, getTile(game, 3, 4));
        assertEquals("playground on initial game config", 1, getTile(game, 4, 3));
        assertEquals("playground on initial game config", 0, getTile(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", 0, game.onTurn);
        assertEquals("playground on initial game config", 1, getTile(game, 3, 4));
        assertEquals("playground on initial game config", 1, getTile(game, 4, 3));
        assertEquals("playground on initial game config", 0, getTile(game, 3, 3));
        assertEquals("playground on initial game config", 0, getTile(game, 4, 4));
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
    public void testFourLines() {
        Reversi game = new Reversi(GameConfig.gameFourLines);

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
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoTiles() {
        Reversi game = new Reversi(GameConfig.gameNoTiles);

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

        assertEquals("check if flipped", 1, getTile(game, 3, 3));
        assertEquals("check if flipped", 1, getTile(game, 3, 2));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        assertEquals("check if flipped", 1, getTile(game,4, 4));
        assertEquals("check if flipped", 1, getTile(game, 5, 4));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        assertEquals("check if flipped", 1, getTile(game, 4, 4));
        assertEquals("check if flipped", 1, getTile(game, 4, 5));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        assertEquals("check if flipped", 1, getTile(game, 3, 3));
        assertEquals("check if flipped", 1, getTile(game, 2, 3));
        assertEquals("on turn", 0, game.onTurn);
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

        assertEquals("check if flipped", 1, getTile(game, 5, 3));
        assertEquals("check if flipped", 1, getTile(game, 6, 2));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, 4, 4));
        assertEquals("check if flipped", 0, getTile(game, 5, 5));
        assertEquals("on turn", 1, game.onTurn);
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

        assertEquals("check if flipped", 1, getTile(game, 2, 4));
        assertEquals("check if flipped", 1, getTile(game, 1, 5));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, 3, 3));
        assertEquals("check if flipped", 0, getTile(game, 2, 2));
        assertEquals("on turn", 1, game.onTurn);
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

        assertEquals("check if flipped (D,3) correctly", 0, getTile(game, 2, 3));
        assertEquals("check if flipped (E,4) correctly", 0, getTile(game, 3, 4));
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
        assertEquals("winner", 0, game.winner);
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
        assertEquals("winner", 1, game.winner);
    }


    // utility functions

    private int getTile(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    private Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    private int[][] getEmptyPlayground() {
        int[][] empty = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = -1;
            }
        }
        return empty;
    }

    private int[][] getInitPlayground() {
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
