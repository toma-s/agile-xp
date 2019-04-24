package buggy;

import org.junit.Test;
import java.io.File;
import java.nio.file.Path;
import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "./game_config_8/";
    private Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    private Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameNoTiles = new File(gameConfigDir + "game_no_tiles.txt").toPath();
    private Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    private Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();


    // bug 0  (1)

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(game8bInit);
        game.move(8, 0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    // bug 0  (1)

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(game8bInit);
        game.move(-1, 0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    // bug 1

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(game8bInit);
        game.move(4, 4);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
    }

    // bug 3

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(game8bInit);
        game.move(0, 0);

        assertArrayEquals("check if didn't change", getInitPlayground(), game.playground);
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
