import org.junit.Test;

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    private Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    private Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    private Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    private Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    private Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameNoTiles = new File(gameConfigDir + "game_no_tiles.txt").toPath();
    private Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    private Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();

    @Test
    public void testSample() {
        Reversi game = rev;

        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);
    }

}