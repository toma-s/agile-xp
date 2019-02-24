package refactored;

import exception.IncorrectGameConfigFileException;
import exception.NotPermittedMoveException;
import javafx.util.Pair;
import org.junit.Test;

import java.util.ArrayList;

import static org.junit.Assert.*;

public class ReversiRefactoredTest {
    private ReversiRefactored revInit = new ReversiRefactored("game_init.txt");
    private ReversiRefactored rev = new ReversiRefactored();

    @Test
    public void testReadConfigInit() throws IncorrectGameConfigFileException {
        ReversiRefactored game = rev;
        String[] gameConfig = game.readGameConfig("game_init.txt");

        assertEquals("game config size", 3, gameConfig.length);
        assertEquals("game config on turn", "B", gameConfig[0]);
        assertEquals("game config on turn", "E4 D5", gameConfig[1]);
        assertEquals("game config on turn", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadConfigEmpty() throws IncorrectGameConfigFileException {
        ReversiRefactored game = rev;
        String[] gameConfig = game.readGameConfig("game_empty.txt");

        assertEquals("game config size", 0, gameConfig.length);
    }

    @Test
    public void testReadConfigOneLine() throws IncorrectGameConfigFileException {
        ReversiRefactored game = rev;
        String[] gameConfig = game.readGameConfig("game_one_line.txt");

        assertEquals("game config size", 1, gameConfig.length);
        assertEquals("game config on turn", "E4 D5", gameConfig[0]);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testReadConfigNotExisting() throws IncorrectGameConfigFileException {
        ReversiRefactored game = rev;

        game.readGameConfig("game_not_existing.txt");
    }

    @Test
    public void testSetOnTurnB() throws IncorrectGameConfigFileException {
        ReversiRefactored game = rev;
        game.setOnTurn("B");

        assertEquals("set on turn B", Player.B, game.onTurn);
    }

    @Test
    public void testSetOnTurnW() throws IncorrectGameConfigFileException {
        ReversiRefactored game = rev;
        game.setOnTurn("W");

        assertEquals("set on turn W", Player.W, game.onTurn);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetOnTurnNone() throws IncorrectGameConfigFileException {
        ReversiRefactored game = rev;

        game.setOnTurn("NONE");
    }

    @Test
    public void testSetTileB() throws IncorrectGameConfigFileException {
        ReversiRefactored game = revInit;
        game.setTile("A1", Player.B);

        assertEquals("set tile: A1 as B", Player.B, game.getTile(Alpha.A, 1));
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTileAllAlpha() throws IncorrectGameConfigFileException {
        ReversiRefactored game = revInit;
        game.setTile("AA", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTileAllNum() throws IncorrectGameConfigFileException {
        ReversiRefactored game = revInit;
        game.setTile("11", Player.B);
    }

    @Test
    public void testCreateEmptyPlayground() {
        ReversiRefactored game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }

    @Test
    public void testFillPlaygroundInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        ReversiRefactored game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        assertEquals("fill playground: E4", Player.B, game.getTile(Alpha.E, 4));
        assertEquals("fill playground: E4", Player.B, game.getTile(Alpha.D, 5));
        assertEquals("fill playground: E4", Player.W, game.getTile(Alpha.D, 4));
        assertEquals("fill playground: E4", Player.W, game.getTile(Alpha.E, 5));
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testFillPlaygroundConfigLen1() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"incorrect"};
        ReversiRefactored game = getRevWithPlayground();
        game.fillPlayground(gameConfig);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testFillPlaygroundNoConfig() throws IncorrectGameConfigFileException {
        ReversiRefactored game = getRevWithPlayground();
        game.fillPlayground(null);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testFillPlaygroundIncorrectConfig() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "AA BB", "CC DD"};
        ReversiRefactored game = getRevWithPlayground();
        game.fillPlayground(gameConfig);
    }

    @Test
    public void testInitGame() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        ReversiRefactored game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground: on turn", Player.B, game.onTurn);
        assertEquals("init playground: E4", Player.B, game.getTile(Alpha.E, 4));
        assertEquals("init playground: E4", Player.B, game.getTile(Alpha.D, 5));
        assertEquals("init playground: E4", Player.W, game.getTile(Alpha.D, 4));
        assertEquals("init playground: E4", Player.W, game.getTile(Alpha.E, 5));
    }

    @Test
    public void testInit() {
        ReversiRefactored game = revInit;

        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("playground init", Player.W, game.getTile(Alpha.D, 4));
        assertEquals("playground init", Player.B, game.getTile(Alpha.E, 4));
        assertEquals("playground init", Player.B, game.getTile(Alpha.D, 5));
        assertEquals("playground init", Player.W, game.getTile(Alpha.E, 5));
        assertEquals("left B init", 2, game.getLeftB());
        assertEquals("left W init", 2, game.getLeftW());
        game.printPlayground();
    }

    @Test
    public void testTileInputA1() {
        assertTrue("tile input A1", revInit.isTileInputCorrect("A1"));
    }

    @Test
    public void testTileInputAA() {
        assertFalse("tile input AA", revInit.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInput11() {
        assertFalse("tile input AA", revInit.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInputa1() {
        assertFalse("tile input a1", revInit.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInput1A() {
        assertFalse("tile input 1A", revInit.isTileInputCorrect("1A"));
    }

    @Test
    public void testTileInputI1() {
        assertFalse("tile input I1", revInit.isTileInputCorrect("I1"));
    }

    @Test
    public void testTileInputA9() {
        assertFalse("tile input A9", revInit.isTileInputCorrect("A9"));
    }

    @Test
    public void testTileInputI9() {
        assertFalse("tile input I9", revInit.isTileInputCorrect("I9"));
    }

    @Test
    public void testEmpty() {
        ReversiRefactored game = new ReversiRefactored("game_empty.txt");

        assertEquals("on turn", Player.NONE, game.onTurn);
        assertEquals("left B init", 0, game.getLeftB());
        assertEquals("left W init", 0, game.getLeftW());
        assertTrue("ended", game.ended);
    }

    @Test
    public void testOneLine() {
        ReversiRefactored game = new ReversiRefactored("game_one_line.txt");

        assertEquals("on turn", Player.NONE, game.onTurn);
        assertEquals("left B init", 0, game.getLeftB());
        assertEquals("left W init", 0, game.getLeftW());
        assertTrue("ended", game.ended);
    }

    @Test
    public void testThreeLines() {
        ReversiRefactored game = new ReversiRefactored("game_three_lines.txt");

        assertEquals("on turn", Player.NONE, game.onTurn);
        assertEquals("left B init", 0, game.getLeftB());
        assertEquals("left W init", 0, game.getLeftW());
        assertTrue("ended", game.ended);
    }

    @Test
    public void testAllNum() {
        ReversiRefactored game = new ReversiRefactored("game_all_num.txt");

        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("left B init", 0, game.getLeftB());
        assertEquals("left W init", 0, game.getLeftW());
        assertTrue("ended", game.ended);
    }

    @Test
    public void testAllAlpha() {
        ReversiRefactored game = new ReversiRefactored("game_all_alpha.txt");

        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("left B init", 0, game.getLeftB());
        assertEquals("left W init", 0, game.getLeftW());
        assertTrue("ended", game.ended);
    }

    @Test
    public void testNoOnTurn() {
        ReversiRefactored game = new ReversiRefactored("game_no_on_turn.txt");

        assertEquals("on turn", Player.NONE, game.onTurn);
        assertEquals("left B init", 0, game.getLeftB());
        assertEquals("left W init", 0, game.getLeftW());
        assertTrue("ended", game.ended);
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOnNotEmpty() throws NotPermittedMoveException {
        ReversiRefactored game = revInit;
        game.move(Alpha.E,5);

        assertEquals("check if didn't change", Player.W, game.getTile(Alpha.E, 5));
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOutOfBoundsBelow() throws NotPermittedMoveException {
        ReversiRefactored game = revInit;
        game.move(Alpha.A,9);

        assertEquals("check if didn't change", Player.NONE, game.getTile(Alpha.A, 9));
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOutOfBoundsAbove() throws NotPermittedMoveException {
        ReversiRefactored game = revInit;
        game.move(Alpha.A,0);

        assertEquals("check if didn't change", Player.NONE, game.getTile(Alpha.A, 0));
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOnNotAdjacent() throws NotPermittedMoveException {
        ReversiRefactored game = revInit;
        game.move(Alpha.A,1);

        assertEquals("check if didn't change", Player.NONE, game.getTile(Alpha.A, 1));
    }

    @Test
    public void testInitValidMoves() {
        ReversiRefactored game = revInit;
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 4, tiles.size());
        assertEquals("valid moves", "D3", tiles.get(0));
        assertEquals("valid moves", "C4", tiles.get(1));
        assertEquals("valid moves", "F5", tiles.get(2));
        assertEquals("valid moves", "E6", tiles.get(3));
    }

    @Test
    public void testFlipRight() throws NotPermittedMoveException {
        ReversiRefactored game = revInit;
        game.move(Alpha.C,4);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testFlipUp() throws NotPermittedMoveException {
        ReversiRefactored game = revInit;
        game.move(Alpha.E, 6);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.E, 6));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testFlipLeft() throws NotPermittedMoveException {
        ReversiRefactored game = revInit;
        game.move(Alpha.F, 5);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.F, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testFlipDown() throws NotPermittedMoveException {
        ReversiRefactored game = revInit;
        game.move(Alpha.D, 3);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.D, 3));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testFlipRightUp() throws NotPermittedMoveException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        ReversiRefactored game = setMoves(moves);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.D, 6));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.C, 7));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testFlipLeftUp() throws NotPermittedMoveException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        ReversiRefactored game = setMoves(moves);

        assertEquals("check if flipped", Player.W, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", Player.W, game.getTile(Alpha.F, 6));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testFlipLeftDown() throws NotPermittedMoveException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        ReversiRefactored game = setMoves(moves);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.E, 3));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.F, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testFlipRightDown() throws NotPermittedMoveException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        ReversiRefactored game = setMoves(moves);

        assertEquals("check if flipped", Player.W, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.W, game.getTile(Alpha.C, 3));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testDoubleFlip() throws NotPermittedMoveException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        ReversiRefactored game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", Player.W, game.getTile(Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", Player.W, game.getTile(Alpha.E, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void textExecute() throws NotPermittedMoveException {
        ReversiRefactored game = revInit;
        game.execute("C4");

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecuteA1() throws NotPermittedMoveException {
        ReversiRefactored game = revInit;
        game.execute("A1");

        assertEquals("check if didn't change", Player.NONE, game.getTile(Alpha.A, 1));
    }

    @Test
    public void testMovesCompleteGame() throws NotPermittedMoveException {
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
        ReversiRefactored game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }

    @Test
    public void testFinishGame() throws NotPermittedMoveException {
        ReversiRefactored game = new ReversiRefactored("game_almost_complete.txt");
        game.execute("G7");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }

    private ReversiRefactored setMoves(ArrayList<Pair<Alpha, Integer>> moves) throws NotPermittedMoveException {
        ReversiRefactored game = revInit;
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private ReversiRefactored getRevWithPlayground() {
        ReversiRefactored rev = new ReversiRefactored();
        rev.createPlayground();
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
}
