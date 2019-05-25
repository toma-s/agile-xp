package featureHints;

import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./game_config/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
