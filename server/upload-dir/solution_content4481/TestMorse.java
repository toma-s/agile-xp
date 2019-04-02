import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.Arrays;
import java.util.List;

import org.junit.BeforeClass;
import org.junit.Test;


public class TestMorse {

 

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
