package fileException;

import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

public class InitGameTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();

    @Test
    public void testInitGame8bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, getPiece(game, 5, 5));
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

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }
}