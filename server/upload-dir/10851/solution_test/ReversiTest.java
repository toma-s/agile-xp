import org.junit.Test;

import java.nio.file.Paths;
import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();

    @Test
    public void testSample() {
        Reversi game1 = rev;
        Reversi game2 = new Reversi(GameConfig.game8bInit);

        int expected = 1;
        int actual = 1;
        System.out.println(Paths.get("").toAbsolutePath());
        assertEquals(expected, actual);
    }

}