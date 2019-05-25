import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    // checkGameConfig

    @Test
    public void testCheckGameConfig8bInit() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigEmpty() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigFiveLines() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoSize() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

    @Test
    public void testCheckGameConfigNoOnTurn() throws Exception {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        expectedException.expect(Exception.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.checkLength(gameConfig);
    }

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
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
