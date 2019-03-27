truncate table
	courses,
	lessons,
	exercise_types,
	exercises,
	exercise_sources,
	exercise_tests
restart identity cascade;

INSERT INTO courses (id, name, created, description)
VALUES (1, 'Course One', '2019-03-09 20:53:09.851', 'Course description');

INSERT INTO lessons (id, name, course_id, created, description)
VALUES	(1, 'Lesson one', 1, '2019-03-09 20:53:09.851', 'Lesson description'),
		(2, 'Lesson two', 1, '2019-03-09 20:53:09.851', 'Lesson description');

INSERT INTO exercise_types (id, name, value)
VALUES	(1, 'Black box', 'black-box'),
		(2, 'Multiple Choice Quiz', 'quiz'),
		(3, 'Interactive Lesson', 'white-box'),
		(4, 'Theory', 'theory'),
		(5, 'Self-Evaluation', 'self-eval');

INSERT INTO exercises (id, name, index, lesson_id, type, created, description)
VALUES	(1, 'Exercise one', 0, 1, 'white-box', '2019-03-09 20:53:09.851', 'Exercise one description'),
		(2, 'Exercise two', 1, 1, 'black-box', '2019-03-09 20:53:09.851', 'Exercise two description'),
		(3, 'Exercise three', 2, 1, 'quiz', '2019-03-09 20:53:09.851', 'Exercise three description');

insert into exercise_sources (id, exercise_id, filename, code)
values	(
	1,
	1,
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

insert into exercise_sources (id, exercise_id, filename, code)
values	(
	2,
	1,
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

insert into exercise_sources (id, exercise_id, filename, code)
values	(
	3,
	1,
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


insert into exercise_tests (id, exercise_id, filename, code)
values	(
	1,
	1,
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
