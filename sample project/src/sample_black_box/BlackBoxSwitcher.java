package sample_black_box;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class BlackBoxSwitcher {

    public boolean[] BUGS;

    public BlackBoxSwitcher() {
        try {
            Path flagsPath = new File("src/sample_black_box/flags.txt").toPath();
//            Path flagsPath = new File("upload-dir/flags/flags.txt").toPath();
            List<String> flags = Files.readAllLines(flagsPath);
            BUGS = new boolean[flags.size()];
            for (int i = 0; i < flags.size(); i++) {
                BUGS[i] = Boolean.parseBoolean(flags.get(i));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
