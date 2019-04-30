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
import java.nio.file.Paths;
import java.nio.file.FileSystems;

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
      } catch (IncorrectGameConfigFileException e) {
          ended = true;
          throw new IncorrectGameConfigFileException(e.getMessage());
      }
  }

  String[] readGameConfig(Path gameFilePath) throws IncorrectGameConfigFileException {
      String[] gameConfig;
      try {
          gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
      } catch (NoSuchFileException e) {
            Path currentRelativePath = Paths.get("");
            String s = currentRelativePath.toAbsolutePath().toString();
            System.out.println("Current absolute path is: " + s);
            String fs = gameFilePath.toAbsolutePath().toString();
            System.out.println("File absolute path is: " + fs);
            File curDir = new File(".");
            System.out.println("Curr dir: " + curDir.toPath().toAbsolutePath());
            getAllFiles(curDir);
          throw new IncorrectGameConfigFileException("Game configuration file " + gameFilePath.toFile().toString() + " does not exist");
      } catch (IOException e) {
          throw new IncorrectGameConfigFileException("Could not read game configuration file", e);
      }
      System.out.println(gameConfig);
      return gameConfig;
  }

  private static void getAllFilesRecursively(File curDir) {

        File[] filesList = curDir.listFiles();
        for(File f : filesList){
            if(f.isDirectory())
                getAllFiles(f);
            if(f.isFile()){
                System.out.println(f.getName());
            }
        }

    }

    private static void getAllFiles(File curDir) {

        File[] filesList = curDir.listFiles();
        for(File f : filesList){
            if(f.isDirectory())
                System.out.println(f.getName());
            if(f.isFile()){
                System.out.println(f.getName());
            }
        }

    }

}