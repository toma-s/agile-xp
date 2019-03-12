truncate table
	courses,
	lessons,
	exercise_types,
	exercises
restart identity cascade;

INSERT INTO courses (id, name, created, description)
VALUES (1, ''Course One'', ''2019-03-09 20:53:09.851'', ''Course description'');

INSERT INTO lessons (id, name, course_id, created, description)
VALUES	(1, ''Lesson one'', 1, ''2019-03-09 20:53:09.851'', ''Lesson description''),
		(2, ''Lesson two'', 1, ''2019-03-09 20:53:09.851'', ''Lesson description'');

INSERT INTO exercise_types (id, name, value)
VALUES	(1, ''Black box'', ''black-box''),
		(2, ''Multiple Choice Quiz'', ''quiz''),
		(3, ''Interactive Lesson'', ''white-box''),
		(4, ''Theory'', ''theory''),
		(5, ''Self-Evaluation'', ''self-eval'');

INSERT INTO exercises (id, name, lesson_id, type, created, description)
VALUES	(1, ''Exercise one'', 1, ''white-box'', ''2019-03-09 20:53:09.851'', ''Exercise one description''),
		(2, ''Exercise two'', 1, ''black-box'', ''2019-03-09 20:53:09.851'', ''Exercise two description''),
		(3, ''Exercise three'', 1, ''quiz'', ''2019-03-09 20:53:09.851'', ''Exercise three description'');

insert into exercise_sources (id, exercise_id, filename, code)
values	(
	1,
	1,
	''Morse.java'',
	''import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Morse {
    static String[] letters = new String[255];
    static {
        letters[''''A''''] = ".-";
        letters[''''B''''] = "-...";
        letters[''''C''''] = "-.-.";
        letters[''''D''''] = "-..";
        letters[''''E''''] = ".";
        letters[''''F''''] = "..-.";
        letters[''''G''''] = "--.";
        letters[''''H''''] = "....";
        letters[''''I''''] = "..";
        letters[''''J''''] = ".---";
        letters[''''K''''] = "-.-";
        letters[''''L''''] = ".-..";
        letters[''''M''''] = "--";
        letters[''''N''''] = "-.";
        letters[''''O''''] = "---";
        letters[''''P''''] = ".--.";
        letters[''''Q''''] = "--.-";
        letters[''''R''''] = ".-.";
        letters[''''S''''] = "...";
        letters[''''T''''] = "-";
        letters[''''U''''] = "..-";
        letters[''''V''''] = "...-";
        letters[''''W''''] = ".--";
        letters[''''X''''] = "-..-";
        letters[''''Y''''] = "-.--";
        letters[''''Z''''] = "--..";
    }
    //------------------------------------------------------ dopisujte odtialto nizsie
    /**
     * @param anglickaSprava - retazec pismen anglickej abecedy ''''A''''-''''Z'''' a medzier
     * @return - preklad do morseho kodu, jednotlive pismena ''''A''''-''''Z'''' su oddelene jednou mezerou, vstupne medzery sa ignoruju
     */
    public static String koduj(String anglickaSprava) { // toto doprogramuj
        if (anglickaSprava == null || anglickaSprava.isEmpty()) {
            return "";
        }
        StringBuilder kod = new StringBuilder();
        for (int i = 0; i < anglickaSprava.length(); i++) {
            int ch = anglickaSprava.charAt(i);
            if (ch < ''''A'''' || ch > ''''Z'''') {
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
                char ch = (char) (i + ''''A'''');
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
            int len_morse_sym = letters[i+''''A''''].length();
            if (len_morse_sym > in.length()) {
                continue;
            }
            if (in.substring(0, len_morse_sym).equals(letters[i+''''A''''])) {
                StringBuilder newin = new StringBuilder(in.substring((letters[i+''''A''''].length()), in.length()));
                StringBuilder newout = new StringBuilder(out).append((char)(i+''''A''''));
                vsetky = backtrack(newin, newout, vsetky);
            }
        }
        return vsetky;
    }
}
'');

