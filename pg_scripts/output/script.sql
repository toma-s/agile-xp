drop table if exists courses CASCADE;
create table courses (
	id serial primary key,
	name text,
    description text,
	created timestamp
);

drop table if exists lessons CASCADE;
create table lessons (
	id serial primary key,
	name text,
    description text,
    index int,
    created timestamp,
	course_id int references courses on delete cascade
);

drop table if exists exercise_types CASCADE;
create table exercise_types (
	id serial primary key,
	name text,
	value text,
	constraint unique_name unique (name),
	constraint unique_value unique (value)
);

drop table if exists exercises CASCADE;
create table exercises (
	id serial primary key,
	name text,
    description text,
	index int,
    created timestamp,
    solved boolean,
    type_id int references exercise_types on delete cascade,
	lesson_id int references lessons on delete cascade
);

drop table if exists exercise_content cascade;
create table exercise_content (
    id serial primary key,
    filename text,
    content text,
    exercise_id int references exercises on delete cascade,
    exercise_content_type text
);

drop table if exists bugs_number cascade;
create table bugs_number (
    id serial primary key,
    exercise_id int references exercises on delete cascade,
    number int,
    constraint unique_exercise_id unique (exercise_id)
);

drop table if exists solutions cascade;
create table solutions (
	id serial primary key,
    created timestamp,
	exercise_id int references exercises on delete cascade
);

drop table if exists solution_content cascade;
create table solution_content (
    id serial primary key,
    filename text,
    content text,
    solution_id int references solutions on delete cascade,
    solution_content_type text
);

drop table if exists solution_estimation cascade;
create table solution_estimation (
	id serial primary key,
	solution_id int,
	estimation text,
	value int,
    solved boolean,
    created timestamp
);

INSERT INTO exercise_types (id, name, value)
VALUES (1, 'Interactive Exercise', 'whitebox'),
       (2, 'Interactive Exercise with Files', 'whitebox-file'),
       (3, 'Black Box', 'blackbox'),
       (4, 'Black Box with Files', 'blackbox-file'),
       (5, 'Theory', 'theory');

INSERT INTO courses (name, created, description, id)
VALUES ('Sample course', '2019-03-28 11:08:09.851', 'Web application functionality overview. Use agile programming methods to build a game, based on a legacy content', 1);

INSERT INTO lessons (name, created, description, id, index, course_id)
VALUES ('Debugging a legacy program', '2019-03-28 11:08:09.851', 'Exercises on finding and fixing bugs in a legacy program', 1, 0, 1);

INSERT INTO lessons (name, created, description, id, index, course_id)
VALUES ('Adding new features to the legacy program', '2019-03-28 11:08:09.851', 'Exercise on adding a new feature to the legacy program', 2, 1, 1);

INSERT INTO lessons (name, created, description, id, index, course_id)
VALUES ('Refactoring the legacy program', '2019-03-28 11:08:09.851', 'Exercises on refactoring the content of the legacy program', 3, 2, 1);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Intro', 5, '2019-03-28 11:08:09.851', 1, 0, 1, '<h2>Course overview</h2><p>In this course you would work on an interactive Reversi game, based on a legacy program.</p><p>The work on the project would be done in three lessons, which represent iterations of the work on the program. Each lesson would have exercises, which would provide feedback and lead through the work on the project.</p><p>While working on project you would learn Extreme programming methods and apply your skills. Most of the exercises would cover several of these skills, like test-driven development, unit testing, refactoring and working with legacy code.</p><h4>Testing</h4><p>The first iteration provides exercises on debugging the legacy program. The aim is to find bugs in the legacy program and fix them, but keep the original structure of the code. Writing own tests is necessary to achieve it. The second iteration is aimed to add some features to the code, bud to keep the original structure of the code as well. Tests, used in a previous iteration, with the new tests would be needed to accomplish the iteration requirements. The last iteration is made up with numerous exercises on refactoring. The tests are essential to proof that the program would remain correct.</p><h4>Refactoring</h4><p>The refactoring exercises take place in the third, last iteration. At this moment, after the previous two iterations are completed successfully and passed all the tests, the code would be correct. Each of the numerous exercises is about a single step of the code change, exercise description and title would reference to the book \"Clean Code\" by Robert C. Martin. It is one of the mostly recommended books for software development, and for a good reason. During and after refactoring the code should maintain correct, and it can be provided by tests, written by the user.</p><h4>Legacy program overview</h4><p>The legacy program is a two-player interactive Reversi game. The rules can be found here <a href=\"http://www.flyordie.com/games/help/reversi/en/games_rules_reversi.html\" target=\"_blank\" style=\"color: rgb(65, 131, 196);\">http://www.flyordie.com/games/help/reversi/en/games_rules_reversi.html</a></p><p>The game is played from console. The state of the game is read from configuration files, which have the following structure:</p><ul><li>first row has \"B\" or \"W\", which means the player on turn,</li><li>the second row contains the pieces of the player, whose color is black,</li><li>and the third row contains the pieces of the player, whose color is white.</li></ul><p>Pieces are represented by two numbers, which mean row and column index started from 0 (e.g. 01). These numbers are separated by space, and each pair of them is separated by comma.</p>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Finding the Bugs in Legacy Program', 4, '2019-03-28 11:08:09.851', 2, 1, 1, '<h2>Objective</h2><p>You need to find bugs in the legacy program, but the source code is not available.</p><p>Write own tests to find the bugs.</p><h3><strong>User stories</strong></h3><ul><li>find&nbsp;<strong>three&nbsp;</strong>bugs.</li></ul><p><br></p><h2>Source code structure</h2><pre class=\"ql-syntax\" spellcheck=\"false\">public class Reversi {<br><br>    int[][] playground;<br>    int leftB = 0;<br>    int leftW = 0;<br>    private int[] players = new int[] { 1, 0 };<br>    int onTurn = -1;<br>    int winner = -1;<br>    boolean ended = false;<br><br>    Reversi() { }<br>    Reversi(Path gameFilePath) {...}<br><br>    String[] readGameConfig(Path gameFilePath) {...}<br>    void initGame(String[] gameConfig) {...}<br>    void initPiecesCount() {...}<br>    private void run() {...}<br>    int getLeftB() {...}<br>    int getLeftW() {...}<br>    void move(int r0, int c0) {...}<br>    boolean areValidMoves() {...}<br>    public static void main(String[] args) {...}<br>}<br></pre>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Debugging the Legacy Program', 2, '2019-03-28 11:08:09.851', 3, 2, 1, '<h2>Objective</h2><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">Fix bugs in the legacy program from previous exercise. You can use tests you wrote to find the bugs.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">When fixing the legacy program, you should keep the original core structure of the code. The program should pass all your and hidden tests.</span></p><p></p><h3><strong>User stories</strong></h3><ul><li>fix <strong>three </strong>bugs</li><li>do not make more.</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Adding New Feature', 2, '2019-03-28 11:08:09.851', 4, 0, 2, '<h2>Objective</h2><p>Add a new feature to the legacy code: the board would be of aby size, defined in a configurations file.</p><p>Use <em>size</em> variable to represent the size value instead of magic constants in legacy program.&nbsp;As a result, this repeatedly used variable gets a name, which describes its meaning, and it becomes easier to read, maintain and change the code.</p><p>Configuration files would have a different structure, the first row would contain value of the board size.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>The board&nbsp;should&nbsp;be of size, defined by a configurations file</li><li>Use <em>size </em>variable to represent the board size</li><li>Board enumeration should be used on printed out playground</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Constants versus Enums', 2, '2019-03-28 11:08:09.851', 5, 0, 3, '<h2>Objective</h2><blockquote>Now that enums have been added to the language (Java 5), use them! Don’t keep using the old trick of <em>public static final int</em>s. The meaning of <em>int</em>s can get lost. The meaning of <em>enum</em>s cannot, because they belong to an enumeration that is named. What’s more, study the syntax for <em>enum</em>s carefully. They can have methods and fields. This makes them very powerful tools that allow much more expression and flexibility than <em>int</em>s.&nbsp;<br><em>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Use&nbsp;<em>Player</em>&nbsp;<em>enum</em>&nbsp;to represent the players'' values:</p><ul><li><em>Player.W</em>&nbsp;for ''W'' instead of 0;</li><li><em>Player.B</em>&nbsp;for ''B'' instead of 1;</li><li><em>Player.NONE</em>&nbsp;for no player instead of -1.</li></ul><p>Use new <em>enum </em>for initialing the game and to print out the current state.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Use&nbsp;<em>Player</em>&nbsp;<em>enum</em>&nbsp;to represent the players'' values.</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('No Duplication', 2, '2019-03-28 11:08:09.851', 6, 1, 3, '<h2>Objective</h2><blockquote>Duplication is the primary enemy of a well-designed system. It represents additional work, additional risk, and additional unnecessary complexity. Duplication manifests itself in many forms. Lines of code that look exactly alike are, of course, duplication. Lines of code that are similar can often be massaged to look even more alike so that they can be more easily refactored.&nbsp;<em>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Make the code way more readable and maintainable with extracting the duplicate code into functions.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Extract function&nbsp;<em>isPieceInputCorrect&nbsp;</em>from functions&nbsp;<em>setPiece&nbsp;</em>and&nbsp;<em>execute</em></li><li>Extract function&nbsp;<em>isWithinPlayground&nbsp;</em>from functions&nbsp;<em>move&nbsp;</em>and&nbsp;<em>getPiecesToFlip.</em></li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Do One Thing', 2, '2019-03-28 11:08:09.851', 7, 2, 3, '<h2>Objective</h2><blockquote>Functions should do one thing. They should do it well. They should do it only.&nbsp;<br>So, another way to know that a function is doing more than “one thing” is if you can extract another function from it with a name that is not merely a restatement of its implementation.&nbsp;<br><em>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>For example, function&nbsp;<em>initGame&nbsp;</em>does not initialize game only, but also sets a player on turn, creates and fills playground, and places the pieces on it. Function&nbsp;<em>run&nbsp;</em>contains execution of the read line, which should be extracted as well. Function&nbsp;<em>move&nbsp;</em>does multiple things as well: it ends the game, finds pieces to flip, and flips them. Function&nbsp;<em>areValidMoves&nbsp;</em>gets possible moves. It also finds pieces to flip as well as&nbsp;<em>move</em>&nbsp;function with the use of duplicate code.</p><p>Make the current code way more readable and maintainable with extracting the functions from the ones, which do multiple things.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Extract function&nbsp;<em>execute&nbsp;</em>from function&nbsp;<em>run</em></li><li>Extract functions <em>setSize</em>,&nbsp;<em>setOnTurn</em>,&nbsp;<em>createPlayground</em>,&nbsp;<em>fillPlayground&nbsp;</em>and&nbsp;<em>setPiece&nbsp;</em>from function&nbsp;<em>initGame</em></li><li>Extract function&nbsp;<em>endGame</em>,&nbsp;<em>flipPieces</em>,&nbsp;<em>getPiecesToFlip&nbsp;</em>from function&nbsp;<em>move</em></li><li>Extract functions&nbsp;<em>getPossibleMoves</em>,&nbsp;<em>getPiecesToFlip&nbsp;</em>from function&nbsp;<em>areValidMoves</em>.</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('One Level of Abstraction per Function', 2, '2019-03-28 11:08:09.851', 8, 3, 3, '<h2>Objective</h2><blockquote>Mixing levels of abstraction within a function is always confusing. Readers may not be able to tell whether a particular expression is an essential concept or a detail. Worse, like broken windows, once details are mixed with essential concepts, more and more details tend to accrete within the function.&nbsp;<em>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Functions setOnTurn and move do not hold the same abstraction level.</p><p>Make the current code way more readable and maintainable with extracting the functions, which hold lower abstraction levels, should be extracted.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Extract functions&nbsp;<em>isOnTurnInputCorrect</em>, from function&nbsp;<em>setOnTurn</em></li><li>Extract functions&nbsp;<em>isEmpty</em>,&nbsp;<em>isGameOver&nbsp;</em>and&nbsp;<em>swapPlayerOnTurn&nbsp;</em>from function&nbsp;<em>move</em>.</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Small!', 2, '2019-03-28 11:08:09.851', 9, 4, 3, '<h2>Objective</h2><blockquote>The first rule of functions is that they should be small. The second rule of functions is that they should be smaller than that.<br><em>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Most of the large code was refactored in previous steps because of extracting the function from large ones. But there are more ways to reduce function size without lost of readability.</p><p>Make the code functions a way more readable with changing the structure of variable <em>left</em>.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><h3><strong>User stories</strong></h3><ul><li>Use map <em>left </em>to store the values of variables <em>leftB </em>and <em>leftW</em>.</li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Error Handling I', 2, '2019-03-28 11:08:09.851', 10, 5, 3, '<h2>Objective</h2><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">This exercise focuses on handling exceptions. Errors handling not only makes code robust, but also clean.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">In the legacy code, when an error occurs, the message is printed out to console right where it was occurred. Errors should be thrown instead and handled on higher level, with the use of&nbsp;</span><em style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">try/catch/finally</em><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">&nbsp;block.</span></p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><h3><strong>User stories</strong></h3><ul><li>Use custom exception <em>IncorrectGameConfigFileException </em><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">to handle errors when reading game configuration file</span></li></ul>', False);

