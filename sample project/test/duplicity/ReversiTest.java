package duplicity;

import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();


    // Player

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }


    // readGameConfig

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
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
    public void testReadGameConfigFiveLines() {
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
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoTiles() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoTiles);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // isTileInputCorrect

    @Test
    public void testTileInput00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("tile input: 00", game.isTileInputCorrect("0 0"));
    }

    @Test
    public void testTileInput00NoSpace() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("tile input: 00", game.isTileInputCorrect("00"));
    }

    @Test
    public void testTileInputD3() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("tile input: D3", game.isTileInputCorrect("D 3"));
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

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 8, game.size);
        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getTile(game, 3, 4));
        assertEquals("init playground on initial game config", Player.B, getTile(game, 4, 3));
        assertEquals("init playground on initial game config", Player.W, getTile(game, 3, 3));
        assertEquals("init playground on initial game config", Player.W, getTile(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[] {"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 8, game.size);
        assertEquals("init playground on initial game config", Player.W, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getTile(game, 3, 4));
        assertEquals("init playground on initial game config", Player.B, getTile(game, 4, 3));
        assertEquals("init playground on initial game config", Player.W, getTile(game, 3, 3));
        assertEquals("init playground on initial game config", Player.W, getTile(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[] {"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 10, game.size);
        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getTile(game, 4, 5));
        assertEquals("init playground on initial game config", Player.B, getTile(game, 5, 4));
        assertEquals("init playground on initial game config", Player.W, getTile(game, 4, 4));
        assertEquals("init playground on initial game config", Player.W, getTile(game, 5, 5));
    }


    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFiveLines() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[] {"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoSize() {
        String[] gameConfig = new String[] {"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[] {"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoTiles() {
        String[] gameConfig = new String[] {"8", "B"};
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
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
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

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, getTile(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, getTile(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, getTile(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, getTile(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, getTile(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, getTile(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, getTile(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, getTile(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, getTile(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, getTile(game, 5, 5));
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
    public void testNoTiles() {
        Reversi game = new Reversi(GameConfig.gameNoTiles);

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

        assertEquals("check if flipped", Player.B, getTile(game, 3, 3));
        assertEquals("check if flipped", Player.B, getTile(game, 3, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        assertEquals("check if flipped", Player.B, getTile(game, 4, 4));
        assertEquals("check if flipped", Player.B, getTile(game, 5, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        assertEquals("check if flipped", Player.B, getTile(game, 4, 4));
        assertEquals("check if flipped", Player.B, getTile(game, 4, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        assertEquals("check if flipped", Player.B, getTile(game, 3, 3));
        assertEquals("check if flipped", Player.B, getTile(game, 2, 3));
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

        assertEquals("check if flipped", Player.B, getTile(game, 5, 3));
        assertEquals("check if flipped", Player.B, getTile(game, 6, 2));
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

        assertEquals("check if flipped", Player.W, getTile(game, 4, 4));
        assertEquals("check if flipped", Player.W, getTile(game, 5, 5));
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

        assertEquals("check if flipped", Player.B, getTile(game, 2, 4));
        assertEquals("check if flipped", Player.B, getTile(game, 1, 5));
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

        assertEquals("check if flipped", Player.W, getTile(game, 3, 3));
        assertEquals("check if flipped", Player.W, getTile(game, 2, 2));
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

        assertEquals("check if flipped (D,3) correctly", Player.W, getTile(game, 2, 3));
        assertEquals("check if flipped (E,4) correctly", Player.W, getTile(game, 3, 4));
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

    private Player getTile(Reversi game, int r0, int c0) {
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
