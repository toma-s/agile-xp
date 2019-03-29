import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;

public class ReversiTest {

  private Reversi rev = new Reversi();

  private String gameConfigDir = "upload-dir/game_config/";
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
  public void testReadGameConfigInit() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      String[] gameConfig = game.readGameConfig(gameInitBStarts);

      assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
      assertEquals("1st line of initial config file", "B", gameConfig[0]);
      assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
      assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
  }

  @Test
  public void testReadGameConfigInitW() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      String[] gameConfig = game.readGameConfig(gameInitWStarts);

      assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
      assertEquals("1st line of initial config file", "W", gameConfig[0]);
      assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
      assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
  }

  @Test
  public void testReadGameConfigEmpty() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      String[] gameConfig = game.readGameConfig(gameEmpty);

      assertEquals("lines number of empty config file", 0, gameConfig.length);
  }

  @Test
  public void testReadGameConfigOneLine() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      String[] gameConfig = game.readGameConfig(gameOneLine);

      assertEquals("lines number of 1-line config file", 1, gameConfig.length);
      assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
  }

  @Test
  public void testReadGameConfigFourLines() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      String[] gameConfig = game.readGameConfig(gameFourLines);

      assertEquals(4, gameConfig.length);
      assertEquals("B", gameConfig[0]);
      assertEquals("E4 D5", gameConfig[1]);
      assertEquals("D4 E5", gameConfig[2]);
      assertEquals("E4 D5", gameConfig[3]);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testReadGameConfigNotExisting() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      game.readGameConfig(gameNotExisting);
  }


}