INSERT INTO exercises (name, type_id, created, id, index, lesson_id, description, solved)
VALUES ('Error Handling II', 2, '2019-03-28 11:08:09.851', 11, 6, 3, '<h2>Objective</h2><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">This exercise focuses on handling exceptions, as well as previous one.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">In the legacy code, when an error occurs, the message is printed out to console right where it was occurred. Errors should be thrown instead and handled on higher level, with the use of&nbsp;</span><em style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">try/catch/finally</em><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">&nbsp;block.</span></p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><h3><strong>User stories</strong></h3><ul><li>Use custom exception <em>IncorrectGameConfigFileException </em><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">&nbsp;to handle errors on user input</span></li></ul>', False);

INSERT INTO bugs_number (exercise_id, number)
VALUES (2, 3);

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_source', 'Reversi.java', 2, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private int[] players = new int[] { 1, 0 };
    int onTurn = -1;
    int winner = -1;
    boolean ended = false;

    private BlackBoxSwitcher switcher = new BlackBoxSwitcher();

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        int configFileLinesNumber = 3;
        if (gameConfig.length != configFileLinesNumber) {
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[0])) {
                onTurn = 1;
            } else if ("W".equals(gameConfig[0])) {
                onTurn = 0;
            }
            playground = new int[8][8];
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c < 8; c++) {
                    playground[r][c] = -1;
                }
            }
            for (int i = 1; i < 3; i++) {
                String[] pieces = gameConfig[i].split(",");
                for (String piece : pieces) {
                    if (!piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    String[] coordinates = piece.trim().split(" ");
                    int r = Integer.parseInt(coordinates[0]);
                    int c = Integer.parseInt(coordinates[1]);
                    if (r >= 8 || c >= 8) {
                        return;
                    }
                    playground[r][c] = players[i - 1];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c <= 7; c++) {
                    if (playground[r][c] == 1) {
                        leftB++;
                    } else if (playground[r][c] == 0) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!line.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                String[] coordinates = line.trim().split(" ");
                int r = Integer.parseInt(coordinates[0]);
                int c = Integer.parseInt(coordinates[1]);
                move(r, c);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        System.out.printf("Number of pieces: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (! switcher.BUGS[0]) {
            if (!(r >= 0 && c >= 0 && r <= 7 && c < 8)) {
                System.out.println("Move out of bounds is not permitted");
                return;
            }
        }
        if (! switcher.BUGS[1]) {
            if (playground[r][c] != -1) {
                System.out.println("Move on not empty piece is not permitted");
                return;
            }
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        int opposite = -1;
        if (onTurn == 0) opposite = 1;
        else if (onTurn == 1) opposite = 0;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (! switcher.BUGS[2]) {
                if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            }
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC < 8)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == -1) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == 0) onTurn = 1;
        else if (onTurn == 1) onTurn = 0;
        if (! areValidMoves()) {
            printPiecesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = 1;
            else if (getLeftW() > getLeftB()) winner = 0;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> pieces = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                ArrayList<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                int opposite  = -1;
                if (onTurn == 0) opposite = 1;
                else if (onTurn == 1) opposite = 0;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC <= 7)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                pieces.add(rString + " " + cString);
            }
        }
        return !pieces.isEmpty();
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_source', 'PlaygroundPrinter.java', 2, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(int[][] playground) {
        printUpperEnumeration(8);
        for (int r = 0; r < 8; r++) {
            printLeftEnumeration(r, 8);
            for (int c = 0; c <= 7; c++) {
                if (playground[r][c] == -1) {
                    printPiece("_", 8);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", 8);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", 8);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_source', 'GameConfig.java', 2, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 2, 'import org.junit.Test;

import static org.junit.Assert.*;

public class ReversiTest {

    private Reversi rev = new Reversi();

    @Test
    public void testSample() {
        Reversi game1 = rev;
        Reversi game2 = new Reversi(GameConfig.game8bInit);

        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);
    }

}
');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', 'W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', 'W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', 'B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', 'B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', 'B
3 4, 4 3
3 3, 4 4
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', 'B
3 4, 4 3
3 3, 4 4
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', 'W
3 4, 4 3
3 3, 4 4
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', 'W
3 4, 4 3
3 3, 4 4
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', 'B
E 4, D 5
D 4, E 5
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', 'B
E 4, D 5
D 4, E 5
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '3 4, 4 3
3 3, 4 4
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '3 4, 4 3
3 3, 4 4
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', 'B
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', 'B
', 2, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 3, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private int[] players = new int[] { 1, 0 };
    int onTurn = -1;
    int winner = -1;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        int configFileLinesNumber = 3;
        if (gameConfig.length != configFileLinesNumber) {
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[0])) {
                onTurn = 1;
            } else if ("W".equals(gameConfig[0])) {
                onTurn = 0;
            }
            playground = new int[8][8];
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c < 8; c++) {
                    playground[r][c] = -1;
                }
            }
            for (int i = 1; i < 3; i++) {
                String[] pieces = gameConfig[i].split(",");
                for (String piece : pieces) {
                    if (!piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    String[] coordinates = piece.trim().split(" ");
                    int r = Integer.parseInt(coordinates[0]);
                    int c = Integer.parseInt(coordinates[1]);
                    if (r >= 8 || c >= 8) {
                        return;
                    }
                    playground[r][c] = players[i - 1];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c <= 7; c++) {
                    if (playground[r][c] == 1) {
                        leftB++;
                    } else if (playground[r][c] == 0) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!line.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                String[] coordinates = line.trim().split(" ");
                int r = Integer.parseInt(coordinates[0]);
                int c = Integer.parseInt(coordinates[1]);
                move(r, c);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        System.out.printf("Number of pieces: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        int opposite = -1;
        if (onTurn == 0) opposite = 1;
        else if (onTurn == 1) opposite = 0;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC < 8)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == -1) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == 0) onTurn = 1;
        else if (onTurn == 1) onTurn = 0;
        if (! areValidMoves()) {
            printPiecesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = 1;
            else if (getLeftW() > getLeftB()) winner = 0;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> pieces = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                ArrayList<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                int opposite  = -1;
                if (onTurn == 0) opposite = 1;
                else if (onTurn == 1) opposite = 0;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC <= 7)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                pieces.add(rString + " " + cString);
            }
        }
        return !pieces.isEmpty();
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 3, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(int[][] playground) {
        printUpperEnumeration(8);
        for (int r = 0; r < 8; r++) {
            printLeftEnumeration(r, 8);
            for (int c = 0; c <= 7; c++) {
                if (playground[r][c] == -1) {
                    printPiece("_", 8);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", 8);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", 8);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 3, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 3, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 3, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "B", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "3 4, 4 3", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 3, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "W", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "3 4, 4 3", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigFourLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFourLines);

        assertEquals("Lines number of gameFourLines config file", 4, gameConfig.length);
        assertEquals("1st line of gameFourLines config file", "B", gameConfig[0]);
        assertEquals("2nd line of gameFourLines config file", "3 4, 4 3", gameConfig[1]);
        assertEquals("3rd line of gameFourLines config file", "3 3, 4 4", gameConfig[2]);
        assertEquals("4th line of gameFourLines config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 3, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "B", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "E 4, D 5", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "D 4, E 5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(2, gameConfig.length);
        assertEquals("3 4, 4 3", gameConfig[0]);
        assertEquals("3 3, 4 4", gameConfig[1]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(1, gameConfig.length);
        assertEquals("B", gameConfig[0]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 3, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 1, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 0, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoPieces() {
        String[] gameConfig = new String[]{"B"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        Assert.assertArrayEquals(null, game.playground);
    }

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", 0, game.onTurn);
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testFourLines() {
        Reversi game = new Reversi(GameConfig.gameFourLines);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 3, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 3, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class MoveTest {


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", 1, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", 1, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", 0, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", 0, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", 0, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
        Assert.assertEquals("winner", 1, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 3, 'import java.util.List;


class TestUtils {

    static int getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static int[][] getEmptyPlayground() {
        int[][] empty = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = -1;
            }
        }
        return empty;
    }

    static int[][] getInitPlayground() {
        int[][] init = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = -1;
            }
        }
        init[3][3] = 0;
        init[4][4] = 0;
        init[3][4] = 1;
        init[4][3] = 1;
        return init;
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 3, 'import org.junit.Test;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();

    @Test
    public void testSample() {
        Reversi game1 = rev;
        Reversi game2 = new Reversi(GameConfig.game8bInit);

        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);
    }

}
');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', 'W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', 'W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', 'B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', 'B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', 'B
3 4, 4 3
3 3, 4 4
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', 'B
3 4, 4 3
3 3, 4 4
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', 'W
3 4, 4 3
3 3, 4 4
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', 'W
3 4, 4 3
3 3, 4 4
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', 'B
E 4, D 5
D 4, E 5
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', 'B
E 4, D 5
D 4, E 5
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '3 4, 4 3
3 3, 4 4
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '3 4, 4 3
3 3, 4 4
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', 'B
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', 'B
', 3, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 4, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private int[] players = new int[] { 1, 0 };
    int onTurn = -1;
    int winner = -1;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        int configFileLinesNumber = 3;
        if (gameConfig.length != configFileLinesNumber) {
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[0])) {
                onTurn = 1;
            } else if ("W".equals(gameConfig[0])) {
                onTurn = 0;
            }
            playground = new int[8][8];
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c < 8; c++) {
                    playground[r][c] = -1;
                }
            }
            for (int i = 1; i < 3; i++) {
                String[] pieces = gameConfig[i].split(",");
                for (String piece : pieces) {
                    if (!piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    String[] coordinates = piece.trim().split(" ");
                    int r = Integer.parseInt(coordinates[0]);
                    int c = Integer.parseInt(coordinates[1]);
                    if (r >= 8 || c >= 8) {
                        return;
                    }
                    playground[r][c] = players[i - 1];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < 8; r++) {
                for (int c = 0; c <= 7; c++) {
                    if (playground[r][c] == 1) {
                        leftB++;
                    } else if (playground[r][c] == 0) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!line.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                String[] coordinates = line.trim().split(" ");
                int r = Integer.parseInt(coordinates[0]);
                int c = Integer.parseInt(coordinates[1]);
                move(r, c);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        System.out.printf("Number of pieces: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!(r >= 0 && c >= 0 && r <= 7 && c < 8)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != -1) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        int opposite = -1;
        if (onTurn == 0) opposite = 1;
        else if (onTurn == 1) opposite = 0;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC < 8)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == -1) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == 0) onTurn = 1;
        else if (onTurn == 1) onTurn = 0;
        if (! areValidMoves()) {
            printPiecesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = 1;
            else if (getLeftW() > getLeftB()) winner = 0;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> pieces = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                ArrayList<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                int opposite  = -1;
                if (onTurn == 0) opposite = 1;
                else if (onTurn == 1) opposite = 0;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8 && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR <= 7 && dirC <= 7)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < 8 && dirC < 8)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                pieces.add(rString + " " + cString);
            }
        }
        return !pieces.isEmpty();
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 4, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(int[][] playground) {
        printUpperEnumeration(8);
        for (int r = 0; r < 8; r++) {
            printLeftEnumeration(r, 8);
            for (int c = 0; c <= 7; c++) {
                if (playground[r][c] == -1) {
                    printPiece("_", 8);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", 8);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", 8);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 4, 'import java.io.File;
import java.nio.file.Path;

final class GameConfig {

    private static final GameConfig INSTANCE = new GameConfig();

    GameConfig() {}

    public static GameConfig getInstance() {
        return INSTANCE;
    }

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 4, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }


    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 4, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", 1, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", 0, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", 1, game.onTurn);
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", 1, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", 0, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFiveLines() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoSize() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoPieces() {
        String[] gameConfig = new String[]{"8", "B"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        Assert.assertArrayEquals(null, game.playground);
    }

    
    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", 0, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", 1, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", 0, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 4, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 4, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class MoveTest {


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", 1, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", 1, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", 0, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", 0, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", 1, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", 0, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", 0, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", 0, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
        Assert.assertEquals("winner", 1, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 4, 'import java.util.List;


class TestUtils {

    static int getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static int[][] getEmptyPlayground() {
        int[][] empty = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = -1;
            }
        }
        return empty;
    }

    static int[][] getInitPlayground() {
        int[][] init = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                init[r][c] = -1;
            }
        }
        init[3][3] = 0;
        init[4][4] = 0;
        init[3][4] = 1;
        init[4][3] = 1;
        return init;
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 4, 'import org.junit.Test;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();

    @Test
    public void testSample() {
        Reversi game1 = rev;
        Reversi game2 = new Reversi(GameConfig.game8bInit);

        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 4, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 5, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    int[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private int[] players = new int[] { 1, 0 };
    int onTurn = -1;
    int winner = -1;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines");
            return;
        }
        try {
            if (!gameConfig[0].matches("[0-9]+")) {
                System.out.println("Incorrect size input");
                return;
            }
            size = Integer.parseInt(gameConfig[0]);
            if (gameConfig[1] == null || !gameConfig[1].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[1])) {
                onTurn = 1;
            } else if ("W".equals(gameConfig[1])) {
                onTurn = 0;
            }
            playground = new int[size][size];
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    playground[r][c] = -1;
                }
            }
            for (int i = 2; i < 4; i++) {
                String[] pieces = gameConfig[i].split(",");
                for (String piece : pieces) {
                    if (!piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    String[] coordinates = piece.trim().split(" ");
                    int r = Integer.parseInt(coordinates[0]);
                    int c = Integer.parseInt(coordinates[1]);
                    if (r >= size || c >= size) {
                        return;
                    }
                    playground[r][c] = players[i - 2];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == 1) {
                        leftB++;
                    } else if (playground[r][c] == 0) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!line.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                String[] coordinates = line.trim().split(" ");
                int r = Integer.parseInt(coordinates[0]);
                int c = Integer.parseInt(coordinates[1]);
                move(r, c);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        System.out.printf("Number of pieces: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!(r >= 0 && c >= 0 && r < size && c < size)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != -1) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        int opposite = -1;
        if (onTurn == 0) opposite = 1;
        else if (onTurn == 1) opposite = 0;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == -1) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == 1) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == 0) onTurn = 1;
        else if (onTurn == 1) onTurn = 0;
        if (! areValidMoves()) {
            printPiecesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = 1;
            else if (getLeftW() > getLeftB()) winner = 0;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != -1) continue;
                ArrayList<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                int opposite  = -1;
                if (onTurn == 0) opposite = 1;
                else if (onTurn == 1) opposite = 0;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                pieces.add(rString + " " + cString);
            }
        }
        return !pieces.isEmpty();
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 5, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(int[][] playground) {
        printUpperEnumeration(8);
        for (int r = 0; r < 8; r++) {
            printLeftEnumeration(r, 8);
            for (int c = 0; c <= 7; c++) {
                if (playground[r][c] == -1) {
                    printPiece("_", 8);
                }
                else if (playground[r][c] == 1) {
                    printPiece("B", 8);
                }
                else if (playground[r][c] == 0) {
                    printPiece("W", 8);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 5, 'public enum Player {
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 5, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 5, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 5, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }


    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 5, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFiveLines() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoSize() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoPieces() {
        String[] gameConfig = new String[]{"8", "B"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        Assert.assertArrayEquals(null, game.playground);
    }

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 5, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                        " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                        "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 5, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class MoveTest {


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
        Assert.assertEquals("winner", Player.B, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 5, 'import java.util.List;


class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 5, 'import org.junit.Test;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();

    @Test
    public void testSample() {
        Reversi game1 = rev;
        Reversi game2 = new Reversi(GameConfig.game8bInit);

        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 5, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 6, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines");
            return;
        }
        try {
            if (!gameConfig[0].matches("[0-9]+")) {
                System.out.println("Incorrect size input");
                return;
            }
            size = Integer.parseInt(gameConfig[0]);
            if (gameConfig[1] == null || !gameConfig[1].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[1])) {
                onTurn = Player.B;
            } else if ("W".equals(gameConfig[1])) {
                onTurn = Player.W;
            }
            playground = new Player[size][size];
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    playground[r][c] = Player.NONE;
                }
            }
            for (int i = 2; i < 4; i++) {
                String[] pieces = gameConfig[i].split(",");
                for (String piece : pieces) {
                    if (!piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    String[] coordinates = piece.trim().split(" ");
                    int r = Integer.parseInt(coordinates[0]);
                    int c = Integer.parseInt(coordinates[1]);
                    if (r >= size || c >= size) {
                        return;
                    }
                    playground[r][c] = players[i - 2];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        leftB++;
                    } else if (playground[r][c] == Player.W) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground, size);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                if (!line.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*")) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                String[] coordinates = line.trim().split(" ");
                int r = Integer.parseInt(coordinates[0]);
                int c = Integer.parseInt(coordinates[1]);
                move(r, c);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        System.out.printf("Number of pieces: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!(r >= 0 && c >= 0 && r < size && c < size)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != Player.NONE) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (winner != Player.NONE) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        Player opposite = Player.NONE;
        if (onTurn == Player.W) opposite = Player.B;
        else if (onTurn == Player.B) opposite = Player.W;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = Player.NONE;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == Player.NONE) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == Player.B) leftB++;
                else if (onTurn == Player.W) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == Player.B) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
        if (! areValidMoves()) {
            printPiecesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = Player.B;
            else if (getLeftW() > getLeftB()) winner = Player.W;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                ArrayList<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                Player opposite  = Player.NONE;
                if (onTurn == Player.W) opposite = Player.B;
                else if (onTurn == Player.B) opposite = Player.W;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (dirR >= 0 && dirC >= 0 && dirR < size && dirC < size && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < size && dirC < size)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = Player.NONE;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                pieces.add(rString + " " + cString);
            }
        }
        return !pieces.isEmpty();
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 6, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 6, 'public enum Player {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 6, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 6, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 6, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }


    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 6, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertArrayEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();

    
    //setSize

    @Test
    public void testSetSize8() {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() {
        Reversi game = rev;
        game.setSize("-8");

        assertEquals("set size -8", 0, game.size);
    }

    @Test
    public void testSetSizeA() {
        Reversi game = rev;
        game.setSize("A");

        assertEquals("set size A", 0, game.size);
    }


    // setOnTurn

    @Test
    public void testSetOnTurnB() {
        Reversi game = rev;
        game.setOnTurn("B");

        assertEquals("set player on turn: B", Player.B, game.onTurn);
    }

    @Test
    public void testSetOnTurnW() {
        Reversi game = rev;
        game.setOnTurn("W");

        assertEquals("set player on turn: W", Player.W, game.onTurn);
    }

    @Test
    public void testSetOnTurnA() {
        Reversi game = rev;
        game.setOnTurn("A");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnNone() {
        Reversi game = rev;
        game.setOnTurn("NONE");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnnull() {
        Reversi game = rev;
        game.setOnTurn(null);

        assertEquals(Player.NONE, game.onTurn);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D 3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, TestUtils.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 0}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece08() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 8}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece88() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 8}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[]{"one"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFiveLines() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoSize() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoPieces() {
        String[] gameConfig = new String[]{"8", "B"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        Assert.assertArrayEquals(null, game.playground);
    }

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 6, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 6, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;

public class MoveTest {


    // getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(3, 2);
        List<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("pieces to flip on onit - (3, 2)", 2, pieces.size());
        assertEquals(expected.get(0).get(0), pieces.get(0).get(0));
        assertEquals(expected.get(0).get(1), pieces.get(0).get(1));
        assertEquals(expected.get(1).get(0), pieces.get(1).get(0));
        assertEquals(expected.get(1).get(1), pieces.get(1).get(1));
    }

    @Test
    public void testGetPiecesToFlipInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        ArrayList<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals("...", Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals("...", Player.B, TestUtils.getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        ArrayList<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        ArrayList<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }

    // endGame

    @Test
    public void testEndGame() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        assertTrue(game.ended);
        assertEquals(Player.B, game.winner);
    }
    
    
    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
        Assert.assertEquals("winner", Player.B, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ExecuteTest.java', 6, 'import org.junit.Assert;
import org.junit.Test;

public class ExecuteTest {

    @Test
    public void testExecute() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 6, 'import java.util.List;


class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 6, 'import org.junit.Test;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();

    @Test
    public void testSample() {
        Reversi game1 = rev;
        Reversi game2 = new Reversi(GameConfig.game8bInit);

        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 6, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 7, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines");
            return;
        }
        setSize(gameConfig[0]);
        setOnTurn(gameConfig[1]);
        createPlayground();
        fillPlayground(gameConfig);
    }

    void setSize(String size) {
        if (!size.matches("[0-9]+")) {
            System.out.println("Incorrect size input");
            return;
        }
        this.size = Integer.parseInt(size);
    }

    void setOnTurn(String onTurn) {
        if (onTurn == null || !onTurn.matches("[B|W]")) {
            System.out.println("Incorrect player on turn input");
            return;
        }
        if ("B".equals(onTurn)) {
            this.onTurn = Player.B;
        } else if ("W".equals(onTurn)) {
            this.onTurn = Player.W;
        }
    }

    private void createPlayground() {
        playground = new Player[size][size];
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) {
        try {
            for (int i = 2; i < 4; i++) {
                String[] pieces = gameConfig[i].split(",");
                for (String piece : pieces) {
                    if (!isPieceInputCorrect(piece)) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    int[] coordinates = getCoordinates(piece);
                    setPiece(coordinates, players[i - 2]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect");
        }
    }

    boolean isPieceInputCorrect(String piece) {
        return piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String piece) {
        String[] coordinates = piece.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void setPiece(int[] coordinates, Player player) {
        int r = coordinates[0];
        int c = coordinates[1];
        if (r >= size || c >= size) {
            return;
        }
        playground[r][c] = player;
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        leftB++;
                    } else if (playground[r][c] == Player.W) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground, size);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    void execute(String line) {
        if (!isPieceInputCorrect(line)) {
            System.out.println("Incorrect piece input");
            return;
        }
        int[] coordinates = getCoordinates(line);
        move(coordinates[0], coordinates[1]);
    }

    private void printPiecesLeftCount() {
        System.out.printf("Number of pieces: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != Player.NONE) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (winner != Player.NONE) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> piecesToFlip = getPiecesToFlip(r, c);
        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        flipPieces(piecesToFlip);

        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
        if (! areValidMoves()) {
            endGame();
        }
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    ArrayList<List<Integer>> getPiecesToFlip(int r0, int c0) {
        ArrayList<List<Integer>> toFlip = new ArrayList<>();
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
                toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (!toFlip.isEmpty()) {
            toFlip.add(new ArrayList<>(Arrays.asList(r0, c0)));
        }
        return toFlip;
    }

    void flipPieces(List<List<Integer>> pieces) {
        for (List<Integer> piece : pieces) {
            int r = piece.get(0);
            int c = piece.get(1);
            if (playground[r][c] == onTurn) break;
            if (playground[r][c] == Player.NONE) {
                playground[r][c] = onTurn;
                if (onTurn == Player.B) leftB++;
                else if (onTurn == Player.W) leftW++;
            } else {
                playground[r][c] = onTurn;
                if (onTurn == Player.B) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }
    }

    boolean areValidMoves() {
        int movesNum = getPossibleMoves().size();
        return movesNum != 0;
    }

    ArrayList<String> getPossibleMoves() {
        ArrayList<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getPiecesToFlip(r, c).isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                pieces.add(rString + " " + cString);
            }
        }
        return pieces;
    }

    void endGame() {
        printPiecesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 7, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 7, 'public enum Player {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 7, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 7, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 7, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }


    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 7, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertFalse;

public class InitGameTest {

    private Reversi rev = new Reversi();


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }
    

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }

    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFiveLines() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoSize() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoPieces() {
        String[] gameConfig = new String[]{"8", "B"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        Assert.assertArrayEquals(null, game.playground);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 7, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 7, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class MoveTest {


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
        Assert.assertEquals("winner", Player.B, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 7, 'import java.util.List;


class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 7, 'import org.junit.Test;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();

    @Test
    public void testSample() {
        Reversi game1 = rev;
        Reversi game2 = new Reversi(GameConfig.game8bInit);

        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 7, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 8, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines");
            return;
        }
        try {
            if (!gameConfig[0].matches("[0-9]+")) {
                System.out.println("Incorrect size input");
                return;
            }
            size = Integer.parseInt(gameConfig[0]);
            if (gameConfig[1] == null || !gameConfig[1].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input");
                return;
            }
            if ("B".equals(gameConfig[1])) {
                onTurn = Player.B;
            } else if ("W".equals(gameConfig[1])) {
                onTurn = Player.W;
            }
            playground = new Player[size][size];
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    playground[r][c] = Player.NONE;
                }
            }
            for (int i = 2; i < 4; i++) {
                String[] pieces = gameConfig[i].split(",");
                for (String piece : pieces) {
                    if (!isPieceInputCorrect(piece)) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    int[] coordinates = getCoordinates(piece);
                    int r = coordinates[0];
                    int c = coordinates[1];
                    if (r >= size || c >= size) {
                        return;
                    }
                    playground[r][c] = players[i - 2];
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect");
        }
    }

    boolean isPieceInputCorrect(String piece) {
        return piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String piece) {
        String[] coordinates = piece.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        leftB++;
                    } else if (playground[r][c] == Player.W) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground, size);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                if (!isPieceInputCorrect(line)) {
                    System.out.println("Incorrect piece input");
                    return;
                }
                int[] coordinates = getCoordinates(line);
                move(coordinates[0], coordinates[1]);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    private void printPiecesLeftCount() {
        System.out.printf("Number of pieces: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != Player.NONE) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (winner != Player.NONE) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> piecesToFlip = new ArrayList<>();
        playground[r][c] = onTurn;
        Player opposite = Player.NONE;
        if (onTurn == Player.W) opposite = Player.B;
        else if (onTurn == Player.B) opposite = Player.W;

        int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
        for (int[] direction : directions) {
            int dirR = r;
            int dirC = c;
            dirR += direction[0];
            dirC += direction[1];
            if (isWithinPlayground(dirR, dirC) && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!isWithinPlayground(dirR, dirC)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!isWithinPlayground(dirR, dirC)) break;
            }
            if (!isWithinPlayground(dirR, dirC)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                piecesToFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
            }
        }

        playground[r][c] = Player.NONE;
        if (!piecesToFlip.isEmpty()) {
            piecesToFlip.add(new ArrayList<>(Arrays.asList(r, c)));
        }

        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> piece : piecesToFlip) {
            int pieceR = piece.get(0);
            int pieceC = piece.get(1);
            if (playground[pieceR][pieceC] == onTurn) break;
            if (playground[pieceR][pieceC] == Player.NONE) {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == Player.B) leftB++;
                else if (onTurn == Player.W) leftW++;
            } else {
                playground[pieceR][pieceC] = onTurn;
                if (onTurn == Player.B) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }

        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
        if (! areValidMoves()) {
            printPiecesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = Player.B;
            else if (getLeftW() > getLeftB()) winner = Player.W;
        }
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    boolean areValidMoves() {
        ArrayList<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                ArrayList<List<Integer>> toFlip = new ArrayList<>();
                playground[r][c] = onTurn;
                Player opposite  = Player.NONE;
                if (onTurn == Player.W) opposite = Player.B;
                else if (onTurn == Player.B) opposite = Player.W;

                int[][] directions = {{0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}};
                for (int[] direction : directions) {
                    int dirR = r;
                    int dirC = c;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (isWithinPlayground(dirR, dirC) && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!isWithinPlayground(dirR, dirC)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!isWithinPlayground(dirR, dirC)) break;
                    }
                    if (!isWithinPlayground(dirR, dirC)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFlip.add(new ArrayList<>(Arrays.asList(dirR, dirC)));
                    }
                }

                playground[r][c] = Player.NONE;
                if (!toFlip.isEmpty()) {
                    toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
                }
                if (toFlip.isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                pieces.add(rString + " " + cString);
            }
        }
        return !pieces.isEmpty();
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 8, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 8, 'public enum Player {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 8, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 8, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 8, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 8, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();

    //setSize

    @Test
    public void testSetSize8() {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() {
        Reversi game = rev;
        game.setSize("-8");

        assertEquals("set size -8", 0, game.size);
    }

    @Test
    public void testSetSizeA() {
        Reversi game = rev;
        game.setSize("A");

        assertEquals("set size A", 0, game.size);
    }

    // setOnTurnInputCorrect

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
    public void testSetOnTurnB() {
        Reversi game = rev;
        game.setOnTurn("B");

        assertEquals("set player on turn: B", Player.B, game.onTurn);
    }

    @Test
    public void testSetOnTurnW() {
        Reversi game = rev;
        game.setOnTurn("W");

        assertEquals("set player on turn: W", Player.W, game.onTurn);
    }

    @Test
    public void testSetOnTurnA() {
        Reversi game = rev;
        game.setOnTurn("A");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnNone() {
        Reversi game = rev;
        game.setOnTurn("NONE");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnnull() {
        Reversi game = rev;
        game.setOnTurn(null);

        assertEquals(Player.NONE, game.onTurn);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D 3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[] {0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, TestUtils.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[] {8, 0}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece08() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[] {0, 8}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece88() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[] {8, 8}, Player.B);

        Player[][] expectedPlayground = TestUtils.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[]{"one"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGame

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 8, game.size);
        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 8, game.size);
        assertEquals("init playground on initial game config", Player.W, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 10, game.size);
        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFiveLines() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoSize() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoPieces() {
        String[] gameConfig = new String[]{"8", "B"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        Assert.assertArrayEquals(null, game.playground);
    }


    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 8, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 8, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // TestUtils.getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(3, 2);
        List<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("pieces to flip on onit - (3, 2)", 2, pieces.size());
        assertEquals(expected.get(0).get(0), pieces.get(0).get(0));
        assertEquals(expected.get(0).get(1), pieces.get(0).get(1));
        assertEquals(expected.get(1).get(0), pieces.get(1).get(0));
        assertEquals(expected.get(1).get(1), pieces.get(1).get(1));
    }

    @Test
    public void testGetPiecesToFlipInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals(Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals(Player.B, TestUtils.getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.B, game.onTurn);
    }


    // endGame

    @Test
    public void testEndGame() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        assertTrue(game.ended);
        assertEquals(Player.B, game.winner);
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
        Assert.assertEquals("winner", Player.B, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ExecuteTest.java', 8, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

public class ExecuteTest {

    @Test
    public void testExecute32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testExecuteFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 39, game.getLeftW());
        assertEquals("B left", 25, game.getLeftB());
        assertEquals("winner", Player.W, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 8, 'import java.util.List;

class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 8, 'import org.junit.Test;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();

    @Test
    public void testSample() {
        Reversi game1 = rev;
        Reversi game2 = new Reversi(GameConfig.game8bInit);

        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 8, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 9, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private int leftB = 0;
    private int leftW = 0;
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines");
            return;
        }
        setSize(gameConfig[0]);
        setOnTurn(gameConfig[1]);
        createPlayground();
        fillPlayground(gameConfig);
    }

    void setSize(String size) {
        if (!size.matches("[0-9]+")) {
            System.out.println("Incorrect size input");
            return;
        }
        this.size = Integer.parseInt(size);
    }

    void setOnTurn(String onTurn) {
        if (!isOnTurnInputCorrect(onTurn)) {
            System.out.println("Incorrect player on turn input");
            return;
        }
        if ("B".equals(onTurn)) {
            this.onTurn = Player.B;
        } else if ("W".equals(onTurn)) {
            this.onTurn = Player.W;
        }
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    private void createPlayground() {
        playground = new Player[size][size];
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) {
        try {
            for (int i = 2; i < 4; i++) {
                String[] pieces = gameConfig[i].split(",");
                for (String piece : pieces) {
                    if (!isPieceInputCorrect(piece)) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    int[] coordinates = getCoordinates(piece);
                    setPiece(coordinates, players[i - 2]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect");
        }
    }

    boolean isPieceInputCorrect(String piece) {
        return piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String piece) {
        String[] coordinates = piece.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void setPiece(int[] coordinates, Player player) {
        int r = coordinates[0];
        int c = coordinates[1];
        if (r >= size || c >= size) {
            return;
        }
        playground[r][c] = player;
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        leftB++;
                    } else if (playground[r][c] == Player.W) {
                        leftW++;
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground, size);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    void execute(String line) {
        if (!isPieceInputCorrect(line)) {
            System.out.println("Incorrect piece input");
            return;
        }
        int[] coordinates = getCoordinates(line);
        move(coordinates[0], coordinates[1]);
    }

    private void printPiecesLeftCount() {
        System.out.printf("Number of pieces: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> piecesToFlip = getPiecesToFlip(r, c);
        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        flipPieces(piecesToFlip);

        swapPlayerOnTurn();
        if (! areValidMoves()) {
            endGame();
        }
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    ArrayList<List<Integer>> getPiecesToFlip(int r0, int c0) {
        ArrayList<List<Integer>> toFlip = new ArrayList<>();
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
                toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (!toFlip.isEmpty()) {
            toFlip.add(new ArrayList<>(Arrays.asList(r0, c0)));
        }
        return toFlip;
    }

    void flipPieces(List<List<Integer>> pieces) {
        for (List<Integer> piece : pieces) {
            int r = piece.get(0);
            int c = piece.get(1);
            if (playground[r][c] == onTurn) break;
            if (playground[r][c] == Player.NONE) {
                playground[r][c] = onTurn;
                if (onTurn == Player.B) leftB++;
                else if (onTurn == Player.W) leftW++;
            } else {
                playground[r][c] = onTurn;
                if (onTurn == Player.B) {
                    leftB++;
                    leftW--;
                } else {
                    leftW++;
                    leftB--;
                }
            }
        }
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    boolean areValidMoves() {
        int movesNum = getPossibleMoves().size();
        return movesNum != 0;
    }

    ArrayList<String> getPossibleMoves() {
        ArrayList<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getPiecesToFlip(r, c).isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                pieces.add(rString + " " + cString);
            }
        }
        return pieces;
    }

    void endGame() {
        printPiecesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 9, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 9, 'public enum Player {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 9, '
import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 9, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 9, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Test
    public void testReadGameConfig8bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNotExisting);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }


    @Test
    public void testReadGameConfigFiveLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 9, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.*;
import static org.junit.Assert.assertArrayEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();

    //setSize

    @Test
    public void testSetSize8() {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() {
        Reversi game = rev;
        game.setSize("-8");

        assertEquals("set size -8", 0, game.size);
    }

    @Test
    public void testSetSizeA() {
        Reversi game = rev;
        game.setSize("A");

        assertEquals("set size A", 0, game.size);
    }

    // setOnTurnInputCorrect

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
    public void testSetOnTurnB() {
        Reversi game = rev;
        game.setOnTurn("B");

        assertEquals("set player on turn: B", Player.B, game.onTurn);
    }

    @Test
    public void testSetOnTurnW() {
        Reversi game = rev;
        game.setOnTurn("W");

        assertEquals("set player on turn: W", Player.W, game.onTurn);
    }

    @Test
    public void testSetOnTurnA() {
        Reversi game = rev;
        game.setOnTurn("A");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnNone() {
        Reversi game = rev;
        game.setOnTurn("NONE");

        assertEquals(Player.NONE, game.onTurn);
    }

    @Test
    public void testSetOnTurnnull() {
        Reversi game = rev;
        game.setOnTurn(null);

        assertEquals(Player.NONE, game.onTurn);
    }



    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, TestUtils.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 0}, Player.B);

        Player[][] expectedPlayground = InitGameTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece08() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 8}, Player.B);

        Player[][] expectedPlayground = InitGameTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetPiece88() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{8, 8}, Player.B);

        Player[][] expectedPlayground = InitGameTest.getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[] {"one"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() {
        String[] gameConfig = new String[] {"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = TestUtils.getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGamer

    @Test
    public void testInitGame8bInit() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() {
        String[] gameConfig = new String[]{};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFiveLines() {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameAlpha() {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
    }

    @Test
    public void testInitGameNoSize() {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoOnTurn() {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNoPieces() {
        String[] gameConfig = new String[]{"8", "B"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        Assert.assertArrayEquals(null, game.playground);
    }

    static Player[][] getInitPlayground() {
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

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(GameConfig.gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNotExisting() {
        Reversi game = new Reversi(GameConfig.gameNotExisting);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFiveLines() {
        Reversi game = new Reversi(GameConfig.gameFiveLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAlpha() {
        Reversi game = new Reversi(GameConfig.gameAlpha);

        assertArrayEquals(TestUtils.getEmptyPlayground(), game.playground);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoSize() {
        Reversi game = new Reversi(GameConfig.gameNoSize);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(GameConfig.gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoPieces() {
        Reversi game = new Reversi(GameConfig.gameNoPieces);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 9, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 9, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // TestUtils.getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(3, 2);
        List<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("pieces to flip on onit - (3, 2)", 2, pieces.size());
        assertEquals(expected.get(0).get(0), pieces.get(0).get(0));
        assertEquals(expected.get(0).get(1), pieces.get(0).get(1));
        assertEquals(expected.get(1).get(0), pieces.get(1).get(0));
        assertEquals(expected.get(1).get(1), pieces.get(1).get(1));
    }

    @Test
    public void testGetPiecesToFlipInit00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        ArrayList<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals(Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals(Player.B, TestUtils.getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        ArrayList<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        ArrayList<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() {
        Reversi game = new Reversi(GameConfig.game8wInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.B, game.onTurn);
    }


    // endGame

    @Test
    public void testEndGame() {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        assertTrue(game.ended);
        assertEquals(Player.B, game.winner);
    }
    
    
    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
        Assert.assertEquals("winner", Player.B, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ExecuteTest.java', 9, 'import org.junit.Assert;
import org.junit.Test;

public class ExecuteTest {

    @Test
    public void testExecute32() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn''t change", InitGameTest.getInitPlayground(), game.playground);
    }

    @Test
    public void testFinishGame() {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 9, 'import java.util.List;


class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 9, 'import org.junit.Test;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();

    @Test
    public void testSample() {
        Reversi game1 = rev;
        Reversi game2 = new Reversi(GameConfig.game8bInit);

        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 9, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 10, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private HashMap<Player, Integer> left = new HashMap<Player, Integer>() {{ put(Player.B, 0); put(Player.W, 0); }};
    private Player[] players = new Player[] { Player.B, Player.W };
    Player onTurn = Player.NONE;
    Player winner = Player.NONE;
    boolean ended = false;

    Reversi() {
    }

    Reversi(Path gameFilePath) {
        try {
            String[] gameConfig = readGameConfig(gameFilePath);
            initGame(gameConfig);
            initPiecesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Game configuration file does not exist");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            System.out.println("Game configuration must contain " + configFileLinesNumber + " lines");
            return;
        }
        setSize(gameConfig[0]);
        setOnTurn(gameConfig[1]);
        createPlayground();
        fillPlayground(gameConfig);
    }

    void setSize(String size) {
        if (!size.matches("[0-9]+")) {
            System.out.println("Incorrect size input");
            return;
        }
        this.size = Integer.parseInt(size);
    }

    void setOnTurn(String onTurn) {
        if (!isOnTurnInputCorrect(onTurn)) {
            System.out.println("Incorrect player on turn input");
            return;
        }
        if ("B".equals(onTurn)) {
            this.onTurn = Player.B;
        } else if ("W".equals(onTurn)) {
            this.onTurn = Player.W;
        }
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    private void createPlayground() {
        playground = new Player[size][size];
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) {
        try {
            for (int i = 2; i < 4; i++) {
                String[] pieces = gameConfig[i].split(",");
                for (String piece : pieces) {
                    if (!isPieceInputCorrect(piece)) {
                        System.out.println("Incorrect piece input");
                        return;
                    }
                    int[] coordinates = getCoordinates(piece);
                    setPiece(coordinates, players[i - 2]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect");
        }
    }

    boolean isPieceInputCorrect(String piece) {
        return piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String piece) {
        String[] coordinates = piece.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void setPiece(int[] coordinates, Player player) {
        int r = coordinates[0];
        int c = coordinates[1];
        if (r >= size || c >= size) {
            return;
        }
        playground[r][c] = player;
    }

    void initPiecesCount() {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        left.put(Player.B, left.get(Player.B) + 1);
                    } else if (playground[r][c] == Player.W) {
                        left.put(Player.W, left.get(Player.W) + 1);
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground, size);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            System.out.println("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    void execute(String line) {
        if (!isPieceInputCorrect(line)) {
            System.out.println("Incorrect piece input");
            return;
        }
        int[] coordinates = getCoordinates(line);
        move(coordinates[0], coordinates[1]);
    }

    private void printPiecesLeftCount() {
        System.out.printf("Number of pieces: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return left.get(Player.B);
    }

    int getLeftW() {
        return left.get(Player.W);
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> piecesToFlip = getPiecesToFlip(r, c);
        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        flipPieces(piecesToFlip);

        swapPlayerOnTurn();
        if (! areValidMoves()) {
            endGame();
        }
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    ArrayList<List<Integer>> getPiecesToFlip(int r0, int c0) {
        ArrayList<List<Integer>> toFlip = new ArrayList<>();
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
                toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (!toFlip.isEmpty()) {
            toFlip.add(new ArrayList<>(Arrays.asList(r0, c0)));
        }
        return toFlip;
    }

    void flipPieces(List<List<Integer>> pieces) {
        pieces.forEach(piece -> {
            Player previous = playground[piece.get(0)][piece.get(1)];
            playground[piece.get(0)][piece.get(1)] = onTurn;
            if (previous == Player.NONE) {
                left.put(onTurn, left.get(onTurn) + 1);
            } else if (previous != onTurn) {
                left.put(previous, left.get(previous) - 1);
                left.put(onTurn, left.get(onTurn) + 1);
            }
        });
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    boolean areValidMoves() {
        int movesNum = getPossibleMoves().size();
        return movesNum != 0;
    }

    ArrayList<String> getPossibleMoves() {
        ArrayList<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getPiecesToFlip(r, c).isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                pieces.add(rString + " " + cString);
            }
        }
        return pieces;
    }

    void endGame() {
        printPiecesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 10, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 10, 'public enum Player {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'IncorrectGameConfigFileException.java', 10, 'public class IncorrectGameConfigFileException extends Exception {

    public IncorrectGameConfigFileException(String message) {
        super(message);
    }

    public IncorrectGameConfigFileException(String message, Throwable cause) {
        super(message, cause);
    }


}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 10, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 10, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 10, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    @Test
    public void testReadGameConfig8bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file does not exist");
        game.readGameConfig(GameConfig.gameNotExisting);
    }


    @Test
    public void testReadGameConfigFiveLines() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals(5, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
        assertEquals("3 4, 4 3", gameConfig[2]);
        assertEquals("3 3, 4 4", gameConfig[3]);
        assertEquals("3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals(4, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
        assertEquals("E 4, D 5", gameConfig[2]);
        assertEquals("D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 10, 'import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();


    //setSize

    @Test
    public void testSetSize8() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect size input");
        game.setSize("-8");
    }

    @Test
    public void testSetSizeA() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect size input");
        game.setSize("A");
    }

    // setOnTurnInputCorrect

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

    @Test
    public void testSetOnTurnA() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn("A");
    }

    @Test
    public void testSetOnTurnNone() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn("NONE");
    }

    @Test
    public void testSetOnTurnnull() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn(null);
    }



    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[]{0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, TestUtils.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[]{8, 0}, Player.B);
    }

    @Test
    public void testSetPiece08() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[]{0, 8}, Player.B);
    }

    @Test
    public void testSetPiece88() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[]{8, 8}, Player.B);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"one"};
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(gameConfig);
    }

    @Test
    public void testFillPlaygroundNull() throws IncorrectGameConfigFileException {
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(null);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.fillPlayground(gameConfig);
    }


    // initGame

    @Rule
    public ExpectedException expectedException = ExpectedException.none();

    @Test
    public void testInitGame8bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameFiveLines() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameAlpha() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNoSize() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNoOnTurn() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNoPieces() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNull() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration is null");
        game.initGame(null);
    }

    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameEmpty);
    }

    @Test
    public void testNotExisting() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file does not exist");
        new Reversi(GameConfig.gameNotExisting);
    }

    @Test
    public void testFiveLines() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameFiveLines);
    }

    @Test
    public void testAlpha() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        new Reversi(GameConfig.gameAlpha);
    }

    @Test
    public void testNoSize() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoSize);
    }

    @Test
    public void testNoOnTurn() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoOnTurn);
    }

    @Test
    public void testNoPieces() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoPieces);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 10, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 10, 'import org.junit.Assert;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {
    

    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(3, 2);
        List<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("pieces to flip on onit - (3, 2)", 2, pieces.size());
        assertEquals(expected.get(0).get(0), pieces.get(0).get(0));
        assertEquals(expected.get(0).get(1), pieces.get(0).get(1));
        assertEquals(expected.get(1).get(0), pieces.get(1).get(0));
        assertEquals(expected.get(1).get(1), pieces.get(1).get(1));
    }

    @Test
    public void testGetPiecesToFlipInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        ArrayList<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals(Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals(Player.B, TestUtils.getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        ArrayList<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        ArrayList<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.B, game.onTurn);
    }


    // endGame

    @Test
    public void testEndGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        Assert.assertTrue(game.ended);
        Assert.assertEquals(Player.B, game.winner);
    }

    
    // move

    @Test
    public void testMoveOnNotEmpty() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 4);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(8, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(-1, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(0, 0);

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }

    @Test
    public void testMovesCompleteGame() throws IncorrectGameConfigFileException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
        Assert.assertEquals("winner", Player.B, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ExecuteTest.java', 10, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

public class ExecuteTest {



    @Test
    public void testExecute32() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testExecuteFinishGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 39, game.getLeftW());
        assertEquals("B left", 25, game.getLeftB());
        assertEquals("winner", Player.W, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 10, 'import java.util.List;

class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move  : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) throws IncorrectGameConfigFileException {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 10, 'import org.junit.Test;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();

    @Test
    public void testSample() {
        Reversi game1 = rev;
        Reversi game2 = new Reversi(GameConfig.game8bInit);

        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 10, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 11, 'import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class Reversi {

    int size;
    Player[][] playground;
    private HashMap<Player, Integer> left = new HashMap<Player, Integer>() {{ put(Player.B, 0); put(Player.W, 0); }};
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
            initPiecesCount();
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
            throw new IncorrectGameConfigFileException("Game configuration file does not exist");
        } catch (IOException e) {
            throw new IncorrectGameConfigFileException("Could not read game configuration file");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) throws IncorrectGameConfigFileException {
        if (gameConfig == null) {
            throw new IncorrectGameConfigFileException("Game configuration is null");
        }
        int configFileLinesNumber = 4;
        if (gameConfig.length != configFileLinesNumber) {
            throw new IncorrectGameConfigFileException("Game configuration must contain " + configFileLinesNumber + " lines");
        }
        setSize(gameConfig[0]);
        setOnTurn(gameConfig[1]);
        createPlayground();
        fillPlayground(gameConfig);
    }

    void setSize(String size) throws IncorrectGameConfigFileException {
        if (!size.matches("[0-9]+")) {
            throw new IncorrectGameConfigFileException("Incorrect size input");
        }
        this.size = Integer.parseInt(size);
    }

    void setOnTurn(String onTurn) throws IncorrectGameConfigFileException {
        if (!isOnTurnInputCorrect(onTurn)) {
            throw new IncorrectGameConfigFileException("Incorrect player on turn input");
        }
        if ("B".equals(onTurn)) {
            this.onTurn = Player.B;
        } else if ("W".equals(onTurn)) {
            this.onTurn = Player.W;
        }
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    private void createPlayground() {
        playground = new Player[size][size];
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) throws IncorrectGameConfigFileException {
        try {
            for (int i = 2; i < 4; i++) {
                String[] pieces = gameConfig[i].split(",");
                for (String piece : pieces) {
                    if (!isPieceInputCorrect(piece)) {
                        throw new IncorrectGameConfigFileException("Incorrect piece input");
                    }
                    int[] coordinates = getCoordinates(piece);
                    setPiece(coordinates, players[i - 2]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            throw new IncorrectGameConfigFileException("Game configuration file is incorrect");
        }
    }

    boolean isPieceInputCorrect(String piece) {
        return piece.matches("[ ]*[0-9]+[ ]+[0-9]+[ ]*");
    }

    int[] getCoordinates(String piece) {
        String[] coordinates = piece.trim().split(" ");
        int r = Integer.parseInt(coordinates[0]);
        int c = Integer.parseInt(coordinates[1]);
        return new int[] {r, c};
    }

    void setPiece(int[] coordinates, Player player) throws IncorrectGameConfigFileException {
        int r = coordinates[0];
        int c = coordinates[1];
        if (r >= size || c >= size) {
            throw new IncorrectGameConfigFileException("Incorrect piece input");
        }
        playground[r][c] = player;
    }

    void initPiecesCount() throws IncorrectGameConfigFileException {
        try {
            for (int r = 0; r < size; r++) {
                for (int c = 0; c < size; c++) {
                    if (playground[r][c] == Player.B) {
                        left.put(Player.B, left.get(Player.B) + 1);
                    } else if (playground[r][c] == Player.W) {
                        left.put(Player.W, left.get(Player.W) + 1);
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            throw new IncorrectGameConfigFileException("Playground  is not valid", e);
        }
    }

    private void run() throws IncorrectGameConfigFileException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                PlaygroundPrinter.printPlayground(playground, size);
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                printPiecesLeftCount();
            }
            reader.close();
        } catch (IOException e) {
            throw new IncorrectGameConfigFileException("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    void execute(String line) {
        if (!isPieceInputCorrect(line)) {
            System.out.println("Incorrect piece input");
            return;
        }
        int[] coordinates = getCoordinates(line);
        move(coordinates[0], coordinates[1]);
    }

    private void printPiecesLeftCount() {
        System.out.printf("Number of pieces: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return left.get(Player.B);
    }

    int getLeftW() {
        return left.get(Player.W);
    }

    void move(int r, int c) {
        if (!isWithinPlayground(r, c)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty piece is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> piecesToFlip = getPiecesToFlip(r, c);
        if (piecesToFlip.isEmpty()) {
            System.out.println("Move is not permitted");
            return;
        }
        flipPieces(piecesToFlip);

        swapPlayerOnTurn();
        if (! areValidMoves()) {
            endGame();
        }
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < size && c < size;
    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    ArrayList<List<Integer>> getPiecesToFlip(int r0, int c0) {
        ArrayList<List<Integer>> toFlip = new ArrayList<>();
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
                toFlip.add(new ArrayList<>(Arrays.asList(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (!toFlip.isEmpty()) {
            toFlip.add(new ArrayList<>(Arrays.asList(r0, c0)));
        }
        return toFlip;
    }

    void flipPieces(List<List<Integer>> pieces) {
        pieces.forEach(piece -> {
            Player previous = playground[piece.get(0)][piece.get(1)];
            playground[piece.get(0)][piece.get(1)] = onTurn;
            if (previous == Player.NONE) {
                left.put(onTurn, left.get(onTurn) + 1);
            } else if (previous != onTurn) {
                left.put(previous, left.get(previous) - 1);
                left.put(onTurn, left.get(onTurn) + 1);
            }
        });
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    boolean areValidMoves() {
        int movesNum = getPossibleMoves().size();
        return movesNum != 0;
    }

    ArrayList<String> getPossibleMoves() {
        ArrayList<String> pieces = new ArrayList<>();
        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getPiecesToFlip(r, c).isEmpty()) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                pieces.add(rString + " " + cString);
            }
        }
        return pieces;
    }

    void endGame() {
        printPiecesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }

    public static void main(String[] args) {
        Path gameFilePath = GameConfig.game8bInit;
        Reversi rev;
        try {
            rev = new Reversi(gameFilePath);
            rev.run();
        } catch (IncorrectGameConfigFileException e) {
            System.out.println(e.getMessage());
        }

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'PlaygroundPrinter.java', 11, 'import java.util.Collections;

class PlaygroundPrinter {

    static void printPlayground(Player[][] playground, int size) {
        printUpperEnumeration(size);
        for (int r = 0; r < size; r++) {
            printLeftEnumeration(r, size);
            for (int c = 0; c < size; c++) {
                if (playground[r][c] == Player.NONE) {
                    printPiece("_", size);
                }
                else if (playground[r][c] == Player.B) {
                    printPiece("B", size);
                }
                else if (playground[r][c] == Player.W) {
                    printPiece("W", size);
                }
            }
            System.out.println();
        }
    }

    private static void printUpperEnumeration(int size) {
        int length = String.valueOf(size - 1).length() + 1;
        System.out.print(String.join("", Collections.nCopies(length, " ")));
        for (int i = 0; i < size; i++) {
            System.out.print(String.format("%-" + (length) + "d", i));
        }
        System.out.print(System.lineSeparator());
    }

    private static void printLeftEnumeration(int r, int size) {
        int length = String.valueOf(size - 1).length();
        System.out.print(String.format("%" + length + "d ", r));
    }

    private static void printPiece(String piece, int size) {
        System.out.print(piece + String.join("", Collections.nCopies(String.valueOf(size - 1).length(), " ")));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 11, 'public enum Player {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'IncorrectGameConfigFileException.java', 11, 'public class IncorrectGameConfigFileException extends Exception {

    public IncorrectGameConfigFileException(String message) {
        super(message);
    }

    public IncorrectGameConfigFileException(String message, Throwable cause) {
        super(message, cause);
    }


}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'NotPermittedMoveException.java', 11, 'public class NotPermittedMoveException extends Exception {

    public NotPermittedMoveException(String message) {
        super(message);
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'GameConfig.java', 11, 'import java.io.File;
import java.nio.file.Path;

class GameConfig {

    private static String gameConfigDir = "./files/";
    static Path game8bInit = new File(gameConfigDir + "game_8_b_init.txt").toPath();
    static Path game8wInit = new File(gameConfigDir + "game_8_w_init.txt").toPath();
    static Path game10bInit = new File(gameConfigDir + "game_10_b_init.txt").toPath();
    static Path game20bInit = new File(gameConfigDir + "game_20_b_init.txt").toPath();
    static Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    static Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();
    static Path gameFiveLines = new File(gameConfigDir + "game_five_lines.txt").toPath();
    static Path gameAlpha = new File(gameConfigDir + "game_alpha.txt").toPath();
    static Path gameNoSize = new File(gameConfigDir + "game_no_size.txt").toPath();
    static Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    static Path gameNoPieces = new File(gameConfigDir + "game_no_pieces.txt").toPath();
    static Path game8bComplete = new File(gameConfigDir + "game_8_b_complete.txt").toPath();
    static Path game8bAlmostComplete = new File(gameConfigDir + "game_8_b_almost_complete.txt").toPath();
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlayerTest.java', 11, 'import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class PlayerTest {

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReadGameConfigTest.java', 11, 'import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.assertEquals;

public class ReadGameConfigTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();

    @Test
    public void testReadGameConfig8bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8bInit);

        assertEquals("Lines number of game8bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8bInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game8bInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8bInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig8wInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game8wInit);

        assertEquals("Lines number of game8wInit config file", 4, gameConfig.length);
        assertEquals("1st line of game8wInit config file", "8", gameConfig[0]);
        assertEquals("2nd line of game8wInit config file", "W", gameConfig[1]);
        assertEquals("3rd line of game8wInit config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of game8wInit config file", "3 3, 4 4", gameConfig[3]);
    }

    @Test
    public void testReadGameConfig10bInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.game10bInit);

        assertEquals("Lines number of game10bInit config file", 4, gameConfig.length);
        assertEquals("1st line of game10bInit config file", "10", gameConfig[0]);
        assertEquals("2nd line of game10bInit config file", "B", gameConfig[1]);
        assertEquals("3rd line of game10bInit config file", "4 5, 5 4", gameConfig[2]);
        assertEquals("4th line of game10bInit config file", "4 4, 5 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigEmpty() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameEmpty);

        assertEquals("Lines number of gameEmpty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigNotExisting() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file does not exist");
        game.readGameConfig(GameConfig.gameNotExisting);
    }


    @Test
    public void testReadGameConfigFiveLines() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameFiveLines);

        assertEquals("Lines number of gameFiveLines config file", 5, gameConfig.length);
        assertEquals("1st line of gameFiveLines config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameFiveLines config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameFiveLines config file", "3 4, 4 3", gameConfig[2]);
        assertEquals("4th line of gameFiveLines config file", "3 3, 4 4", gameConfig[3]);
        assertEquals("5th line of gameFiveLines config file", "3 3, 4 4", gameConfig[4]);
    }

    @Test
    public void testReadGameConfigAlpha() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameAlpha);

        assertEquals("Lines number of gameAlpha config file", 4, gameConfig.length);
        assertEquals("1st line of gameAlpha config file", "8", gameConfig[0]);
        assertEquals("2nd line of gameAlpha config file", "B", gameConfig[1]);
        assertEquals("3rd line of gameAlpha config file", "E 4, D 5", gameConfig[2]);
        assertEquals("4th line of gameAlpha config file", "D 4, E 5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNoSize() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoSize);

        assertEquals(3, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoOnTurn() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoOnTurn);

        assertEquals(3, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("3 4, 4 3", gameConfig[1]);
        assertEquals("3 3, 4 4", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigNoPieces() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(GameConfig.gameNoPieces);

        assertEquals(2, gameConfig.length);
        assertEquals("8", gameConfig[0]);
        assertEquals("B", gameConfig[1]);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'InitGameTest.java', 11, 'import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class InitGameTest {

    private Reversi rev = new Reversi();

    @Rule
    public ExpectedException expectedException = ExpectedException.none();


    //setSize

    @Test
    public void testSetSize8() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setSize("8");

        assertEquals("set size 8", 8, game.size);
    }

    @Test
    public void testSetSizeNeg8() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect size input");
        game.setSize("-8");
    }

    @Test
    public void testSetSizeA() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect size input");
        game.setSize("A");
    }


    // setOnTurnInputCorrect

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

    @Test
    public void testSetOnTurnA() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn("A");
    }

    @Test
    public void testSetOnTurnNone() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn("NONE");
    }

    @Test
    public void testSetOnTurnnull() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect player on turn input");
        game.setOnTurn(null);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertArrayEquals("create empty playground", TestUtils.getEmptyPlayground(), game.playground);
    }


    // isPieceInputCorrect

    @Test
    public void testPieceInput00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertTrue("piece input: 00", game.isPieceInputCorrect("0 0"));
    }

    @Test
    public void testPieceInput00NoSpace() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: 00", game.isPieceInputCorrect("00"));
    }

    @Test
    public void testPieceInputD3() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        assertFalse("piece input: D3", game.isPieceInputCorrect("D 3"));
    }


    // testGetCoordinates

    @Test
    public void testGetCoordinates34() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        int[] expected = new int[] {3, 4};
        int[] result = game.getCoordinates("3 4");
        assertArrayEquals(expected, result);
    }


    // setPiece

    @Test
    public void testSetPiece00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.setPiece(new int[] {0, 0}, Player.B);

        assertEquals("set player B on piece 00", Player.B, TestUtils.getPiece(game, 0, 0));
    }

    @Test
    public void testSetPiece80() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[] {8, 0}, Player.B);
    }

    @Test
    public void testSetPiece08() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[] {0, 8}, Player.B);
    }

    @Test
    public void testSetPiece88() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.setPiece(new int[] {8, 8}, Player.B);
    }


    // fillPlayground

    @Test
    public void testFillPlayground8bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();
        game.size = 8;
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("fill playground with initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("fill playground with initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testFillPlaygroundConfigLen1() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"one"};
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(gameConfig);
    }

    @Test
    public void testFillPlaygroundNull() throws IncorrectGameConfigFileException {
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file is incorrect");
        game.fillPlayground(null);
    }

    @Test
    public void testFillPlaygroundNoOnTurn() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.getRevWithPlayground();

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.fillPlayground(gameConfig);
    }
    
    
    // initGame

    @Test
    public void testInitGame8bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame8wInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "W", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 8, game.size);
        Assert.assertEquals("init playground on initial game config", Player.W, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
    }

    @Test
    public void testInitGame10bInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"10", "B", "4 5, 5 4", "4 4, 5 5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        Assert.assertEquals("init playground on initial game config", 10, game.size);
        Assert.assertEquals("init playground on initial game config", Player.B, game.onTurn);
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("init playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("init playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
    }

    @Test
    public void testInitGameEmpty() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameFiveLines() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4", "3 3, 4 4"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameAlpha() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "E 4, D 5", "D 4, E 5"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNoSize() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNoOnTurn() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNoPieces() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B"};
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        game.initGame(gameConfig);
    }

    @Test
    public void testInitGameNull() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration is null");
        game.initGame(null);
    }
    
    
    // initPiecesCount

    @Test
    public void testInitPiecesCountInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[]{"8", "B", "3 4, 4 3", "3 3, 4 4"};
        Reversi game = TestUtils.initReversi(gameConfig);
        game.initPiecesCount();

        assertEquals("init pieces count on initial game config", 2, game.getLeftB());
        assertEquals("init pieces count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitPiecesCountEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();

        assertEquals("init pieces count on empty game config", 0, game.getLeftB());
        assertEquals("init pieces count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }


    // getLeftW

    @Test
    public void testGetLeftW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void test8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);

        assertEquals("on turn player on initial game config", Player.W, game.onTurn);
        assertEquals("size on initial game config", 8, game.size);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 3, 4));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 3, 3));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void test10bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game10bInit);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 4, 5));
        assertEquals("playground on initial game config", Player.B, TestUtils.getPiece(game, 5, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 4, 4));
        assertEquals("playground on initial game config", Player.W, TestUtils.getPiece(game, 5, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameEmpty);
    }

    @Test
    public void testNotExisting() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration file does not exist");
        new Reversi(GameConfig.gameNotExisting);
    }

    @Test
    public void testFiveLines() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameFiveLines);
    }

    @Test
    public void testAlpha() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Incorrect piece input");
        new Reversi(GameConfig.gameAlpha);
    }

    @Test
    public void testNoSize() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoSize);
    }

    @Test
    public void testNoOnTurn() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoOnTurn);
    }

    @Test
    public void testNoPieces() throws IncorrectGameConfigFileException {
        expectedException.expect(IncorrectGameConfigFileException.class);
        expectedException.expectMessage("Game configuration must contain 4 lines");
        new Reversi(GameConfig.gameNoPieces);
    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'PlaygroundPrinterTest.java', 11, 'import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

import static org.junit.Assert.assertEquals;

public class PlaygroundPrinterTest {

    private final ByteArrayOutputStream outContent = new ByteArrayOutputStream();
    private final PrintStream originalOut = System.out;

    @Before
    public void setUpStreams() {
        System.setOut(new PrintStream(outContent));
    }

    @After
    public void restoreStreams() {
        System.setOut(originalOut);
    }

    @Test
    public void testPrintPlayground8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8wInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ W B _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ B W _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground10bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game10bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 8 9 " + System.lineSeparator() +
                        "0 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "1 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "2 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "3 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "4 _ _ _ _ W B _ _ _ _ " + System.lineSeparator() +
                        "5 _ _ _ _ B W _ _ _ _ " + System.lineSeparator() +
                        "6 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "7 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "8 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator() +
                        "9 _ _ _ _ _ _ _ _ _ _ " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground20bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game20bInit);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "   0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 " + System.lineSeparator() +
                " 0 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 1 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 2 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 3 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 4 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 5 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 6 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 7 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 8 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                " 9 _  _  _  _  _  _  _  _  _  W  B  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "10 _  _  _  _  _  _  _  _  _  B  W  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "11 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "12 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "13 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "14 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "15 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "16 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "17 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "18 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator() +
                "19 _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bAlmostComplete() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B W B B W W B B " + System.lineSeparator() +
                        "1 W W B W B W W W " + System.lineSeparator() +
                        "2 B W B W B B W B " + System.lineSeparator() +
                        "3 W W B B _ W W B " + System.lineSeparator() +
                        "4 B B B W B B B B " + System.lineSeparator() +
                        "5 W W B W W W W W " + System.lineSeparator() +
                        "6 B B B W B B W B " + System.lineSeparator() +
                        "7 W B W W B W B W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }

    @Test
    public void testPrintPlayground8bComplete() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        PlaygroundPrinter.printPlayground(game.playground, game.size);
        String expected =
                "  0 1 2 3 4 5 6 7 " + System.lineSeparator() +
                        "0 B B B B B B B B " + System.lineSeparator() +
                        "1 B W W W W W W B " + System.lineSeparator() +
                        "2 B W W B W B W B " + System.lineSeparator() +
                        "3 B B W W B W B B " + System.lineSeparator() +
                        "4 B B B W B B W B " + System.lineSeparator() +
                        "5 B B W W B W W B " + System.lineSeparator() +
                        "6 B B B B B B W B " + System.lineSeparator() +
                        "7 W W W W W W W W " + System.lineSeparator();
        assertEquals(expected, outContent.toString());
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'MoveTest.java', 11, 'import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class MoveTest {
    
    @Rule
    public ExpectedException expectedException = ExpectedException.none();

    
    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.size = 8;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNeg10() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlayground0Neg1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlayground80() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlayground08() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // TestUtils.getPiecesToFlip

    @Test
    public void testGetPiecesToFlipInit32() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(3, 2);
        List<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("pieces to flip on onit - (3, 2)", 2, pieces.size());
        assertEquals(expected.get(0).get(0), pieces.get(0).get(0));
        assertEquals(expected.get(0).get(1), pieces.get(0).get(1));
        assertEquals(expected.get(1).get(0), pieces.get(1).get(0));
        assertEquals(expected.get(1).get(1), pieces.get(1).get(1));
    }

    @Test
    public void testGetPiecesToFlipInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = game.getPiecesToFlip(0, 0);

        assertEquals("pieces to flip on onit - (0, 0)", 0, pieces.size());
    }


    // flipPieces

    @Test
    public void testFlipPieces() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<List<Integer>> pieces = new ArrayList<>();
        pieces.add(Arrays.asList(3, 3));
        pieces.add(Arrays.asList(3, 2));
        game.flipPieces(pieces);

        assertEquals(Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals(Player.B, TestUtils.getPiece(game, 3, 2));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMoves8bInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 4, pieces.size());
        assertEquals("valid moves", "2 3", pieces.get(0));
        assertEquals("valid moves", "3 2", pieces.get(1));
        assertEquals("valid moves", "4 5", pieces.get(2));
        assertEquals("valid moves", "5 4", pieces.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = TestUtils.getRevWithPlayground();
        List<String> pieces = game.getPossibleMoves();

        assertEquals("valid length", 0, pieces.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);

        assertFalse(game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8wInit);
        game.swapPlayerOnTurn();

        assertEquals(Player.B, game.onTurn);
    }


    // endGame

    @Test
    public void testEndGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bComplete);
        game.endGame();

        assertTrue(game.ended);
        assertEquals(Player.B, game.winner);
    }
    
    
    // move

    @Test
    public void testMoveOnNotEmpty() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move on not empty piece is not permitted");
        game.move(4, 4);
    }

    @Test
    public void testMoveOutOfBoundsBelow() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move out of bounds is not permitted");
        game.move(8, 0);
    }

    @Test
    public void testMoveOutOfBoundsAbove() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move out of bounds is not permitted");
        game.move(-1, 0);
    }

    @Test
    public void testMoveOnNotAdjacent() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);

        expectedException.expect(NotPermittedMoveException.class);
        expectedException.expectMessage("Move is not permitted");
        game.move(0, 0);
    }

    @Test
    public void testMoveFlipRight() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(3, 2);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(5, 4);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 4));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(4, 5);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 4, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.move(2, 3);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 1, game.getLeftW());
        Assert.assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(6, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 5, 3));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 6, 2));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 4, 4));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 5, 5));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(1, 5));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 2, 4));
        Assert.assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 1, 5));
        Assert.assertEquals("on turn", Player.W, game.onTurn);
        Assert.assertEquals("W left", 2, game.getLeftW());
        Assert.assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 3, 3));
        Assert.assertEquals("check if flipped", Player.W, TestUtils.getPiece(game, 2, 2));
        Assert.assertEquals("on turn", Player.B, game.onTurn);
        Assert.assertEquals("W left", 3, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 4));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertEquals("check if flipped (D,3) correctly", Player.W, TestUtils.getPiece(game, 2, 3));
        Assert.assertEquals("check if flipped (E,4) correctly", Player.W, TestUtils.getPiece(game, 3, 4));
        Assert.assertEquals("W left", 5, game.getLeftW());
        Assert.assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.move(3, 4);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 39, game.getLeftW());
        Assert.assertEquals("B left", 25, game.getLeftB());
        Assert.assertEquals("winner", Player.W, game.winner);
    }

    @Test
    public void testMovesCompleteGame() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        List<List<Integer>> moves = new ArrayList<>();
        moves.add(Arrays.asList(4, 5));
        moves.add(Arrays.asList(5, 3));
        moves.add(Arrays.asList(3, 2));
        moves.add(Arrays.asList(2, 3));
        moves.add(Arrays.asList(2, 2));
        moves.add(Arrays.asList(3, 5));
        moves.add(Arrays.asList(4, 2));
        moves.add(Arrays.asList(2, 1));
        moves.add(Arrays.asList(1, 2));
        moves.add(Arrays.asList(5, 4));
        moves.add(Arrays.asList(5, 2));
        moves.add(Arrays.asList(3, 1));
        moves.add(Arrays.asList(4, 1));
        moves.add(Arrays.asList(1, 3));
        moves.add(Arrays.asList(2, 4));
        moves.add(Arrays.asList(5, 0));
        moves.add(Arrays.asList(0, 2));
        moves.add(Arrays.asList(5, 1));
        moves.add(Arrays.asList(2, 5));
        moves.add(Arrays.asList(5, 5));
        moves.add(Arrays.asList(6, 5));
        moves.add(Arrays.asList(0, 4));
        moves.add(Arrays.asList(1, 4));
        moves.add(Arrays.asList(0, 5));
        moves.add(Arrays.asList(6, 4));
        moves.add(Arrays.asList(2, 6));
        moves.add(Arrays.asList(6, 2));
        moves.add(Arrays.asList(3, 6));
        moves.add(Arrays.asList(4, 6));
        moves.add(Arrays.asList(7, 3));
        moves.add(Arrays.asList(3, 7));
        moves.add(Arrays.asList(6, 3));
        moves.add(Arrays.asList(0, 3));
        moves.add(Arrays.asList(0, 1));
        moves.add(Arrays.asList(7, 1));
        moves.add(Arrays.asList(7, 2));
        moves.add(Arrays.asList(7, 4));
        moves.add(Arrays.asList(1, 5));
        moves.add(Arrays.asList(2, 7));
        moves.add(Arrays.asList(5, 6));
        moves.add(Arrays.asList(4, 7));
        moves.add(Arrays.asList(1, 6));
        moves.add(Arrays.asList(2, 0));
        moves.add(Arrays.asList(7, 5));
        moves.add(Arrays.asList(7, 6));
        moves.add(Arrays.asList(3, 0));
        moves.add(Arrays.asList(0, 7));
        moves.add(Arrays.asList(1, 0));
        moves.add(Arrays.asList(0, 6));
        moves.add(Arrays.asList(5, 7));
        moves.add(Arrays.asList(6, 1));
        moves.add(Arrays.asList(7, 0));
        moves.add(Arrays.asList(6, 0));
        moves.add(Arrays.asList(7, 7));
        moves.add(Arrays.asList(4, 0));
        moves.add(Arrays.asList(1, 7));
        moves.add(Arrays.asList(0, 0));
        moves.add(Arrays.asList(1, 1));
        moves.add(Arrays.asList(6, 7));
        moves.add(Arrays.asList(6, 6));
        Reversi game = TestUtils.setMoves(moves);

        Assert.assertFalse("if the are valid moves", game.areValidMoves());
        Assert.assertEquals("W left", 28, game.getLeftW());
        Assert.assertEquals("B left", 36, game.getLeftB());
        Assert.assertEquals("winner", Player.B, game.winner);
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ExecuteTest.java', 11, 'import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

