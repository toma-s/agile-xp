truncate table
    courses,
    lessons,
    exercise_types,
    exercises,
    exercise_content
restart identity cascade;

-- general

INSERT INTO exercise_types (id, name, value)
VALUES (1, 'Interactive Exercise', 'source-test'),
       (2, 'Interactive Exercise with Files', 'source-test-file'),
       (3, 'Black Box', 'test'),
       (4, 'Black Box with Files', 'test-file'),
       (5, 'Single-answer Quiz', 'single-quiz'),
       (6, 'Multiple-answer Quiz', 'multiple-quiz'),
       (7, 'Theory', 'theory');

-- Custom course

INSERT INTO courses (id, name, created, description)
VALUES (1, 'Course One', '2019-03-09 20:53:09.851', 'Custom course');

INSERT INTO lessons (id, name, course_id, created, description)
VALUES (1, 'Lesson one', 1, '2019-03-09 20:53:09.851', 'Different exercise types examples'),
       (2, 'Lesson two', 1, '2019-03-09 20:53:09.851', 'Exercises for debugging');

INSERT INTO exercises (id, name, index, lesson_id, type_id, created, description)
VALUES (1, 'Exercise one', 0, 1, 1, '2019-03-09 20:53:09.851', '(source-test)'),
       (2, 'Exercise two', 1, 1, 2, '2019-03-09 20:53:09.851', '(source-test-file)'),
       (3, 'Exercise three', 2, 1, 3, '2019-03-09 20:53:09.851', '(test)'),
       (4, 'Exercise four', 3, 1, 4, '2019-03-09 20:53:09.851', '(test-file)'),
       (5, 'Exercise five', 4, 1, 5, '2019-03-09 20:53:09.851', '(single-quiz)'),
       (6, 'Exercise six', 5, 1, 6, '2019-03-09 20:53:09.851', '(multiple-quiz)'),
       (7, 'Exercise seven', 6, 1, 7, '2019-03-09 20:53:09.851', '(theory)');

