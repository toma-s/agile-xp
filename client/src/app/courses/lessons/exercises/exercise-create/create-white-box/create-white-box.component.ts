import { Component, OnInit, Input, Inject } from '@angular/core';
import { ControlContainer, FormGroupDirective, FormGroup, FormBuilder, Validators, FormControl, FormArray } from '@angular/forms';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';

@Component({
  selector: 'create-white-box',
  templateUrl: './create-white-box.component.html',
  styleUrls: ['./create-white-box.component.scss'],
  viewProviders: [ {
    provide: ControlContainer,
    useExisting: FormGroupDirective
  }]
})
export class CreateWhiteBoxComponent implements OnInit {

  editorOptions = {theme: 'vs', language: 'java'};

  @Input() exerciseFormGroup: FormGroup;

  constructor(
    private fb: FormBuilder,
    public dialog: MatDialog
  ) { }

  ngOnInit(): void {
    console.log(this.exerciseFormGroup);
    this.updForm();
  }

  updForm() {
    this.exerciseFormGroup.addControl(
      // 'sources', this.fb.array([this.createSource()])
      'sources', this.fb.array([this.createSource1(), this.createSource2()])
    );
    this.exerciseFormGroup.addControl(
      // 'tests', this.fb.array([this.createTest()])
      'tests', this.fb.array([this.createTest1()])
    );
  }

  createSource1() {
    return this.fb.group({
      sourceFilename: ['Morse.java', Validators.compose([Validators.required])],
      sourceCode: [`import java.util.ArrayList;
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
      `, Validators.compose([Validators.required])]
    });
  }

  createSource2() {
    return this.fb.group({
      sourceFilename: ['Player.java', Validators.compose([Validators.required])],
      sourceCode: [`public enum Player {
        B(1), W(0), NONE(-1);

        private final int value;

        Player(int value) {
            this.value = value;
        }

        public int getValue() {
            return value;
        }

    }
    `, Validators.compose([Validators.required])]
    });
  }

  createTest1() {
    return this.fb.group({
      testFilename: ['TestMorse.java', Validators.compose([Validators.required])],
      testCode: [`import static org.junit.Assert.assertEquals;
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
      `, Validators.compose([Validators.required])]
    });
  }

  // ------------------

  createSource() {
    return this.fb.group({
      sourceFilename: ['SourceCodeFileName.java', Validators.compose([Validators.required])],
      sourceCode: ['', Validators.compose([Validators.required])]
    });
  }

  createTest() {
    return this.fb.group({
      testFilename: ['TestFileName.java', Validators.compose([Validators.required])],
      testCode: ['', Validators.compose([Validators.required])]
    });
  }

  editFileName(formControl: FormControl) {
    const dialogRef = this.dialog.open(DialogOverviewExampleDialogComponent);
    dialogRef.afterClosed().subscribe(result => {
      if (result === undefined) { return; }
      formControl.setValue(`${result}.java`);
    });
  }

  removeSourceFile(index) {
    const sources = this.exerciseFormGroup.get('sources') as FormArray;
    sources.removeAt(index);
  }

  removeTestFile(index) {
    const tests = this.exerciseFormGroup.get('tests') as FormArray;
    tests.removeAt(index);
  }

  addSourceFile() {
    const sources = this.exerciseFormGroup.get('sources') as FormArray;
    sources.push(this.createSource());
  }

  addTestFile() {
    const tests = this.exerciseFormGroup.get('tests') as FormArray;
    tests.push(this.createTest());
  }

}

@Component({
  selector: 'dialog-result-example-dialog',
  template: `
    <div>
      <p mat-dialog-title>Enter new file name:</p>
      <mat-form-field>
        <input autofocus matInput [(ngModel)]="fileName">
      </mat-form-field>.java
      <div mat-dialog-actions>
        <button mat-button [mat-dialog-close]="fileName">Save</button>
        <button mat-button (click)="onNoClick()">Cancel</button>
      </div>
    </div>`,
})
export class DialogOverviewExampleDialogComponent {

  constructor(
    public dialogRef: MatDialogRef<DialogOverviewExampleDialogComponent>,
    // @Inject(MAT_DIALOG_DATA) public fileName: string
    ) {}

  onNoClick(): void {
    this.dialogRef.close();
  }
}
