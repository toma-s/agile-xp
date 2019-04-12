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


  // Player

  @Test
  public void testPlayerValueOf() {
      assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
      assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
      assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
  }


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


  // isOnTurnInputCorrect

  @Test
  public void testIsOnTurnInputCorrectB() {
      Reversi game = rev;

      assertTrue("on turn value of config file: B", game.isOnTurnInputCorrect("B"));
  }

  @Test
  public void testIsOnTurnInputCorrectW() {
      Reversi game = rev;

      assertTrue("on turn value of config file: W", game.isOnTurnInputCorrect("W"));
  }

  @Test
  public void testIsOnTurnInputCorrectA() {
      Reversi game = rev;

      assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("A"));
  }

  @Test
  public void testIsOnTurnInputCorrectNONE() {
      Reversi game = rev;

      assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("NONE"));
  }

  @Test
  public void testIsOnTurnInputCorrectnull() {
      Reversi game = rev;

      assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect(null));
  }


  // setOnTurn

  @Test
  public void testSetOnTurnB() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      game.setOnTurn("B");

      assertEquals("set player on turn: B", Player.B, game.onTurn);
  }

  @Test
  public void testSetOnTurnW() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      game.setOnTurn("W");

      assertEquals("set player on turn: W", Player.W, game.onTurn);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testSetOnTurnA() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      game.setOnTurn("A");
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testSetOnTurnNone() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      game.setOnTurn("NONE");
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testSetOnTurnnull() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      game.setOnTurn(null);

      assertEquals(Player.NONE, game.onTurn);
  }


  // createPlayground

  @Test
  public void testCreatePlayground() {
      Reversi game = getRevWithPlayground();

      assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
  }


  // isTileInputCorrect

  @Test
  public void testTileInputA1() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      assertTrue(game.isTileInputCorrect("A1"));
  }

  @Test
  public void testTileInputAA() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      assertFalse(game.isTileInputCorrect("a1"));
  }

  @Test
  public void testTileInput11() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      assertFalse(game.isTileInputCorrect("a1"));
  }

  @Test
  public void testTileInputa1() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      assertFalse(game.isTileInputCorrect("a1"));
  }

  @Test
  public void testTileInput1A() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      assertFalse(game.isTileInputCorrect("1A"));
  }

  @Test
  public void testTileInputI1() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      assertFalse(game.isTileInputCorrect("I1"));
  }

  @Test
  public void testTileInputA9() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      assertFalse(game.isTileInputCorrect("A9"));
  }

  @Test
  public void testTileInputI9() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      assertFalse(game.isTileInputCorrect("I9"));
  }


  // setTile

  @Test
  public void testSetTileA1() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.setTile("A1", Player.B);

      assertEquals(Player.B, getTile(game, Alpha.A, 1));
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testSetTileAA() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.setTile("AA", Player.B);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testSetTile11() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.setTile("11", Player.B);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testSetTilea1() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.setTile("a1", Player.B);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testSetTile1A() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.setTile("1A", Player.B);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testSetTileI1() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.setTile("I1", Player.B);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testSetTileA9() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.setTile("A9", Player.B);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testSetTileI9() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.setTile("I9", Player.B);
  }


  // fillPlayground

  @Test
  public void testFillPlaygroundInit() throws IncorrectGameConfigFileException {
      String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
      Reversi game = getRevWithPlayground();
      game.fillPlayground(gameConfig);

      assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.E, 4));
      assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.D, 5));
      assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.D, 4));
      assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.E, 5));
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testFillPlaygroundConfigLen1() throws IncorrectGameConfigFileException {
      String[] gameConfig = new String[] {"one"};
      Reversi game = getRevWithPlayground();
      game.fillPlayground(gameConfig);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testFillPlaygroundNull() throws IncorrectGameConfigFileException {
      Reversi game = getRevWithPlayground();
      game.fillPlayground(null);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testFillPlaygroundIncorrectConfig() throws IncorrectGameConfigFileException {
      String[] gameConfig = new String[] {"B", "AA BB", "CC DD"};
      Reversi game = getRevWithPlayground();
      game.fillPlayground(gameConfig);
  }


  // initGame

  @Test
  public void testInitGameInit() throws IncorrectGameConfigFileException {
      String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
      Reversi game = rev;
      game.initGame(gameConfig);

      assertEquals("init playground on initial game config", Player.B, game.onTurn);
      assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
      assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
      assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
      assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testInitGameNoLines() throws IncorrectGameConfigFileException {
      String[] gameConfig = new String[] {};
      Reversi game = rev;
      game.initGame(gameConfig);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testInitGameOneLine() throws IncorrectGameConfigFileException {
      String[] gameConfig = new String[] {"E4 D5"};
      Reversi game = rev;
      game.initGame(gameConfig);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testInitGameFourLines() throws IncorrectGameConfigFileException {
      String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
      Reversi game = rev;
      game.initGame(gameConfig);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testInitGameNull() throws IncorrectGameConfigFileException {
      Reversi game = rev;
      game.initGame(null);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testInitGameOnlyB() throws IncorrectGameConfigFileException {
      String[] gameConfig = new String[] {"B", "E4 D5"};
      Reversi game = rev;
      game.initGame(gameConfig);
  }


  // initTilesCount

  @Test
  public void testInitTilesCountInit() throws IncorrectGameConfigFileException {
      String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
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
  public void testGetLeftB() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);

      assertEquals("left Bs on initial game config", 2, game.getLeftB());
  }

  // getLeftW

  @Test
  public void testGetLeftW() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);

      assertEquals("left Ws on initial game config", 2, game.getLeftW());
  }


  // Reversi

  @Test
  public void testInit() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);

      assertEquals("on turn player on initial game config", Player.B, game.onTurn);
      assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
      assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
      assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
      assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
      assertEquals("left Bs on initial game config", 2, game.getLeftB());
      assertEquals("left Ws on initial game config", 2, game.getLeftW());
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testEmpty() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameEmpty);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testOneLine() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameOneLine);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testFourLines() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameFourLines);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testAllNum() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameAllNum);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testAllAlpha() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameAllAlpha);
  }

  @Test(expected = IncorrectGameConfigFileException.class)
  public void testNoOnTurn() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameNoOnTurn);
  }


  // isWithinPlayground

  @Test
  public void testIsWithinPlayground00() {
      Reversi game = rev;

      assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
  }

  @Test
  public void testIsWithinPlayground77() {
      Reversi game = rev;

      assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
  }

  @Test
  public void testIsWithinPlaygroundNegR() {
      Reversi game = rev;

      assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
  }

  @Test
  public void testIsWithinPlaygroundNegC() {
      Reversi game = rev;

      assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
  }

  @Test
  public void testIsWithinPlaygroundLargeR() {
      Reversi game = rev;

      assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
  }

  @Test
  public void testIsWithinPlaygroundLargeC() {
      Reversi game = rev;

      assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
  }


  // isEmpty

  @Test
  public void testIsEmptyInit00() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);

      assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
  }

  @Test
  public void testIsEmptyInit33() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);

      assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
  }


  // isGameOver

  @Test
  public void testIsGameOverInit() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);

      assertFalse("is game over on init", game.isGameOver());
  }

  @Test
  public void testIsGameOverOnEnd() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameComplete);
      assertFalse("is game over on init", game.isGameOver());
  }


  // getTilesToFlip

  @Test
  public void testGetTilesToFlipInit32() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      ArrayList<List<Integer>> tiles = game.getTilesToFlip(3, 2);
      ArrayList<List<Integer>> expected = new ArrayList<>();
      expected.add(Arrays.asList(3, 3));
      expected.add(Arrays.asList(3, 2));

      assertEquals("tiles to flip on onit - (3, 2)", 2, tiles.size());
      assertEquals("...", expected.get(0).get(0), tiles.get(0).get(0));
      assertEquals("...", expected.get(0).get(1), tiles.get(0).get(1));
      assertEquals("...", expected.get(1).get(0), tiles.get(1).get(0));
      assertEquals("...", expected.get(1).get(1), tiles.get(1).get(1));
  }

  @Test
  public void testGetTilesToFlipInit00() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      ArrayList<List<Integer>> tiles = game.getTilesToFlip(0, 0);

      assertEquals("tiles to flip on onit - (0, 0)", 0, tiles.size());
  }


  // flipTiles

  @Test
  public void testFlipTiles() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      ArrayList<List<Integer>> tiles = new ArrayList<>();
      tiles.add(Arrays.asList(3, 3));
      tiles.add(Arrays.asList(3, 2));
      game.flipTiles(tiles);

      assertEquals("...", Player.B, getTile(game, Alpha.C, 4));
      assertEquals("...", Player.B, getTile(game, Alpha.D, 4));
  }

  // getPossibleMoves

  @Test
  public void testGetPossibleMovesEmptyInit() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      ArrayList<String> tiles = game.getPossibleMoves();

      assertEquals("valid length", 4, tiles.size());
      assertEquals("valid moves", "D3", tiles.get(0));
      assertEquals("valid moves", "C4", tiles.get(1));
      assertEquals("valid moves", "F5", tiles.get(2));
      assertEquals("valid moves", "E6", tiles.get(3));
  }

  @Test
  public void testGetPossibleMovesEmpty() {
      Reversi game = getRevWithPlayground();
      ArrayList<String> tiles = game.getPossibleMoves();

      assertEquals("valid length", 0, tiles.size());
  }


  // areValidMoves

  @Test
  public void testAreValidMovesInit() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);

      assertTrue("...", game.areValidMoves());
  }

  @Test
  public void testAreValidMovesOnEnd() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameComplete);

      assertFalse("...", game.areValidMoves());
  }


  // swapPlayerOnTurn

  @Test
  public void testSwapPlayerOnTurnBtoW() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.swapPlayerOnTurn();

      assertEquals("...", Player.W, game.onTurn);
  }

  @Test
  public void testSwapPlayerOnTurnWtoB() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitWStarts);
      game.swapPlayerOnTurn();

      assertEquals("...", Player.B, game.onTurn);
  }

  // endGame

  @Test
  public void testEndGame() throws IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameComplete);
      game.endGame();

      assertTrue("...", game.ended);
      assertEquals("...", Player.B, game.winner);
  }


  // move

  @Test(expected = NotPermittedMoveException.class)
  public void testMoveOnNotEmpty() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.move(Alpha.E,5);
  }

  @Test(expected = NotPermittedMoveException.class)
  public void testMoveOutOfBoundsBelow() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.move(Alpha.A,9);
  }

  @Test(expected = NotPermittedMoveException.class)
  public void testMoveOutOfBoundsAbove() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.move(Alpha.A,0);
  }

  @Test(expected = NotPermittedMoveException.class)
  public void testMoveOnNotAdjacent() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.move(Alpha.A,1);
  }

  @Test
  public void testMoveFlipRight() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.move(Alpha.C,4);

      assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
      assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
      assertEquals("on turn", Player.W, game.onTurn);
      assertEquals("W left", 1, game.getLeftW());
      assertEquals("B left", 4, game.getLeftB());
  }

  @Test
  public void testMoveFlipUp() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.move(Alpha.E, 6);

      assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
      assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 6));
      assertEquals("on turn", Player.W, game.onTurn);
      assertEquals("W left", 1, game.getLeftW());
      assertEquals("B left", 4, game.getLeftB());
  }

  @Test
  public void testMoveFlipLeft() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.move(Alpha.F, 5);

      assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
      assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 5));
      assertEquals("on turn", Player.W, game.onTurn);
      assertEquals("W left", 1, game.getLeftW());
      assertEquals("B left", 4, game.getLeftB());
  }

  @Test
  public void testMoveFlipDown() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.move(Alpha.D, 3);

      assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
      assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 3));
      assertEquals("on turn", Player.W, game.onTurn);
      assertEquals("W left", 1, game.getLeftW());
      assertEquals("B left", 4, game.getLeftB());
  }

  @Test
  public void testMoveFlipRightUp() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
      moves.add(new Pair<>(Alpha.E, 6));
      moves.add(new Pair<>(Alpha.D, 6));
      moves.add(new Pair<>(Alpha.C, 7));
      Reversi game = setMoves(moves);

      assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 6));
      assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 7));
      assertEquals("on turn", Player.W, game.onTurn);
      assertEquals("W left", 2, game.getLeftW());
      assertEquals("B left", 5, game.getLeftB());
  }

  @Test
  public void testMoveFlipLeftUp() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
      moves.add(new Pair<>(Alpha.E, 6));
      moves.add(new Pair<>(Alpha.F, 6));
      Reversi game = setMoves(moves);

      assertEquals("check if flipped", Player.W, getTile(game, Alpha.E, 5));
      assertEquals("check if flipped", Player.W, getTile(game, Alpha.F, 6));
      assertEquals("on turn", Player.B, game.onTurn);
      assertEquals("W left", 3, game.getLeftW());
      assertEquals("B left", 3, game.getLeftB());
  }

  @Test
  public void testMoveFlipLeftDown() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
      moves.add(new Pair<>(Alpha.D, 3));
      moves.add(new Pair<>(Alpha.E, 3));
      moves.add(new Pair<>(Alpha.F, 2));
      Reversi game = setMoves(moves);

      assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 3));
      assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 2));
      assertEquals("on turn", Player.W, game.onTurn);
      assertEquals("W left", 2, game.getLeftW());
      assertEquals("B left", 5, game.getLeftB());
  }

  @Test
  public void testMoveFlipRightDown() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
      moves.add(new Pair<>(Alpha.D, 3));
      moves.add(new Pair<>(Alpha.C, 3));
      Reversi game = setMoves(moves);

      assertEquals("check if flipped", Player.W, getTile(game, Alpha.D, 4));
      assertEquals("check if flipped", Player.W, getTile(game, Alpha.C, 3));
      assertEquals("on turn", Player.B, game.onTurn);
      assertEquals("W left", 3, game.getLeftW());
      assertEquals("B left", 3, game.getLeftB());
  }

  @Test
  public void testMoveDoubleFlip() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
      moves.add(new Pair<>(Alpha.D, 3));
      moves.add(new Pair<>(Alpha.C, 3));
      moves.add(new Pair<>(Alpha.C, 4));
      moves.add(new Pair<>(Alpha.E, 3));
      Reversi game = setMoves(moves);

      assertEquals("check if flipped (D,3) correctly", Player.W, getTile(game, Alpha.D, 3));
      assertEquals("check if flipped (E,4) correctly", Player.W, getTile(game, Alpha.E, 4));
      assertEquals("W left", 5, game.getLeftW());
      assertEquals("B left", 3, game.getLeftB());
  }

  @Test
  public void testMovesCompleteGame() throws NotPermittedMoveException, IncorrectGameConfigFileException {
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
      Reversi game = setMoves(moves);

      assertFalse("if the are valid moves", game.areValidMoves());
      assertEquals("W left", 28, game.getLeftW());
      assertEquals("B left", 36, game.getLeftB());
      assertEquals("winner", Player.B, game.winner);
  }


  // execute

  @Test
  public void testExecute() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.execute("C4");

      assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
      assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
      assertEquals("on turn", Player.W, game.onTurn);
      assertEquals("W left", 1, game.getLeftW());
      assertEquals("B left", 4, game.getLeftB());
  }

  @Test(expected = NotPermittedMoveException.class)
  public void testExecuteA1() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      game.execute("A1");
  }

  @Test
  public void testFinishGame() throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameAlmostComplete);
      game.execute("G7");

      assertFalse("if the are valid moves", game.areValidMoves());
      assertEquals("W left", 28, game.getLeftW());
      assertEquals("B left", 36, game.getLeftB());
      assertEquals("winner", Player.B, game.winner);
  }


  // utility functions

  private Player getTile(Reversi game, Alpha c0, int r0) {
      return game.playground[r0-1][c0.getValue()];
  }


  private Reversi setMoves(ArrayList<Pair<Alpha, Integer>> moves) throws NotPermittedMoveException, IncorrectGameConfigFileException {
      Reversi game = new Reversi(gameInitBStarts);
      for (Pair<Alpha, Integer> move  : moves) {
          Alpha r = move.getKey();
          Integer c = move.getValue();
          game.move(r, c);
      }
      return game;
  }

  private Reversi initReversi(String[] gameConfig) throws IncorrectGameConfigFileException {
      Reversi rev = new Reversi();
      rev.initGame(gameConfig);
      return rev;
  }

  private Reversi getRevWithPlayground() {
      Reversi rev = new Reversi();
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
