import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Reversi {

  private static final int SIZE = 8;
  Player[][] playground;
  private HashMap<Player, Integer> left = new HashMap<>() {{ put(Player.B, 0); put(Player.W, 0); }};
  private Player[] players = new Player[] { Player.B, Player.W };
  Player onTurn = Player.NONE;
  Player winner = Player.NONE;
  boolean ended = false;

  Reversi() {
  }

  Reversi(Path gameFilePath) throws IncorrectGameConfigFileException {
      try {
          String[] gameConfig = readGameConfig(gameFilePath);
          initGame(gameConfig);
          initTilesCount();
      } catch (IncorrectGameConfigFileException e) {
          ended = true;
          throw new IncorrectGameConfigFileException(e.getMessage());
      }
  }

  private void run() throws IncorrectGameConfigFileException {
      BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
      try {
          String line;
          while (!ended) {
              printPlayground();
              printTilesLeftCount();
              System.out.format("Make a move. %s is on turn\n", onTurn);
              if (winner != Player.NONE) break;
              if ((line = reader.readLine()) == null) break;
              execute(line);
              reader.close();
          }
      } catch (IOException e) {
          throw new IncorrectGameConfigFileException("IO exception occurred on reading user input: " + e.getMessage());
      }
  }

  String[] readGameConfig(Path gameFilePath) throws IncorrectGameConfigFileException {
      String[] gameConfig;
      try {
          gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
      } catch (NoSuchFileException e) {
          throw new IncorrectGameConfigFileException("Game configuration file does not exist.");
      } catch (IOException e) {
          throw new IncorrectGameConfigFileException("Could not read game configuration file.", e);
      }
      return gameConfig;
  }

  void initGame(String[] gameConfig) throws IncorrectGameConfigFileException {
      if (gameConfig == null) {
          throw new IncorrectGameConfigFileException("Game configuration is null");
      }
      if (gameConfig.length != 3) {
          throw new IncorrectGameConfigFileException("Game configuration must contain 3 lines.");
      }
      try {
          setOnTurn(gameConfig[0]);
          createPlayground();
          fillPlayground(gameConfig);
      } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
          throw new IncorrectGameConfigFileException("Game configuration is incorrect.");
      }
  }

  void setOnTurn(String player) throws IncorrectGameConfigFileException {
      if (!isOnTurnInputCorrect(player)) {
          throw new IncorrectGameConfigFileException("Incorrect player on turn input.");
      }
      onTurn = Player.valueOf(player);
  }

  boolean isOnTurnInputCorrect(String onTurn) {
      return onTurn != null && onTurn.matches("[B|W]");
  }

  void createPlayground() {
      playground = new Player[SIZE][SIZE];
      for (int r = 0; r < SIZE; r++) {
          for (int c = 0; c < SIZE; c++) {
              playground[r][c] = Player.NONE;
          }
      }
  }

  void fillPlayground(String[] gameConfig) throws IncorrectGameConfigFileException {
      try {
          for (int i = 1; i < 3; i++) {
              String[] tiles = gameConfig[i].split(" ");
              for (String tile : tiles) {
                  setTile(tile, players[i - 1]);
              }
          }
      } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
          throw new IncorrectGameConfigFileException("Game configuration file is incorrect.");
      }
  }

  void setTile(String tile, Player player) throws IncorrectGameConfigFileException {
      if (!isTileInputCorrect(tile)) {
          throw new IncorrectGameConfigFileException("Incorrect tile input");
      }
      int r = Integer.parseInt(tile.substring(1, 2)) - 1;
      int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
      playground[r][c] = player;
  }

  void initTilesCount() throws IncorrectGameConfigFileException {
      try {
          for (int r = 0; r < SIZE; r++) {
              for (int c = 0; c < SIZE; c++) {
                  if (playground[r][c] == Player.B) {
                      left.put(Player.B, left.get(Player.B) + 1);
                  } else if (playground[r][c] == Player.W) {
                      left.put(Player.W, left.get(Player.W) + 1);
                  }
              }
          }
      } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
          throw new IncorrectGameConfigFileException("Playground  is not valid");
      }
  }

  private void printPlayground() {
      String[] abc = "ABCDEFGH".split("");
      System.out.printf("  %s\n", String.join(" ", abc));
      for (int r = 0; r < SIZE; r++) {
          System.out.print((r + 1) + " ");
          for (int c = 0; c < SIZE; c++) {
              switch (playground[r][c]) {
                  case B: System.out.print("B "); break;
                  case W: System.out.print("W "); break;
                  case NONE: System.out.print("_ "); break;
              }
          }
          System.out.println();
      }
  }

  private void printTilesLeftCount() {
      System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
  }

  int getLeftB() {
      return left.get(Player.B);
  }

  int getLeftW() {
      return left.get(Player.W);
  }

  void execute(String tile) {
      if (!isTileInputCorrect(tile)) {
          System.out.println("Incorrect tile input");
          return;
      }
      int r = Integer.parseInt(tile.substring(1, 2));
      Alpha c = Alpha.valueOf(tile.substring(0, 1));
      move(c, r);
  }

  boolean isTileInputCorrect(String tile) {
      if (tile.length() != 2) return false;
      String r = tile.substring(1, 2);
      String c = tile.substring(0, 1);
      return r.matches("[1-8]") && c.matches("[A-H]");
  }

  void move(Alpha c0, int r0) {
      int r = r0 - 1;
      int c = c0.getValue();

      if (!(isWithinPlayground(r, c))) {
          System.out.println("Move out of bounds is not permitted");
          return;
      }
      if (!isEmpty(r, c)) {
          System.out.println("Move on not empty tile is not permitted");
          return;
      }
      if (isGameOver()) {
          System.out.println("The game is over. No moves are permitted");
          return;
      }

      ArrayList<List<Integer>> tilesToFlip = getTilesToFlip(r, c);
      if (tilesToFlip.size() == 0) {
          System.out.println("Move is not permitted");
          return;
      }
      flipTiles(tilesToFlip);

      swapPlayerOnTurn();
      if (! areValidMoves()) endGame();
  }

  boolean isWithinPlayground(int r, int c) {
      return r >= 0 && c >= 0 && r < SIZE && c < SIZE;
  }

  boolean isEmpty(int r, int c) {
      return playground[r][c] == Player.NONE;
  }

  boolean isGameOver() {
      return winner != Player.NONE;
  }

  ArrayList<List<Integer>> getTilesToFlip(int r0, int c0) {
      ArrayList<List<Integer>> toFLip = new ArrayList<>();
      playground[r0][c0] = onTurn;
      Player opposite = Player.NONE;
      if (onTurn == Player.W) opposite = Player.B;
      else if (onTurn == Player.B) opposite = Player.W;

      int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
      for (int[] direction : directions) {
          int r = r0;
          int c = c0;
          r += direction[0];
          c += direction[1];
          if (isWithinPlayground(r, c) && playground[r][c] != opposite) continue;
          r += direction[0];
          c += direction[1];
          if (!isWithinPlayground(r, c)) continue;
          while (playground[r][c] == opposite) {
              r += direction[0];
              c += direction[1];
              if (!isWithinPlayground(r, c)) break;
          }
          if (!isWithinPlayground(r, c)) continue;
          if (playground[r][c] != onTurn) continue;
          while (true) {
              r -= direction[0];
              c -= direction[1];
              if (r == r0 && c == c0) break;
              toFLip.add(new ArrayList<>(List.of(r, c)));
          }
      }

      playground[r0][c0] = Player.NONE;
      if (toFLip.size() != 0) {
          toFLip.add(new ArrayList<>(List.of(r0, c0)));
      }
      return toFLip;
  }

  void flipTiles(ArrayList<List<Integer>> tiles) {
      tiles.forEach(tile -> {
          Player previous = playground[tile.get(0)][tile.get(1)];
          playground[tile.get(0)][tile.get(1)] = onTurn;
          if (previous == Player.NONE) {
              left.put(onTurn, left.get(onTurn) + 1);
          } else if (previous != onTurn) {
              left.put(previous, left.get(previous) - 1);
              left.put(onTurn, left.get(onTurn) + 1);
          }
      });
  }

  boolean areValidMoves() {
      int movesNum = getPossibleMoves().size();
      return movesNum != 0;
  }

  ArrayList<String> getPossibleMoves() {
      ArrayList<String> tiles = new ArrayList<>();
      for (int r = 0; r < 8; r++) {
          for (int c = 0; c < 8; c++) {
              if (playground[r][c] != Player.NONE) continue;
              if (getTilesToFlip(r,c).size() == 0) continue;
              String rString = String.valueOf(r + 1);
              String cString = Alpha.values()[c].toString();
              tiles.add(cString.concat(rString));
          }
      }
      return tiles;
  }

  void swapPlayerOnTurn() {
      if (onTurn == Player.W) onTurn = Player.B;
      else if (onTurn == Player.B) onTurn = Player.W;
  }

  void endGame() {
      printTilesLeftCount();
      ended = true;
      if (getLeftB() > getLeftW()) winner = Player.B;
      else if (getLeftW() > getLeftB()) winner = Player.W;
  }


  public static void main(String[] args) {
      String filename = "game_init_b_starts.txt";
//        String filename = "game_empty.txt";
//        String filename = "game_one_line.txt";
//        String filename = "game_three_lines.txt";
//        String filename = "game_all_num.txt";
//        String filename = "game_all_alpha.txt";

      File gameFile = new File("upload-dir/game_config/" + filename);
      Path gameFilePath = gameFile.toPath();

      Reversi rev;
      try {
          rev = new Reversi(gameFilePath);
          rev.run();
      } catch (IncorrectGameConfigFileException e) {
          System.out.println(e.getMessage());
      }

  }

}