import java.util.ArrayList;
        import java.util.Arrays;
        import java.util.List;

        public class Morse {
            static String[] letters = new String[255];
            static {
                letters['A'] = ".-";
                letters['B'] = "-...";
                letters['C'] = "-.-.";
                letters['D'] = "-..";
                letters['E'] = ".";
                letters['F'] = "..-.";
                letters['G'] = "--.";
                letters['H'] = "....";
                letters['I'] = "..";
                letters['J'] = ".---";
                letters['K'] = "-.-";
                letters['L'] = ".-..";
                letters['M'] = "--";
                letters['N'] = "-.";
                letters['O'] = "---";
                letters['P'] = ".--.";
                letters['Q'] = "--.-";
                letters['R'] = ".-.";
                letters['S'] = "...";
                letters['T'] = "-";
                letters['U'] = "..-";
                letters['V'] = "...-";
                letters['W'] = ".--";
                letters['X'] = "-..-";
                letters['Y'] = "-.--";
                letters['Z'] = "--..";
            }
            //------------------------------------------------------ dopisujte odtialto nizsie
            /**
             * @param anglickaSprava - retazec pismen anglickej abecedy 'A'-'Z' a medzier
             * @return - preklad do morseho kodu, jednotlive pismena 'A'-'Z' su oddelene jednou mezerou, vstupne medzery sa ignoruju
             */
            public static String koduj(String anglickaSprava) { // toto doprogramuj
                if (anglickaSprava == null || anglickaSprava.isEmpty()) {
                    return "";
                }
                StringBuilder kod = new StringBuilder();
                for (int i = 0; i < anglickaSprava.length(); i++) {
                    int ch = anglickaSprava.charAt(i);
                    if (ch < 'A' || ch > 'Z') {
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
                        char ch = (char) (i + 'A');
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
                    int len_morse_sym = letters[i+'A'].length();
                    if (len_morse_sym > in.length()) {
                        continue;
                    }
                    if (in.substring(0, len_morse_sym).equals(letters[i+'A'])) {
                        StringBuilder newin = new StringBuilder(in.substring((letters[i+'A'].length()), in.length()));
                        StringBuilder newout = new StringBuilder(out).append((char)(i+'A'));
                        vsetky = backtrack(newin, newout, vsetky);
                    }
                }
                return vsetky;
            }
        }
        