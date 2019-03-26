package feature;

import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiAlphaTest {

    private ReversiAlpha rev = new ReversiAlpha();

    private String gameConfigDir = "./game_config_num/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameAllNum = new File(gameConfigDir + "game_all_num.txt").toPath();
    private Path gameAlmostComplete = new File(gameConfigDir + "game_almost_complete.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();


    // readGameConfig

    @Test
    public void testReadGameConfigInit() {
        ReversiAlpha game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "34 43", gameConfig[1]);
        assertEquals("3rd line of initial config file", "33 44", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigInitW() {
        ReversiAlpha game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        ReversiAlpha game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() {
        ReversiAlpha game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigFourLines() {
        ReversiAlpha game = rev;
        String[] gameConfig = game.readGameConfig(gameFourLines);

        assertEquals(4, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("E4 D5", gameConfig[1]);
        assertEquals("D4 E5", gameConfig[2]);
        assertEquals("E4 D5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        ReversiAlpha game = rev;
        String[] gameConfig = game.readGameConfig(gameNotExisting);

        String[] expectedGameConfig = new String[]{};
        assertArrayEquals(expectedGameConfig, gameConfig);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        ReversiAlpha game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGameInit() {
        String[] gameConfig = new String[] {"B", "34 43", "33 44"};
        ReversiAlpha game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 1, game.onTurn);
        assertEquals("init playground on initial game config", 1, getTile(game, 3, 4));
        assertEquals("init playground on initial game config", 1, getTile(game, 4, 3));
        assertEquals("init playground on initial game config", 0, getTile(game, 3, 3));
        assertEquals("init playground on initial game config", 0, getTile(game, 4, 4));
    }

    @Test
    public void testInitGameNoLines() {
        String[] gameConfig = new String[] {};
        ReversiAlpha game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOneLine() {
        String[] gameConfig = new String[] {"E4 D5"};
        ReversiAlpha game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
        ReversiAlpha game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        ReversiAlpha game = rev;
        game.initGame(null);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOnlyB() {
        String[] gameConfig = new String[] {"B", "E4 D5"};
        ReversiAlpha game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() {
        String[] gameConfig = new String[] {"B", "34 43", "33 44"};
        ReversiAlpha game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        ReversiAlpha game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // ReversiAlpha

    @Test
    public void testInit() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("playground on initial game config", 0, getTile(game, 3, 3));
        assertEquals("playground on initial game config", 1, getTile(game, 3, 4));
        assertEquals("playground on initial game config", 1, getTile(game, 4, 3));
        assertEquals("playground on initial game config", 0, getTile(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        ReversiAlpha game = new ReversiAlpha(gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testOneLine() {
        ReversiAlpha game = new ReversiAlpha(gameOneLine);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testFourLines() {
        ReversiAlpha game = new ReversiAlpha(gameFourLines);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAllAlpha() {
        ReversiAlpha game = new ReversiAlpha(gameAllAlpha);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        ReversiAlpha game = new ReversiAlpha(gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);

        assertTrue("...", game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        ReversiAlpha game = new ReversiAlpha(gameComplete);

        assertFalse("...", game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);
        game.move(4, 4);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);
        game.move(8, 0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);
        game.move(-1, 0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);
        game.move(0, 0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);
        game.move(3, 2);

        assertEquals("check if flipped", 1, getTile(game, 3, 3));
        assertEquals("check if flipped", 1, getTile(game, 3, 2));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);
        game.move(5, 4);

        assertEquals("check if flipped", 1, getTile(game,4, 4));
        assertEquals("check if flipped", 1, getTile(game, 5, 4));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);
        game.move(4, 5);

        assertEquals("check if flipped", 1, getTile(game, 4, 4));
        assertEquals("check if flipped", 1, getTile(game, 4, 5));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);
        game.move(2, 3);

        assertEquals("check if flipped", 1, getTile(game, 3, 3));
        assertEquals("check if flipped", 1, getTile(game, 2, 3));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(5, 4));
        moves.add(new Pair<>(5, 3));
        moves.add(new Pair<>(6, 2));
        ReversiAlpha game = setMoves(moves);

        assertEquals("check if flipped", 1, getTile(game, 5, 3));
        assertEquals("check if flipped", 1, getTile(game, 6, 2));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(5, 4));
        moves.add(new Pair<>(5, 5));
        ReversiAlpha game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, 4, 4));
        assertEquals("check if flipped", 0, getTile(game, 5, 5));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 4));
        moves.add(new Pair<>(1, 5));
        ReversiAlpha game = setMoves(moves);

        assertEquals("check if flipped", 1, getTile(game, 2, 4));
        assertEquals("check if flipped", 1, getTile(game, 1, 5));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 2));
        ReversiAlpha game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, 3, 3));
        assertEquals("check if flipped", 0, getTile(game, 2, 2));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 2));
        moves.add(new Pair<>(3, 2));
        moves.add(new Pair<>(2, 4));
        ReversiAlpha game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", 0, getTile(game, 2, 3));
        assertEquals("check if flipped (E,4) correctly", 0, getTile(game, 3, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(4, 5)); moves.add(new Pair<>(5, 3));
        moves.add(new Pair<>(3, 2)); moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 2)); moves.add(new Pair<>(3, 5));
        moves.add(new Pair<>(4, 2)); moves.add(new Pair<>(2, 1));
        moves.add(new Pair<>(1, 2)); moves.add(new Pair<>(5, 4));
        moves.add(new Pair<>(5, 2)); moves.add(new Pair<>(3, 1));
        moves.add(new Pair<>(4, 1)); moves.add(new Pair<>(1, 3));
        moves.add(new Pair<>(2, 4)); moves.add(new Pair<>(5, 0));
        moves.add(new Pair<>(0, 2)); moves.add(new Pair<>(5, 1));
        moves.add(new Pair<>(2, 5)); moves.add(new Pair<>(5, 5));
        moves.add(new Pair<>(6, 5)); moves.add(new Pair<>(0, 4));
        moves.add(new Pair<>(1, 4)); moves.add(new Pair<>(0, 5));
        moves.add(new Pair<>(6, 4)); moves.add(new Pair<>(2, 6));
        moves.add(new Pair<>(6, 2)); moves.add(new Pair<>(3, 6));
        moves.add(new Pair<>(4, 6)); moves.add(new Pair<>(7, 3));
        moves.add(new Pair<>(3, 7)); moves.add(new Pair<>(6, 3));
        moves.add(new Pair<>(0, 3)); moves.add(new Pair<>(0, 1));
        moves.add(new Pair<>(7, 1)); moves.add(new Pair<>(7, 2));
        moves.add(new Pair<>(7, 4)); moves.add(new Pair<>(1, 5));
        moves.add(new Pair<>(2, 7)); moves.add(new Pair<>(5, 6));
        moves.add(new Pair<>(4, 7)); moves.add(new Pair<>(1, 6));
        moves.add(new Pair<>(2, 0)); moves.add(new Pair<>(7, 5));
        moves.add(new Pair<>(7, 6)); moves.add(new Pair<>(3, 0));
        moves.add(new Pair<>(0, 7)); moves.add(new Pair<>(1, 0));
        moves.add(new Pair<>(0, 6)); moves.add(new Pair<>(5, 7));
        moves.add(new Pair<>(6, 1)); moves.add(new Pair<>(7, 0));
        moves.add(new Pair<>(6, 0)); moves.add(new Pair<>(7, 7));
        moves.add(new Pair<>(4, 0)); moves.add(new Pair<>(1, 7));
        moves.add(new Pair<>(0, 0)); moves.add(new Pair<>(1, 1));
        moves.add(new Pair<>(6, 7)); moves.add(new Pair<>(6, 6));
        ReversiAlpha game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", 1, game.winner);
    }


    // utility functions

    private int getTile(ReversiAlpha game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    private ReversiAlpha setMoves(ArrayList<Pair<Integer, Integer>> moves) {
        ReversiAlpha game = new ReversiAlpha(gameInitBStarts);
        for (Pair<Integer, Integer> move  : moves) {
            Integer r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private ReversiAlpha initReversi(String[] gameConfig) {
        ReversiAlpha rev = new ReversiAlpha();
        rev.initGame(gameConfig);
        return rev;
    }

    private ReversiAlpha getRevWithPlayground() {
        ReversiAlpha rev = new ReversiAlpha();
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