-- exercise 1

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content)
values (1,
        1,
        'exercise_source',
        'Morse.java',
        'import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Morse {
  static String[] letters = new String[255];
  static {
      letters[''A''] = ".-";
      letters[''B''] = "-...";
      letters[''C''] = "-.-.";
      letters[''D''] = "-..";
      letters[''E''] = ".";
      letters[''F''] = "..-.";
      letters[''G''] = "--.";
      letters[''H''] = "....";
      letters[''I''] = "..";
      letters[''J''] = ".---";
      letters[''K''] = "-.-";
      letters[''L''] = ".-..";
      letters[''M''] = "--";
      letters[''N''] = "-.";
      letters[''O''] = "---";
      letters[''P''] = ".--.";
      letters[''Q''] = "--.-";
      letters[''R''] = ".-.";
      letters[''S''] = "...";
      letters[''T''] = "-";
      letters[''U''] = "..-";
      letters[''V''] = "...-";
      letters[''W''] = ".--";
      letters[''X''] = "-..-";
      letters[''Y''] = "-.--";
      letters[''Z''] = "--..";
  }
  //------------------------------------------------------ dopisujte odtialto nizsie
  /**
   * @param anglickaSprava - retazec pismen anglickej abecedy ''A''-''Z'' a medzier
   * @return - preklad do morseho kodu, jednotlive pismena ''A''-''Z'' su oddelene jednou mezerou, vstupne medzery sa ignoruju
   */
  public static String koduj(String anglickaSprava) { // toto doprogramuj
      if (anglickaSprava == null || anglickaSprava.isEmpty()) {
          return "";
      }
      StringBuilder kod = new StringBuilder();
      for (int i = 0; i < anglickaSprava.length(); i++) {
          int ch = anglickaSprava.charAt(i);
          if (ch < ''A'' || ch > ''Z'') {
              continue;
          }
          kod.append(letters[ch]).append(" ");
      }
      kod = kod.deleteCharAt(kod.length()-1);
      return kod.toString();
//        return "";
  }


  /**
   * dekoduje stream Morseho symbolov oddelenych aspon nejakymi medzerami
   */
  public static String dekoduj(String sprava) {// toto doprogramuj
      if (sprava == null || sprava.isEmpty()) {
          return "";
      }
      StringBuilder dekod = new StringBuilder();
      String[] postupnost = sprava.split(" ");
      for (String morse : postupnost) {
          if (morse.isEmpty()) {
              continue;
          }
          for (int i = 0; i < letters.length-1; i++) {
              char ch = (char) (i + ''A'');
              if (letters[ch].equals(morse)) {
                  dekod.append((char) ch);
                  break;
              }
              if (i == 25) {
                  return null;
              }
          }
      }
      return dekod.toString();
  }


  /**
   * inverzny homomorfizmus - dekoduje stream Morseho symbolov neoddelenych medzerami, vsetky moznosti
   */
  public static String[] dekodujVsetky(String sprava) { // toto doprogramuj
      List<String> d = backtrack(new StringBuilder(sprava), new StringBuilder(), new ArrayList<>());
      String[] dekodovane = new String[d.size()];
      return d.toArray(dekodovane);
  }

  public static List<String> backtrack(StringBuilder in, StringBuilder out, List<String> vsetky) {
      if (in.length() == 0) {
          vsetky.add(out.toString());
          return vsetky;
      }
      for (int i = 0; i < 26; i++) {
          int len_morse_sym = letters[i+''A''].length();
          if (len_morse_sym > in.length()) {
              continue;
          }
          if (in.substring(0, len_morse_sym).equals(letters[i+''A''])) {
              StringBuilder newin = new StringBuilder(in.substring((letters[i+''A''].length()), in.length()));
              StringBuilder newout = new StringBuilder(out).append((char)(i+''A''));
              vsetky = backtrack(newin, newout, vsetky);
          }
      }
      return vsetky;
  }
}
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content)
values (2,
        1,
        'exercise_source',
        'Player.java',
        'public enum Player {
  B(1), W(0), NONE(-1);

  private final int value;

  Player(int value) {
      this.value = value;
  }

  public int getValue() {
      return value;
  }


}
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content)
values (3,
        1,
        'exercise_source',
        'Alpha.java',
        'public enum Alpha {
  A(0), B(1), C(2), D(3), E(4), F(5), G(6), H(7);

  private final int value;

  Alpha(int value) {
      this.value = value;
  }

  public int getValue() {
      return value;
  }
}
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content)
values (4,
        1,
        'exercise_test',
        'TestMorse.java',
        'import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.Arrays;
import java.util.List;

import org.junit.BeforeClass;
import org.junit.Test;


public class TestMorse {

  @Test
  public void testKoduj() {
      assertEquals("koduj(\"SOS\")", "... --- ...", Morse.koduj("SOS"));
      assertEquals("koduj(\"S O S\")", "... --- ...", Morse.koduj("S O S"));
      assertEquals("koduj(\"S O S SOS SO S\")", "... --- ... ... --- ... ... --- ...", Morse.koduj("S O S SOS SO    S"));
      assertEquals("koduj(\"MAYDAY\")", "-- .- -.-- -.. .- -.--", Morse.koduj("MAYDAY"));
      assertEquals("koduj(\" CQDCQDS OSDEMGYMGYREQUIRIME DIATASISTA NCPOSITION \")", "-.-. --.- -.. -.-. --.- -.. ... --- ... -.. . -- --. -.-- -- --. -.-- .-. . --.- ..- .. .-. .. -- . -.. .. .- - .- ... .. ... - .- -. -.-. .--. --- ... .. - .. --- -.", Morse.koduj(" CQDCQDS OSDEMGYMGYREQUIRIME DIATASISTA NCPOSITION "));
      assertEquals("koduj(\"SOSSOSCQDCQD TITANIC\")", "... --- ... ... --- ... -.-. --.- -.. -.-. --.- -.. - .. - .- -. .. -.-.", Morse.koduj("SOSSOSCQDCQD TITANIC"));
      assertEquals("koduj(\"TO BE OR NOT TO BE THAT IS THE QUESTION\")", "- --- -... . --- .-. -. --- - - --- -... . - .... .- - .. ... - .... . --.- ..- . ... - .. --- -.", Morse.koduj("TO BE OR NOT TO BE THAT IS THE QUESTION"));
  }

  @Test
  public void test_Dekoduj() {
      assertEquals("dekoduj(\"... --- ...\")", "SOS", Morse.dekoduj("... --- ...").trim().toUpperCase());
      assertEquals("dekoduj(\"-- .- -.-- -.. .- -.--\")", "MAYDAY", Morse.dekoduj("-- .- -.-- -.. .- -.--").trim().toUpperCase());
      assertEquals("dekoduj(\".--- .- ...- .-\")", "JAVA", Morse.dekoduj("  .---   .-  ...-    .-   ").trim().toUpperCase());
      assertEquals("dekoduj(\"  ----\")", null, Morse.dekoduj("  ----"));
      assertEquals("dekoduj(\"  ----\")", null, Morse.dekoduj("...  ---. "));
      assertEquals("dekoduj(\"MORSECODE\")","MORSECODE", Morse.dekoduj("-- --- .-. ... .   -.-. --- -.. .").trim().toUpperCase());
      assertEquals("dekoduj(\"CQDCQDSOSDEMGYMGYREQUIRIMEDIATASISTANCPOSITION\")","CQDCQDSOSDEMGYMGYREQUIRIMEDIATASISTANCPOSITION", Morse.dekoduj("-.-. --.- -..   -.-. --.- -..   ... --- ...   -.. .   -- --. -.--   -- --. -.--   .-. . --.- ..- .. .-.   .. -- . -.. .. .- -   .- ... .. ... - .- -. -.-.   .--. --- ... .. - .. --- -.").trim().toUpperCase());
      assertEquals("dekoduj(\"SOSSOSCQDCQDTITANIC\")","SOSSOSCQDCQDTITANIC", Morse.dekoduj("... --- ...   ... --- ...   -.-. --.- -..   -.-. --.- -..   - .. - .- -. .. -.-.").trim().toUpperCase());
      assertEquals("dekoduj(\"TOBEORNOTTOBETHATISTHEQUESTION\")", "TOBEORNOTTOBETHATISTHEQUESTION", Morse.dekoduj("- --- -... . --- .-. -. --- - - --- -... . - .... .- - .. ... - .... . --.- ..- . ... - .. --- -.").trim().toUpperCase());
  }

  @Test(timeout=10000)
  public void test_DekodujVsetky() {
      assertEquals("dekodujVsetky(\"..\").length()", 2, Morse.dekodujVsetky("..").length);
      assertEquals("dekodujVsetky(\".-\").length()", 2, Morse.dekodujVsetky(".-").length);
      assertEquals("dekodujVsetky(\".-.\").length()", 4, Morse.dekodujVsetky(".-.").length);
      assertEquals("dekodujVsetky(\".--\").length()", 4, Morse.dekodujVsetky(".--").length);
      assertEquals("dekodujVsetky(\"...\").length()", 4, Morse.dekodujVsetky("...").length);
      assertEquals("dekodujVsetky(\"....\").length()", 8, Morse.dekodujVsetky("....").length);
      assertEquals("dekodujVsetky(\".....\").length()", 15, Morse.dekodujVsetky(".....").length);
      assertEquals("dekodujVsetky(\"...---...\").length()", 192, Morse.dekodujVsetky("...---...").length);
      assertTrue("dekodujVsetky(\"...---...\") contains SOS", Arrays.asList(Morse.dekodujVsetky("...---...")).contains("SOS"));
      assertFalse("dekodujVsetky(\"...---...\") not contains DPH", Arrays.asList(Morse.dekodujVsetky("...---...")).contains("DPH"));
      assertEquals("dekodujVsetky(\"--.--.---...--.--\").length()", 36536, Morse.dekodujVsetky("--.--.---...--.--").length);
      assertTrue("dekodujVsetky(\"--.--.---...--.--\") contains MAYDAY", Arrays.asList(Morse.dekodujVsetky("--.--.---...--.--")).contains("MAYDAY"));
  }
}
');

-- exercise 2

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content)
values (5,
        2,
        'exercise_source',
        'Reversi.java',
        'import java.io.BufferedReader;
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
      String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

      File gameFile = new File("upload-dir/game_config/" + fileName);
      Path gameFilePath = gameFile.toPath();

      Reversi rev;
      try {
          rev = new Reversi(gameFilePath);
          rev.run();
      } catch (IncorrectGameConfigFileException e) {
          System.out.println(e.getMessage());
      }

  }

}'); -- ReversiMoveException

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- IncorrectGameConfigFileException
values (6,
        2,
        'exercise_source',
        'IncorrectGameConfigFileException.java',
        'public class IncorrectGameConfigFileException extends Exception {

  public IncorrectGameConfigFileException(String message) {
      super(message);
  }

  public IncorrectGameConfigFileException(String message, Throwable cause) {
      super(message, cause);
  }
}');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- NotPermittedMoveException
values (7,
        2,
        'exercise_source',
        'NotPermittedMoveException.java',
        'public class NotPermittedMoveException extends Exception {

  public NotPermittedMoveException(String message) {
      super(message);
  }
}');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- Alpha
values (8,
        2,
        'exercise_source',
        'Alpha.java',
        'public enum Alpha {
    A(0), B(1), C(2), D(3), E(4), F(5), G(6), H(7);

    private final int value;

    Alpha(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- Player
values (9,
        2,
        'exercise_source',
        'Player.java',
        'public enum Player {
    B(1), W(0), NONE(-1);

    private final int value;

    Player(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

}');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- ReversiRefactoredTest
values (10,
        2,
        'exercise_test',
        'ReversiTest.java',
        'import javafx.util.Pair;
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
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- game_init_b_starts
values (11,
        2,
        'exercise_file',
        'game_init_b_starts.txt',
        'B
E4 D5
D4 E5
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- game_init_w_starts
values (12,
        2,
        'exercise_file',
        'game_init_w_starts.txt',
        'W
E4 D5
D4 E5
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- game_all_alpha
values (13,
        2,
        'exercise_file',
        'game_all_alpha.txt',
        'B
EE DD
DD EE
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- game_all_num
values (14,
        2,
        'exercise_file',
        'game_all_num.txt',
        'B
EE DD
DD EE
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- game_almost_complete
values (15,
        2,
        'exercise_file',
        'game_almost_complete.txt',
        'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- game_complete
values (16,
        2,
        'exercise_file',
        'game_complete.txt',
        'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- game_empty
values (17,
        2,
        'exercise_file',
        'game_empty.txt',
        '');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- game_four_lines
values (18,
        2,
        'exercise_file',
        'game_four_lines.txt',
        'B
E4 D5
D4 E5
E4 D5
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- game_no_on_turn
values (19,
        2,
        'exercise_file',
        'game_no_on_turn.txt',
        'E4 D5
D4 E5
');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content) -- game_one_line
values (20,
        2,
        'exercise_file',
        'game_one_line.txt',
        'E4 D5
');

-- exercise 3

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content)
values (21,
        3,
        'exercise_source',
        'HelloWorld.java',
        'class HelloWorld {

    private BlackBoxSwitcher switcher = new BlackBoxSwitcher();

    int returnTheSame(int input) {
        if (switcher.BUGS[0]) {
            if (input == 1) {
                return -1;
            }
        }
        if (switcher.BUGS[1]) {
            if (input == 2) {
                return -2;
            }
        }
        return input;
    }
}');

insert into exercise_content (id, exercise_id, exercise_content_type, filename, content)
values (22,
        3,
        'exercise_test',
        'HelloWorldTest.java',
        'import org.junit.Test;
import static org.junit.Assert.*;

public class HelloWorldTest {

    private HelloWorld helloWord = new HelloWorld();

    @Test
    public void test1FindsBug() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(1);
        assertEquals(1, result);
    }

    @Test
    public void test1FindsBugDuplicate() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(1);
        assertEquals(1, result);
    }

    @Test
    public void test2FindsBug() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(2);
        assertEquals(2, result);
    }

    @Test
    public void test3Ok() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(3);
        assertEquals(3, result);
    }

    @Test
    public void test3FakeBug() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(3);
        assertEquals(-3, result);
    }

    @Test
    public void test3FakeBugDuplicate() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(3);
        assertEquals(-3, result);
    }

}');

-- sample

INSERT INTO courses (id, name, created, description)
VALUES (2, 'Sample course', '2019-03-28 11:08:09.851',
        'Web application functionality overview. Use agile programming methods to build a game, based on a legacy content');

INSERT INTO lessons (id, name, course_id, created, description)
VALUES (3, 'Debugging the legacy program', 2, '2019-03-28 11:08:09.851',
        'The aim is to find bugs in the legacy program and fix them, but keep the original structure of the content. The user should write his/her own tests to find the bugs and fix them');

INSERT INTO lessons (id, name, course_id, created, description)
VALUES (4, 'Adding new features to the legacy program', 2, '2019-03-28 11:08:09.851',
        'The aim is to add some features to the legacy content');

INSERT INTO lessons (id, name, course_id, created, description)
VALUES (5, 'Refactoring lesson', 2, '2019-03-28 11:08:09.851',
        'The aim is to refactor the content of the legacy program so the program remains functional. Every exercise corresponds to a step of refactoring');