public class ExecuteTest {

    @Test
    public void testExecute32() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("3 2");

        assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 3));
        assertEquals("check if flipped", Player.B, TestUtils.getPiece(game, 3, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecute00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        game.execute("0 0");

        Assert.assertArrayEquals("check if didn''t change", TestUtils.getInitPlayground(), game.playground);
    }

    @Test
    public void testExecuteFinishGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(GameConfig.game8bAlmostComplete);
        game.execute("3 4");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 39, game.getLeftW());
        assertEquals("B left", 25, game.getLeftB());
        assertEquals("winner", Player.W, game.winner);
    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'TestUtils.java', 11, 'import java.util.List;


class TestUtils {

    static Player getPiece(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }

    static Reversi setMoves(List<List<Integer>> moves) throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(GameConfig.game8bInit);
        for (List<Integer> move : moves) {
            Integer r = move.get(0);
            Integer c = move.get(1);
            game.move(r, c);
        }
        return game;
    }

    static Reversi initReversi(String[] gameConfig) throws IncorrectGameConfigFileException {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    static Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    static Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    static Player[][] getInitPlayground() {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 11, 'import org.junit.Test;

import static org.junit.Assert.*;


public class ReversiTest {

    private Reversi rev = new Reversi();

    @Test
    public void testSample() {
        Reversi game1 = rev;
        Reversi game2 = new Reversi(GameConfig.game8bInit);

        int expected = 1;
        int actual = 1;
        assertEquals(expected, actual);
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_10_b_init.txt', '10
B
4 5, 5 4
4 4, 5 5
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_20_b_init.txt', '20
B
9 10, 10 9
9 9, 10 10
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_almost_complete.txt', '8
W
4 5, 3 2, 2 2, 4 2, 1 2, 5 2, 4 1, 2 4, 0 2, 2 5, 6 5, 1 4, 6 4, 6 2, 4 6, 3 7, 0 3, 7 1, 7 4, 2 7, 4 7, 2 0, 7 6, 0 7, 0 6, 6 1, 6 0, 4 0, 0 0, 6 7, 3 3, 4 4
5 3, 2 3, 3 5, 2 1, 5 4, 3 1, 1 3, 5 0, 5 1, 5 5, 0 4, 0 5, 2 6, 3 6, 7 3, 6 3, 0 1, 7 2, 1 5, 5 6, 1 6, 7 5, 3 0, 1 0, 5 7, 7 0, 7 7, 1 7, 1 1, 6 6, 4 3
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_complete.txt', '8
B
0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 0 1, 3 1, 4 1, 5 1, 6 1, 0 2, 4 2, 6 2, 0 3, 2 3, 6 3, 0 4, 3 4, 4 4, 5 4, 6 4, 0 5, 2 5, 4 5, 6 5, 0 6, 3 6, 0 7, 1 7, 2 7, 3 7, 4 7, 5 7, 6 7
7 0, 1 1, 2 1, 7 1, 1 2, 2 2, 3 2, 5 2, 7 2, 1 3, 3 3, 4 3, 5 3, 7 3, 1 4, 2 4, 7 4, 1 5, 3 5, 5 5, 7 5, 1 6, 2 6, 4 6, 5 6, 6 6, 7 6, 7 7
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_b_init.txt', '8
B
3 4, 4 3
3 3, 4 4
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_8_w_init.txt', '8
W
3 4, 4 3
3 3, 4 4
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_alpha.txt', '8
B
E 4, D 5
D 4, E 5
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_five_lines.txt', '8
B
3 4, 4 3
3 3, 4 4
3 3, 4 4
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '8
3 4, 4 3
3 3, 4 4
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_pieces.txt', '8
B
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_size.txt', 'B
3 4, 4 3
3 3, 4 4
', 11, 'public_file');

