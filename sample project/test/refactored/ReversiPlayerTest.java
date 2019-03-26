package refactored;

import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiPlayerTest {

    private ReversiPlayer rev = new ReversiPlayer();

    private String gameConfigDir = "./game_config/";
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


    // Alpha

    @Test
    public void testAlphaValueOf() {
        assertEquals("Value of Alpha A", Alpha.A, Alpha.valueOf("A"));
        assertEquals("Value of Alpha B", Alpha.B, Alpha.valueOf("B"));
        assertEquals("Value of Alpha C", Alpha.C, Alpha.valueOf("C"));
        assertEquals("Value of Alpha D", Alpha.D, Alpha.valueOf("D"));
        assertEquals("Value of Alpha E", Alpha.E, Alpha.valueOf("E"));
        assertEquals("Value of Alpha F", Alpha.F, Alpha.valueOf("F"));
        assertEquals("Value of Alpha G", Alpha.G, Alpha.valueOf("G"));
        assertEquals("Value of Alpha H", Alpha.H, Alpha.valueOf("H"));
    }


    // readGameConfig

    @Test
    public void testReadGameConfigInit() {
        ReversiPlayer game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        ReversiPlayer game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() {
        ReversiPlayer game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        ReversiPlayer game = rev;
        String[] gameConfig = game.readGameConfig(gameNotExisting);

        String[] expectedGameConfig = new String[]{};
        assertArrayEquals(expectedGameConfig, gameConfig);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        ReversiPlayer game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGameInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        ReversiPlayer game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 1, game.onTurn);
        assertEquals("init playground on initial game config", 1, getTile(game, Alpha.E, 4));
        assertEquals("init playground on initial game config", 1, getTile(game, Alpha.D, 5));
        assertEquals("init playground on initial game config", 0, getTile(game, Alpha.D, 4));
        assertEquals("init playground on initial game config", 0, getTile(game, Alpha.E, 5));
    }

    @Test
    public void testReadGameConfigInitW() {
        ReversiPlayer game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testInitGameNoLines() {
        String[] gameConfig = new String[] {};
        ReversiPlayer game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOneLine() {
        String[] gameConfig = new String[] {"E4 D5"};
        ReversiPlayer game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
        ReversiPlayer game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        ReversiPlayer game = rev;
        game.initGame(null);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOnlyB() {
        String[] gameConfig = new String[] {"B", "E4 D5"};
        ReversiPlayer game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        ReversiPlayer game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        ReversiPlayer game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // ReversiPlayer

    @Test
    public void testInit() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("playground on initial game config", 0, getTile(game, Alpha.D, 4));
        assertEquals("playground on initial game config", 1, getTile(game, Alpha.E, 4));
        assertEquals("playground on initial game config", 1, getTile(game, Alpha.D, 5));
        assertEquals("playground on initial game config", 0, getTile(game, Alpha.E, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        ReversiPlayer game = new ReversiPlayer(gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testOneLine() {
        ReversiPlayer game = new ReversiPlayer(gameOneLine);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAllNum() {
        ReversiPlayer game = new ReversiPlayer(gameAllNum);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAllAlpha() {
        ReversiPlayer game = new ReversiPlayer(gameAllAlpha);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        ReversiPlayer game = new ReversiPlayer(gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);

        assertTrue("...", game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        ReversiPlayer game = new ReversiPlayer(gameComplete);

        assertFalse("...", game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);
        game.move(Alpha.E,5);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);
        game.move(Alpha.A,9);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);
        game.move(Alpha.A,0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);
        game.move(Alpha.A,1);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);
        game.move(Alpha.C,4);

        assertEquals("check if flipped", 1, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", 1, getTile(game, Alpha.C, 4));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);
        game.move(Alpha.E, 6);

        assertEquals("check if flipped", 1, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", 1, getTile(game, Alpha.E, 6));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);
        game.move(Alpha.F, 5);

        assertEquals("check if flipped", 1, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", 1, getTile(game, Alpha.F, 5));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);
        game.move(Alpha.D, 3);

        assertEquals("check if flipped", 1, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", 1, getTile(game, Alpha.D, 3));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        ReversiPlayer game = setMoves(moves);

        assertEquals("check if flipped", 1, getTile(game, Alpha.D, 6));
        assertEquals("check if flipped", 1, getTile(game, Alpha.C, 7));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        ReversiPlayer game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", 0, getTile(game, Alpha.F, 6));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        ReversiPlayer game = setMoves(moves);

        assertEquals("check if flipped", 1, getTile(game, Alpha.E, 3));
        assertEquals("check if flipped", 1, getTile(game, Alpha.F, 2));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        ReversiPlayer game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", 0, getTile(game, Alpha.C, 3));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        ReversiPlayer game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", 0, getTile(game, Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", 0, getTile(game, Alpha.E, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6)); moves.add(new Pair<>(Alpha.F, 4));
        moves.add(new Pair<>(Alpha.D, 3)); moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.C, 3)); moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.E, 3)); moves.add(new Pair<>(Alpha.C, 2));
        moves.add(new Pair<>(Alpha.B, 3)); moves.add(new Pair<>(Alpha.F, 5));
        moves.add(new Pair<>(Alpha.F, 3)); moves.add(new Pair<>(Alpha.D, 2));
        moves.add(new Pair<>(Alpha.E, 2)); moves.add(new Pair<>(Alpha.B, 4));
        moves.add(new Pair<>(Alpha.C, 5)); moves.add(new Pair<>(Alpha.F, 1));
        moves.add(new Pair<>(Alpha.A, 3)); moves.add(new Pair<>(Alpha.F, 2));
        moves.add(new Pair<>(Alpha.C, 6)); moves.add(new Pair<>(Alpha.F, 6));
        moves.add(new Pair<>(Alpha.G, 6)); moves.add(new Pair<>(Alpha.A, 5));
        moves.add(new Pair<>(Alpha.B, 5)); moves.add(new Pair<>(Alpha.A, 6));
        moves.add(new Pair<>(Alpha.G, 5)); moves.add(new Pair<>(Alpha.C, 7));
        moves.add(new Pair<>(Alpha.G, 3)); moves.add(new Pair<>(Alpha.D, 7));
        moves.add(new Pair<>(Alpha.E, 7)); moves.add(new Pair<>(Alpha.H, 4));
        moves.add(new Pair<>(Alpha.D, 8)); moves.add(new Pair<>(Alpha.G, 4));
        moves.add(new Pair<>(Alpha.A, 4)); moves.add(new Pair<>(Alpha.A, 2));
        moves.add(new Pair<>(Alpha.H, 2)); moves.add(new Pair<>(Alpha.H, 3));
        moves.add(new Pair<>(Alpha.H, 5)); moves.add(new Pair<>(Alpha.B, 6));
        moves.add(new Pair<>(Alpha.C, 8)); moves.add(new Pair<>(Alpha.F, 7));
        moves.add(new Pair<>(Alpha.E, 8)); moves.add(new Pair<>(Alpha.B, 7));
        moves.add(new Pair<>(Alpha.C, 1)); moves.add(new Pair<>(Alpha.H, 6));
        moves.add(new Pair<>(Alpha.H, 7)); moves.add(new Pair<>(Alpha.D, 1));
        moves.add(new Pair<>(Alpha.A, 8)); moves.add(new Pair<>(Alpha.B, 1));
        moves.add(new Pair<>(Alpha.A, 7)); moves.add(new Pair<>(Alpha.F, 8));
        moves.add(new Pair<>(Alpha.G, 2)); moves.add(new Pair<>(Alpha.H, 1));
        moves.add(new Pair<>(Alpha.G, 1)); moves.add(new Pair<>(Alpha.H, 8));
        moves.add(new Pair<>(Alpha.E, 1)); moves.add(new Pair<>(Alpha.B, 8));
        moves.add(new Pair<>(Alpha.A, 1)); moves.add(new Pair<>(Alpha.B, 2));
        moves.add(new Pair<>(Alpha.G, 8)); moves.add(new Pair<>(Alpha.G, 7));
        ReversiPlayer game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", 1, game.winner);
    }


    // utility functions

    private int getTile(ReversiPlayer game, Alpha c0, int r0) {
        return game.playground[r0-1][c0.getValue()];
    }


    private ReversiPlayer setMoves(ArrayList<Pair<Alpha, Integer>> moves) {
        ReversiPlayer game = new ReversiPlayer(gameInitBStarts);
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private ReversiPlayer initReversi(String[] gameConfig) {
        ReversiPlayer rev = new ReversiPlayer();
        rev.initGame(gameConfig);
        return rev;
    }

    private ReversiPlayer getRevWithPlayground() {
        ReversiPlayer rev = new ReversiPlayer();
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
