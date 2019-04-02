import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class BlackBoxSwitcher {

    public static boolean BUG_1;

    public static void main(String[] args) {
        try {
            Path flagsPath = new File("./flags/flags.csv").toPath();
//            Path flagsPath = new File("src/sample_black_box/flags.csv").toPath();
            String[] flags = Files.readAllLines(flagsPath).toArray(new String[0]);

            BUG_1 = Boolean.getBoolean(flags[0]);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}