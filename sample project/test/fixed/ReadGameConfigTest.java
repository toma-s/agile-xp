package fixed;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 3, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "B", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "3 4, 4 3", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 3, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "W", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "3 4, 4 3", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 3, 4 4", gameConfig[2]);
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
        assertEquals("2nd line of gameFourLines config file", "3 4, 4 3", gameConfig[1]);
        assertEquals("3rd line of gameFourLines config file", "3 3, 4 4", gameConfig[2]);
        assertEquals("4th line of gameFourLines config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 3, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "B", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "E 4, D 5", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "D 4, E 5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(2, gameConfig.length);
        assertEquals("3 4, 4 3", gameConfig[0]);
        assertEquals("3 3, 4 4", gameConfig[1]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(1, gameConfig.length);
        assertEquals("B", gameConfig[0]);
    }
}
