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
    created timestamp,
	course_id int references courses on delete cascade
);

drop table if exists exercise_types CASCADE;
create table exercise_types (
	id serial primary key,
	name text,
	value text,
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
    number int
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
    solution_content_type text,
    solution_estimation_id int references solution_estimation
);

drop table if exists solution_estimation cascade;
create table solution_estimation (
	id serial primary key,
	solution_id int,
	estimation text,
    solved boolean,
    created timestamp
);

truncate table
    courses,
    lessons,
    exercise_types,
    exercises,
    exercise_content,
    bugs_number,
    solutions,
    solution_content,
    solution_estimation
restart identity cascade;

INSERT INTO exercise_types (id, name, value)
VALUES (1, 'Interactive Exercise', 'whitebox'),
       (2, 'Interactive Exercise with Files', 'whitebox-file'),
       (3, 'Black Box', 'blackbox'),
       (4, 'Black Box with Files', 'blackbox-file'),
       (5, 'Theory', 'theory');

INSERT INTO courses (name, created, description, id)
VALUES ('Sample course', '2019-03-28 11:08:09.851', 'Web application functionality overview. Use agile programming methods to build a game, based on a legacy content', 1);

INSERT INTO lessons (name, created, description, id, course_id)
VALUES ('Debugging a legacy program', '2019-03-28 11:08:09.851', 'Exercises on finding and fixing bugs in a legacy program', 1, 1);

INSERT INTO lessons (name, created, description, id, course_id)
VALUES ('Adding new features to the legacy program', '2019-03-28 11:08:09.851', 'Exercise on adding a new feature to the legacy program', 2, 1);

INSERT INTO lessons (name, created, description, id, course_id)
VALUES ('Refactoring the legacy program', '2019-03-28 11:08:09.851', 'Exercises on refactoring the content of the legacy program', 3, 1);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('Intro', 0, 5, '2019-03-28 11:08:09.851', 1, 1, '<h2>Course overview</h2><p>In this course you would build an interactive Reversi game, based on a legacy program.</p><p>The work on the project would be done in three lessons, which represent iterations of the work on the program. Each lesson would have exercises, which would provide feedback and lead through the work on the project.</p><p>By working on project you would  learn Extreme programming methods and apply your skills. Most of the exercises would cover several of these skills, like Test-driven development, unit testing, refactoring and working with legacy code.</p><h4>Testing</h4><p>The first iteration provides exercises on debugging the legacy program. The aim is to find bugs in the legacy program and fix them, but keep the original structure of the code. Writing own tests is necessary to achieve it. The second iteration is aimed to add some features to the code, bud to keep the original structure of the code as well. Tests, used in a previous iteration, with the new tests would be needed to accomplish the iteration requirements. The last iteration is made up with numerous exercises on refactoring. The tests are essential to proof that the program would remain correct.</p><h4>Refactoring</h4><p>The refactoring exercises take place in the third, last iteration. At this moment, after the previous two iterations are completed successfully and passed all the tests, the code would be correct. Each of the numerous exercises is about a single step of the code change, exercise description and title would reference to the book \"Clean Code\" by Robert C. Martin. It is one of the mostly recommended books for software development, and for a good reason. During and after refactoring the code should maintain correct, and it can be provided by tests, written by the user.</p><h4>Legacy program overview</h4><p>The legacy program is a two-player interactive Reversi game. The rules can be found here <a href=\"http://www.flyordie.com/games/help/reversi/en/games_rules_reversi.html\" target=\"_blank\" style=\"color: rgb(70, 63, 92);\">http://www.flyordie.com/games/help/reversi/en/games_rules_reversi.html</a></p><p>The game is played from console. The state of the game is read from configuration files, which have the following structure:</p><ul><li>first row has "B" or "W", which means the player on turn, </li><li>the secong row contatins the moves of the player, whose color is black, </li><li>and the thirs row contains the moves of the player, whose color is white.</li></ul><p>The values are separated by space.</p>', False);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('Finding the Bugs in Legacy Program', 1, 4, '2019-03-28 11:08:09.851', 2, 1, '<h2>Objective</h2><p>You need to find bugs in the legacy program, but the source code is not available.</p><p>Write own tests to find the bugs.</p><p></p><h3><strong>User stories</strong></h3><ul><li>find <strong>three </strong>bugs.</li></ul><p><br></p><h2>Source code structure</h2><pre class=\"ql-syntax\" spellcheck=\"false\">public class Reversi {<br><br>    int[][] playground;<br>    int leftB = 0;<br>    int leftW = 0;<br>    private int[] players = new int[] { 1, 0 };<br>    int onTurn = -1;<br>    int winner = -1;<br>    boolean ended = false;<br><br>    Reversi() { }<br>    Reversi(Path gameFilePath) {...}<br><br>    private void run() {...}<br>    String[] readGameConfig(Path gameFilePath) {...}<br>    void initGame(String[] gameConfig) {...}<br>    void initTilesCount() {...}<br>    int getLeftB() {...}<br>    int getLeftW() {...}<br>    void move(int r0, int c0) {...}<br>    boolean areValidMoves() {...}<br>    public static void main(String[] args) {...}<br>}<br></pre><p><br></p>', False);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('Debugging the Legacy Program', 2, 2, '2019-03-28 11:08:09.851', 3, 1, '<h2>Objective</h2><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">Fix bugs in the legacy program from previous exercise. You can use tests you wrote to find the bugs.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">When fixing the legacy program, you should keep the original core structure of the code. The program should pass all your and hidden tests.</span></p><p></p><h3><strong>User stories</strong></h3><ul><li>fix <strong>three </strong>bugs</li><li>do not make more.</li></ul><h2><br></h2>', False);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('Adding New Feature', 0, 2, '2019-03-28 11:08:09.851', 4, 2, '<h2>Objective</h2><p>Add a new feature to the legacy code:&nbsp;<strong>conventional board enumeration</strong> for Reversi.</p><p>Use Alpha&nbsp;<em>enum</em>&nbsp;to represent the values of the grid indexes: <em>Alpha.A</em>&nbsp;for 0,&nbsp;<em>Alpha.B</em>&nbsp;for 1 etc.</p><p>Function<em> move</em> would get conventional input like (Alpha.E, 4).</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><h3><strong>User stories</strong></h3><ul><li>The board <span style=\"background-color: rgb(255, 255, 255); color: rgb(34, 34, 34);\">should </span>be enumerated A-H horizontally and 1-8 vertically</li><li><span style=\"background-color: rgb(255, 255, 255); color: rgb(34, 34, 34);\">Each move of a piece should be indicated by the coordinate of the destination square (e.g. E4)</span></li><li>New board enumeration should be used on printed out playground</li></ul><h2><br></h2>', False);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('Magic Numbers', 0, 2, '2019-03-28 11:08:09.851', 5, 3, '<h2>Objective</h2><p>Replace&nbsp;<strong>Magic Numbers</strong>&nbsp;with&nbsp;<strong>Named Constants</strong>. <span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">As a result, such variables get a name, which describes its meaning. It becomes easier to read, maintain and change the code.</span></p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><p></p><h3><strong>User stories</strong></h3><ul><li>Replace numbers representing the board size with private constant&nbsp;<em>SIZE</em>.</li></ul>', False);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('Constants versus Enums', 1, 2, '2019-03-28 11:08:09.851', 6, 3, '<h2>Objective</h2><blockquote>Now that enums have been added to the language (Java 5), use them! Don’t keep using the old trick of <em>public static final int</em>s. The meaning of <em>int</em>s can get lost. The meaning of <em>enum</em>s cannot, because they belong to an enumeration that is named. What’s more, study the syntax for <em>enum</em>s carefully. They can have methods and fields. This makes them very powerful tools that allow much more expression and flexibility than <em>int</em>s.&nbsp;<br><em>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Use&nbsp;<em>Player</em>&nbsp;<em>enum</em>&nbsp;to represent the players'' values:</p><ul><li><em>Player.W</em>&nbsp;for ''W'' instead of 0;</li><li><em>Player.B</em>&nbsp;for ''B'' instead of 1;</li><li><em>Player.NONE</em>&nbsp;for no player instead of -1.</li></ul><p>Use new <em>enum </em>for initialing the game and to print out the current state.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Use&nbsp;<em>Player</em>&nbsp;<em>enum</em>&nbsp;to represent the players'' values.</li></ul><p><br></p><p><br></p><p><br></p>",
', False);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('Do One Thing', 2, 2, '2019-03-28 11:08:09.851', 7, 3, '<h2>Objective</h2><blockquote>Functions should do one thing. They should do it well. They should do it only. <br>So, another way to know that a function is doing more than “one thing” is if you can extract another function from it with a name that is not merely a restatement of its implementation. <em style=\"color: rgb(68, 68, 68);\"><br>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>For example, function&nbsp;<em>initGame&nbsp;</em>does not initialize game only, but also sets a player on turn, creates and fills playground, and places the tiles on it. Function&nbsp;<em>run&nbsp;</em>contains execution of the read line, which should be extracted as well. Function&nbsp;<em>move&nbsp;</em>does multiple things as well: it ends the game, finds tiles to flip, and flips them. Function&nbsp;<em>areValidMoves&nbsp;</em>gets possible moves. It also finds tiles to flip as well as&nbsp;<em>move</em>&nbsp;function with the use of duplicate code.</p><p>Make the current code way more readable and maintainable with extracting the functions from the ones, which do multiple things.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><h3><strong>User stories</strong></h3><ul><li>Extract function&nbsp;<em>execute&nbsp;</em>from function&nbsp;<em>run</em></li><li>Extract functions&nbsp;<em>setOnTurn</em>,&nbsp;<em>createPlayground</em>,&nbsp;<em>fillPlayground&nbsp;</em>and&nbsp;<em>setTile&nbsp;</em>from function&nbsp;<em>initGame</em></li><li>Extract function&nbsp;<em>endGame</em>,&nbsp;<em>flipTiles</em>,&nbsp;<em>getTilesToFlip&nbsp;</em>from function&nbsp;<em>move</em></li><li>Extract functions&nbsp;<em>getPossibleMoves</em>,&nbsp;<em>getTilesToFlip&nbsp;</em>from function&nbsp;<em>areValidMoves</em>.</li></ul><p><br></p>', False);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('One Level of Abstraction per Function', 3, 2, '2019-03-28 11:08:09.851', 8, 3, '<h2>Objective</h2><blockquote>Mixing levels of abstraction within a function is always confusing. Readers may not be able to tell whether a particular expression is an essential concept or a detail. Worse, like broken windows, once details are mixed with essential concepts, more and more details tend to accrete within the function. <em><br>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Functions setOnTurn and move do not hold the same abstraction level.</p><p>Make the current code way more readable and maintainable with extracting the functions, which hold lower abstraction levels, should be extracted.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><h3><strong>User stories</strong></h3><ul><li>Extract functions&nbsp;<em>isOnTurnInputCorrect</em>, from function&nbsp;<em>setOnTurn</em></li><li>Extract functions&nbsp;<em>isEmpty</em>, <em>isGameOver </em>and <em>swapPlayerOnTurn&nbsp;</em>from function&nbsp;<em>move</em>.</li></ul><p><br></p>', False);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('No Duplication', 4, 2, '2019-03-28 11:08:09.851', 9, 3, '<h2>Objective</h2><blockquote>Duplication is the primary enemy of a well-designed system. It represents additional work, additional risk, and additional unnecessary complexity. Duplication manifests itself in many forms. Lines of code that look exactly alike are, of course, duplication. Lines of code that are similar can often be massaged to look even more alike so that they can be more easily refactored.&nbsp;<br><em>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Most of the duplicate code was refactored in previous steps.</p><p>Make the code way more readable and maintainable with extracting the rest of duplicite code into fuctions.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><h3><strong>User stories</strong></h3><ul><li>Extract function&nbsp;<em>isTileInputCorrect </em>from functions&nbsp;<em>setTile </em>and <em>execute</em></li><li>Extract function&nbsp;<em>isWithinPlayground&nbsp;</em>from functions&nbsp;<em>move </em>and <em>getTilesToFlip.</em></li></ul><p><br></p>', False);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('Small!', 5, 2, '2019-03-28 11:08:09.851', 10, 3, '<h2>Objective</h2><blockquote>The first rule of functions is that they should be small. The second rule of functions is that they should be smaller than that.<br><em>(Robert C. Martin.&nbsp;Clean Code: A Handbook of Agile Software Craftsmanship)</em></blockquote><p>Most of the large code was refactored in previous steps because of extracting the function from large ones. But there are more ways to reduce function size without lost of readability.</p><p>Make the code functions a way more readable with changing the structure of variable <em>left</em>.</p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><h3><strong>User stories</strong></h3><ul><li>Use map <em>left </em>to store the values of variables <em>leftB </em>and <em>leftW</em>.</li></ul>', False);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('Error Handling I', 6, 2, '2019-03-28 11:08:09.851', 11, 3, '<h2>Objective</h2><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">This exercise focuses on handling exceptions. Errors handling not only makes code robust, but also clean.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">In the legacy code, when an error occurs, the message is printed out to console right where it was occurred. Errors should be thrown instead and handled on higher level, with the use of&nbsp;</span><em style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">try/catch/finally</em><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">&nbsp;block.</span></p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><h3><strong>User stories</strong></h3><ul><li>Use custom exception <em>IncorrectGameConfigFileException </em><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">to handle errors when reading game configuration file;</span></li></ul>', False);

INSERT INTO exercises (name, index, type_id, created, id, lesson_id, description, solved)
VALUES ('Error Handling II', 7, 2, '2019-03-28 11:08:09.851', 12, 3, '<h2>Objective</h2><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">This exercise focuses on handling exceptions, as well as previous one.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">In the legacy code, when an error occurs, the message is printed out to console right where it was occurred. Errors should be thrown instead and handled on higher level, with the use of&nbsp;</span><em style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">try/catch/finally</em><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">&nbsp;block.</span></p><p>Keep the original core structure of the code. You should write own tests so the program would maintain functional and new features would be implemented correctly. The program should pass all your and hidden tests.</p><p></p><h3><strong>User stories</strong></h3><ul><li>Use custom exception <em>IncorrectGameConfigFileException </em><span style=\"background-color: rgb(255, 255, 255); color: rgb(36, 41, 46);\">&nbsp;to handle errors on user input.</span></li></ul>', False);

INSERT INTO bugs_number (exercise_id, number)
VALUES (2, 3);

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_source', 'Reversi.java', 2, 'import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class Reversi {

    int[][] playground;
    int leftB = 0;
    int leftW = 0;
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
            initTilesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!(line.length() == 2 && line.substring(1, 2).matches("[0-7]") &&  line.substring(0, 1).matches("[0-7]"))) {
                    System.out.println("Incorrect tile input");
                    return;
                }
                int r = Integer.parseInt(line.substring(0, 1));
                int c = Integer.parseInt(line.substring(1, 2));
                move(r, c);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Could not open game configuration file.");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file.");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        if (gameConfig.length != 3) {
            System.out.println("Game configuration must contain 3 lines.");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input.");
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
            try {
                for (int i = 1; i < 3; i++) {
                    String[] tiles = gameConfig[i].split(" ");
                    for (String tile : tiles) {
                        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[0-7]") &&  tile.substring(0, 1).matches("[0-7]"))) {
                            System.out.println("Incorrect tile input");
                            return;
                        }
                        int r = Integer.parseInt(tile.substring(1, 2));
                        int c = Integer.parseInt(tile.substring(0, 1));
                        playground[r][c] = players[i - 1];
                    }
                }
            } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
                System.out.println("Game configuration file is incorrect.");
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
    }

    void initTilesCount() {
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

    private void printPlayground() {
        System.out.println("  0 1 2 3 4 5 6 7");
        for (int r = 0; r < 8; r++) {
            System.out.print(r  + " ");
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] == -1)
                    System.out.print("_ ");
                else if (playground[r][c] == 1)
                    System.out.print("B ");
                else
                    System.out.print("W ");
            }
            System.out.println();
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r0, int c0) {
        int r = r0;
        int c = c0;

        if (! switcher.BUGS[0]) {
            if (!(r >= 0 && c >= 0 && r <= 7 && c < 8)) {
                System.out.println("Move out of bounds is not permitted");
                return;
            }
        }
        if (! switcher.BUGS[1]) {
            if (playground[r][c] != -1) {
                System.out.println("Move on not empty tile is not permitted");
                return;
            }
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = new ArrayList<>();
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
                tilesToFlip.add(new ArrayList<>(List.of(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (tilesToFlip.size() != 0) {
            tilesToFlip.add(new ArrayList<>(List.of(r, c)));
        }

        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> tile : tilesToFlip) {
            int tileR = tile.get(0);
            int tileC = tile.get(1);
            if (playground[tileR][tileC] == onTurn) break;
            if (playground[tileR][tileC] == -1) {
                playground[tileR][tileC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[tileR][tileC] = onTurn;
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
            printTilesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = 1;
            else if (getLeftW() > getLeftB()) winner = 0;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
                        toFLip.add(new ArrayList<>(List.of(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (toFLip.size() != 0) {
                    toFLip.add(new ArrayList<>(List.of(r, c)));
                }
                if (toFLip.size() == 0) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                tiles.add(cString.concat(rString));
            }
        }
        return tiles.size() != 0;
    }

    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("upload-dir/12345/game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 2, 'import org.junit.Test;

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();

    @Test
    public void test() {
        Reversi game = rev;
        // TODO
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
45 32 22 42 12 52 41 24 02 25 65 14 64 62 46 37 03 71 74 27 47 20 76 07 06 61 60 40 00 67 33 44
53 23 35 21 54 31 13 50 51 55 04 05 26 36 73 63 01 72 15 56 16 75 30 10 57 70 77 17 11 66 43
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
45 32 22 42 12 52 41 24 02 25 65 14 64 62 46 37 03 71 74 27 47 20 76 07 06 61 60 40 00 67 33 44
53 23 35 21 54 31 13 50 51 55 04 05 26 36 73 63 01 72 15 56 16 75 30 10 57 70 77 17 11 66 43
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'B
45 32 22 42 12 52 41 24 02 25 65 14 64 62 46 37 03 71 74 27 47 20 76 07 06 61 60 40 00 67 33 44
53 23 35 21 54 31 13 50 51 55 04 05 26 36 73 63 01 72 15 56 16 75 30 10 57 70 77 17 11 66 43 34
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'B
45 32 22 42 12 52 41 24 02 25 65 14 64 62 46 37 03 71 74 27 47 20 76 07 06 61 60 40 00 67 33 44
53 23 35 21 54 31 13 50 51 55 04 05 26 36 73 63 01 72 15 56 16 75 30 10 57 70 77 17 11 66 43 34
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
34 43
33 44
33 44
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
34 43
33 44
33 44
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
34 43
33 44
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
34 43
33 44
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
34 43
33 44
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
34 43
33 44
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '34 43
33 44
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '34 43
33 44
', 2, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', '34 43
', 2, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', '34 43
', 2, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 3, 'import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class Reversi {

    int[][] playground;
    int leftB = 0;
    int leftW = 0;
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
            initTilesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!(line.length() == 2 && line.substring(1, 2).matches("[0-7]") &&  line.substring(0, 1).matches("[0-7]"))) {
                    System.out.println("Incorrect tile input");
                    return;
                }
                int r = Integer.parseInt(line.substring(0, 1));
                int c = Integer.parseInt(line.substring(1, 2));
                move(r, c);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Could not open game configuration file.");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file.");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        if (gameConfig.length != 3) {
            System.out.println("Game configuration must contain 3 lines.");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input.");
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
            try {
                for (int i = 1; i < 3; i++) {
                    String[] tiles = gameConfig[i].split(" ");
                    for (String tile : tiles) {
                        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[0-7]") &&  tile.substring(0, 1).matches("[0-7]"))) {
                            System.out.println("Incorrect tile input");
                            return;
                        }
                        int r = Integer.parseInt(tile.substring(0, 1));
                        int c = Integer.parseInt(tile.substring(1, 2));
                        playground[r][c] = players[i - 1];
                    }
                }
            } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
                System.out.println("Game configuration file is incorrect.");
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
    }

    void initTilesCount() {
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

    private void printPlayground() {
        System.out.println("  0 1 2 3 4 5 6 7");
        for (int r = 0; r < 8; r++) {
            System.out.print(r  + " ");
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] == -1)
                    System.out.print("_ ");
                else if (playground[r][c] == 1)
                    System.out.print("B ");
                else
                    System.out.print("W ");
            }
            System.out.println();
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r0, int c0) {
        int r = r0;
        int c = c0;

        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = new ArrayList<>();
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
                tilesToFlip.add(new ArrayList<>(List.of(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (tilesToFlip.size() != 0) {
            tilesToFlip.add(new ArrayList<>(List.of(r, c)));
        }

        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> tile : tilesToFlip) {
            int tileR = tile.get(0);
            int tileC = tile.get(1);
            if (playground[tileR][tileC] == onTurn) break;
            if (playground[tileR][tileC] == -1) {
                playground[tileR][tileC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[tileR][tileC] = onTurn;
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
            printTilesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = 1;
            else if (getLeftW() > getLeftB()) winner = 0;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
                        toFLip.add(new ArrayList<>(List.of(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (toFLip.size() != 0) {
                    toFLip.add(new ArrayList<>(List.of(r, c)));
                }
                if (toFLip.size() == 0) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                tiles.add(cString.concat(rString));
            }
        }
        return tiles.size() != 0;
    }

    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("upload-dir/12345/game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReversiTest.java', 3, 'import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameAlmostComplete = new File(gameConfigDir + "game_almost_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();


    // readGameConfig

    @Test
    public void testReadGameConfigInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "34 43", gameConfig[1]);
        assertEquals("3rd line of initial config file", "33 44", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigInitW() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "34 43", gameConfig[1]);
        assertEquals("3rd line of initial config file", "33 44", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "34 43", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigFourLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameFourLines);

        assertEquals(4, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("34 43", gameConfig[1]);
        assertEquals("33 44", gameConfig[2]);
        assertEquals("33 44", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameNotExisting);

        String[] expectedGameConfig = new String[]{};
        assertArrayEquals(expectedGameConfig, gameConfig);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGameInit() {
        String[] gameConfig = new String[] {"B", "34 43", "33 44"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 1, game.onTurn);
        assertEquals("init playground on initial game config", 1, getTile(game, 3, 4));
        assertEquals("init playground on initial game config", 1, getTile(game, 4, 3));
        assertEquals("init playground on initial game config", 0, getTile(game, 3, 3));
        assertEquals("init playground on initial game config", 0, getTile(game, 4, 4));
    }

    @Test
    public void testInitGameNoLines() {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOneLine() {
        String[] gameConfig = new String[] {"34 43"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[] {"B", "34 43", "33 44", "33 44"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOnlyB() {
        String[] gameConfig = new String[] {"B", "34 43"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() {
        String[] gameConfig = new String[] {"B", "34 43", "33 44"};
        Reversi game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void testInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("playground on initial game config", 0, getTile(game, 3, 3));
        assertEquals("playground on initial game config", 1, getTile(game, 3, 4));
        assertEquals("playground on initial game config", 1, getTile(game, 4, 3));
        assertEquals("playground on initial game config", 0, getTile(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testOneLine() {
        Reversi game = new Reversi(gameOneLine);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testFourLines() {
        Reversi game = new Reversi(gameFourLines);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue(game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(gameComplete);

        assertFalse(game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(4, 4);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(8, 0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(-1, 0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(0, 0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(3, 2);

        assertEquals("check if flipped", 1, getTile(game, 3, 3));
        assertEquals("check if flipped", 1, getTile(game, 3, 2));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(5, 4);

        assertEquals("check if flipped", 1, getTile(game,4, 4));
        assertEquals("check if flipped", 1, getTile(game, 5, 4));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(4, 5);

        assertEquals("check if flipped", 1, getTile(game, 4, 4));
        assertEquals("check if flipped", 1, getTile(game, 4, 5));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(2, 3);

        assertEquals("check if flipped", 1, getTile(game, 3, 3));
        assertEquals("check if flipped", 1, getTile(game, 2, 3));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(5, 4));
        moves.add(new Pair<>(5, 3));
        moves.add(new Pair<>(6, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 1, getTile(game, 5, 3));
        assertEquals("check if flipped", 1, getTile(game, 6, 2));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(5, 4));
        moves.add(new Pair<>(5, 5));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, 4, 4));
        assertEquals("check if flipped", 0, getTile(game, 5, 5));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 4));
        moves.add(new Pair<>(1, 5));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 1, getTile(game, 2, 4));
        assertEquals("check if flipped", 1, getTile(game, 1, 5));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, 3, 3));
        assertEquals("check if flipped", 0, getTile(game, 2, 2));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 2));
        moves.add(new Pair<>(3, 2));
        moves.add(new Pair<>(2, 4));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", 0, getTile(game, 2, 3));
        assertEquals("check if flipped (E,4) correctly", 0, getTile(game, 3, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(gameAlmostComplete);
        game.move(3, 4);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 39, game.getLeftW());
        assertEquals("B left", 25, game.getLeftB());
        assertEquals("winner", 0, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(4, 5)); moves.add(new Pair<>(5, 3));
        moves.add(new Pair<>(3, 2)); moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 2)); moves.add(new Pair<>(3, 5));
        moves.add(new Pair<>(4, 2)); moves.add(new Pair<>(2, 1));
        moves.add(new Pair<>(1, 2)); moves.add(new Pair<>(5, 4));
        moves.add(new Pair<>(5, 2)); moves.add(new Pair<>(3, 1));
        moves.add(new Pair<>(4, 1)); moves.add(new Pair<>(1, 3));
        moves.add(new Pair<>(2, 4)); moves.add(new Pair<>(5, 0));
        moves.add(new Pair<>(0, 2)); moves.add(new Pair<>(5, 1));
        moves.add(new Pair<>(2, 5)); moves.add(new Pair<>(5, 5));
        moves.add(new Pair<>(6, 5)); moves.add(new Pair<>(0, 4));
        moves.add(new Pair<>(1, 4)); moves.add(new Pair<>(0, 5));
        moves.add(new Pair<>(6, 4)); moves.add(new Pair<>(2, 6));
        moves.add(new Pair<>(6, 2)); moves.add(new Pair<>(3, 6));
        moves.add(new Pair<>(4, 6)); moves.add(new Pair<>(7, 3));
        moves.add(new Pair<>(3, 7)); moves.add(new Pair<>(6, 3));
        moves.add(new Pair<>(0, 3)); moves.add(new Pair<>(0, 1));
        moves.add(new Pair<>(7, 1)); moves.add(new Pair<>(7, 2));
        moves.add(new Pair<>(7, 4)); moves.add(new Pair<>(1, 5));
        moves.add(new Pair<>(2, 7)); moves.add(new Pair<>(5, 6));
        moves.add(new Pair<>(4, 7)); moves.add(new Pair<>(1, 6));
        moves.add(new Pair<>(2, 0)); moves.add(new Pair<>(7, 5));
        moves.add(new Pair<>(7, 6)); moves.add(new Pair<>(3, 0));
        moves.add(new Pair<>(0, 7)); moves.add(new Pair<>(1, 0));
        moves.add(new Pair<>(0, 6)); moves.add(new Pair<>(5, 7));
        moves.add(new Pair<>(6, 1)); moves.add(new Pair<>(7, 0));
        moves.add(new Pair<>(6, 0)); moves.add(new Pair<>(7, 7));
        moves.add(new Pair<>(4, 0)); moves.add(new Pair<>(1, 7));
        moves.add(new Pair<>(0, 0)); moves.add(new Pair<>(1, 1));
        moves.add(new Pair<>(6, 7)); moves.add(new Pair<>(6, 6));
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", 1, game.winner);
    }


    // utility functions

    private int getTile(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    private Reversi setMoves(ArrayList<Pair<Integer, Integer>> moves) {
        Reversi game = new Reversi(gameInitBStarts);
        for (Pair<Integer, Integer> move  : moves) {
            Integer r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    private int[][] getEmptyPlayground() {
        int[][] empty = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = -1;
            }
        }
        return empty;
    }

    private int[][] getInitPlayground() {
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
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 3, 'import org.junit.Test;

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();

    @Test
    public void test() {
        Reversi game = rev;
        // TODO
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
45 32 22 42 12 52 41 24 02 25 65 14 64 62 46 37 03 71 74 27 47 20 76 07 06 61 60 40 00 67 33 44
53 23 35 21 54 31 13 50 51 55 04 05 26 36 73 63 01 72 15 56 16 75 30 10 57 70 77 17 11 66 43
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
45 32 22 42 12 52 41 24 02 25 65 14 64 62 46 37 03 71 74 27 47 20 76 07 06 61 60 40 00 67 33 44
53 23 35 21 54 31 13 50 51 55 04 05 26 36 73 63 01 72 15 56 16 75 30 10 57 70 77 17 11 66 43
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'B
45 32 22 42 12 52 41 24 02 25 65 14 64 62 46 37 03 71 74 27 47 20 76 07 06 61 60 40 00 67 33 44
53 23 35 21 54 31 13 50 51 55 04 05 26 36 73 63 01 72 15 56 16 75 30 10 57 70 77 17 11 66 43 34
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'B
45 32 22 42 12 52 41 24 02 25 65 14 64 62 46 37 03 71 74 27 47 20 76 07 06 61 60 40 00 67 33 44
53 23 35 21 54 31 13 50 51 55 04 05 26 36 73 63 01 72 15 56 16 75 30 10 57 70 77 17 11 66 43 34
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
34 43
33 44
33 44
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
34 43
33 44
33 44
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
34 43
33 44
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
34 43
33 44
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
34 43
33 44
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
34 43
33 44
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '34 43
33 44
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', '34 43
33 44
', 3, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', '34 43
', 3, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', '34 43
', 3, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 4, 'import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class Reversi {

    int[][] playground;
    int leftB = 0;
    int leftW = 0;
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
            initTilesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!(line.length() == 2 && line.substring(1, 2).matches("[0-7]") &&  line.substring(0, 1).matches("[0-7]"))) {
                    System.out.println("Incorrect tile input");
                    return;
                }
                int r = Integer.parseInt(line.substring(0, 1));
                int c = Integer.parseInt(line.substring(1, 2));
                move(r, c);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Could not open game configuration file.");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file.");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        if (gameConfig.length != 3) {
            System.out.println("Game configuration must contain 3 lines.");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input.");
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
            try {
                for (int i = 1; i < 3; i++) {
                    String[] tiles = gameConfig[i].split(" ");
                    for (String tile : tiles) {
                        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[0-7]") &&  tile.substring(0, 1).matches("[0-7]"))) {
                            System.out.println("Incorrect tile input");
                            return;
                        }
                        int r = Integer.parseInt(tile.substring(0, 1));
                        int c = Integer.parseInt(tile.substring(1, 2));
                        playground[r][c] = players[i - 1];
                    }
                }
            } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
                System.out.println("Game configuration file is incorrect.");
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
    }

    void initTilesCount() {
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

    private void printPlayground() {
        System.out.println("  0 1 2 3 4 5 6 7");
        for (int r = 0; r < 8; r++) {
            System.out.print(r  + " ");
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] == -1)
                    System.out.print("_ ");
                else if (playground[r][c] == 1)
                    System.out.print("B ");
                else
                    System.out.print("W ");
            }
            System.out.println();
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(int r0, int c0) {
        int r = r0;
        int c = c0;

        if (!(r >= 0 && c >= 0 && r <= 7 && c < 8)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != -1) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = new ArrayList<>();
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
                tilesToFlip.add(new ArrayList<>(List.of(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (tilesToFlip.size() != 0) {
            tilesToFlip.add(new ArrayList<>(List.of(r, c)));
        }

        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> tile : tilesToFlip) {
            int tileR = tile.get(0);
            int tileC = tile.get(1);
            if (playground[tileR][tileC] == onTurn) break;
            if (playground[tileR][tileC] == -1) {
                playground[tileR][tileC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[tileR][tileC] = onTurn;
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
            printTilesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = 1;
            else if (getLeftW() > getLeftB()) winner = 0;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
                        toFLip.add(new ArrayList<>(List.of(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (toFLip.size() != 0) {
                    toFLip.add(new ArrayList<>(List.of(r, c)));
                }
                if (toFLip.size() == 0) continue;
                String rString = String.valueOf(r);
                String cString = String.valueOf(c);
                tiles.add(cString.concat(rString));
            }
        }
        return tiles.size() != 0;
    }

    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("upload-dir/12345/game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Alpha.java', 4, 'public enum Alpha {
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReversiTest.java', 4, 'import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameAllNum = new File(gameConfigDir + "game_all_num.txt").toPath();
    private Path gameAlmostComplete = new File(gameConfigDir + "game_almost_complete.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();


    // readGameConfig

    @Test
    public void testReadGameConfigInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "34 43", gameConfig[1]);
        assertEquals("3rd line of initial config file", "33 44", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigInitW() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigFourLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameFourLines);

        assertEquals(4, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("E4 D5", gameConfig[1]);
        assertEquals("D4 E5", gameConfig[2]);
        assertEquals("E4 D5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameNotExisting);

        String[] expectedGameConfig = new String[]{};
        assertArrayEquals(expectedGameConfig, gameConfig);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGameInit() {
        String[] gameConfig = new String[] {"B", "34 43", "33 44"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 1, game.onTurn);
        assertEquals("init playground on initial game config", 1, getTile(game, 3, 4));
        assertEquals("init playground on initial game config", 1, getTile(game, 4, 3));
        assertEquals("init playground on initial game config", 0, getTile(game, 3, 3));
        assertEquals("init playground on initial game config", 0, getTile(game, 4, 4));
    }

    @Test
    public void testInitGameNoLines() {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOneLine() {
        String[] gameConfig = new String[] {"E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOnlyB() {
        String[] gameConfig = new String[] {"B", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() {
        String[] gameConfig = new String[] {"B", "34 43", "33 44"};
        Reversi game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void testInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("playground on initial game config", 0, getTile(game, 3, 3));
        assertEquals("playground on initial game config", 1, getTile(game, 3, 4));
        assertEquals("playground on initial game config", 1, getTile(game, 4, 3));
        assertEquals("playground on initial game config", 0, getTile(game, 4, 4));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testOneLine() {
        Reversi game = new Reversi(gameOneLine);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testFourLines() {
        Reversi game = new Reversi(gameFourLines);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAllAlpha() {
        Reversi game = new Reversi(gameAllAlpha);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("...", game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(gameComplete);

        assertFalse("...", game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(4, 4);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(8, 0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(-1, 0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(0, 0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(3, 2);

        assertEquals("check if flipped", 1, getTile(game, 3, 3));
        assertEquals("check if flipped", 1, getTile(game, 3, 2));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(5, 4);

        assertEquals("check if flipped", 1, getTile(game,4, 4));
        assertEquals("check if flipped", 1, getTile(game, 5, 4));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(4, 5);

        assertEquals("check if flipped", 1, getTile(game, 4, 4));
        assertEquals("check if flipped", 1, getTile(game, 4, 5));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(2, 3);

        assertEquals("check if flipped", 1, getTile(game, 3, 3));
        assertEquals("check if flipped", 1, getTile(game, 2, 3));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(5, 4));
        moves.add(new Pair<>(5, 3));
        moves.add(new Pair<>(6, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 1, getTile(game, 5, 3));
        assertEquals("check if flipped", 1, getTile(game, 6, 2));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(5, 4));
        moves.add(new Pair<>(5, 5));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, 4, 4));
        assertEquals("check if flipped", 0, getTile(game, 5, 5));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 4));
        moves.add(new Pair<>(1, 5));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 1, getTile(game, 2, 4));
        assertEquals("check if flipped", 1, getTile(game, 1, 5));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, 3, 3));
        assertEquals("check if flipped", 0, getTile(game, 2, 2));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 2));
        moves.add(new Pair<>(3, 2));
        moves.add(new Pair<>(2, 4));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", 0, getTile(game, 2, 3));
        assertEquals("check if flipped (E,4) correctly", 0, getTile(game, 3, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMovesCompleteGame() {
        ArrayList<Pair<Integer, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(4, 5)); moves.add(new Pair<>(5, 3));
        moves.add(new Pair<>(3, 2)); moves.add(new Pair<>(2, 3));
        moves.add(new Pair<>(2, 2)); moves.add(new Pair<>(3, 5));
        moves.add(new Pair<>(4, 2)); moves.add(new Pair<>(2, 1));
        moves.add(new Pair<>(1, 2)); moves.add(new Pair<>(5, 4));
        moves.add(new Pair<>(5, 2)); moves.add(new Pair<>(3, 1));
        moves.add(new Pair<>(4, 1)); moves.add(new Pair<>(1, 3));
        moves.add(new Pair<>(2, 4)); moves.add(new Pair<>(5, 0));
        moves.add(new Pair<>(0, 2)); moves.add(new Pair<>(5, 1));
        moves.add(new Pair<>(2, 5)); moves.add(new Pair<>(5, 5));
        moves.add(new Pair<>(6, 5)); moves.add(new Pair<>(0, 4));
        moves.add(new Pair<>(1, 4)); moves.add(new Pair<>(0, 5));
        moves.add(new Pair<>(6, 4)); moves.add(new Pair<>(2, 6));
        moves.add(new Pair<>(6, 2)); moves.add(new Pair<>(3, 6));
        moves.add(new Pair<>(4, 6)); moves.add(new Pair<>(7, 3));
        moves.add(new Pair<>(3, 7)); moves.add(new Pair<>(6, 3));
        moves.add(new Pair<>(0, 3)); moves.add(new Pair<>(0, 1));
        moves.add(new Pair<>(7, 1)); moves.add(new Pair<>(7, 2));
        moves.add(new Pair<>(7, 4)); moves.add(new Pair<>(1, 5));
        moves.add(new Pair<>(2, 7)); moves.add(new Pair<>(5, 6));
        moves.add(new Pair<>(4, 7)); moves.add(new Pair<>(1, 6));
        moves.add(new Pair<>(2, 0)); moves.add(new Pair<>(7, 5));
        moves.add(new Pair<>(7, 6)); moves.add(new Pair<>(3, 0));
        moves.add(new Pair<>(0, 7)); moves.add(new Pair<>(1, 0));
        moves.add(new Pair<>(0, 6)); moves.add(new Pair<>(5, 7));
        moves.add(new Pair<>(6, 1)); moves.add(new Pair<>(7, 0));
        moves.add(new Pair<>(6, 0)); moves.add(new Pair<>(7, 7));
        moves.add(new Pair<>(4, 0)); moves.add(new Pair<>(1, 7));
        moves.add(new Pair<>(0, 0)); moves.add(new Pair<>(1, 1));
        moves.add(new Pair<>(6, 7)); moves.add(new Pair<>(6, 6));
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", 1, game.winner);
    }


    // utility functions

    private int getTile(Reversi game, int r0, int c0) {
        return game.playground[r0][c0];
    }


    private Reversi setMoves(ArrayList<Pair<Integer, Integer>> moves) {
        Reversi game = new Reversi(gameInitBStarts);
        for (Pair<Integer, Integer> move  : moves) {
            Integer r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    private int[][] getEmptyPlayground() {
        int[][] empty = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = -1;
            }
        }
        return empty;
    }

    private int[][] getInitPlayground() {
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

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();

    @Test
    public void test() {
        Reversi game = rev;
        // TODO
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 4, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 4, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 4, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 5, 'import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class Reversi {

    int[][] playground;
    int leftB = 0;
    int leftW = 0;
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
            initTilesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!(line.length() == 2 && line.substring(1, 2).matches("[1-8]") &&  line.substring(0, 1).matches("[A-H]"))) {
                    System.out.println("Incorrect tile input");
                    return;
                }
                int r = Integer.parseInt(line.substring(1, 2));
                Alpha c = Alpha.valueOf(line.substring(0, 1));
                move(c, r);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Could not open game configuration file.");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file.");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        if (gameConfig.length != 3) {
            System.out.println("Game configuration must contain 3 lines.");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input.");
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
            try {
                for (int i = 1; i < 3; i++) {
                    String[] tiles = gameConfig[i].split(" ");
                    for (String tile : tiles) {
                        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[1-8]") &&  tile.substring(0, 1).matches("[A-H]"))) {
                            System.out.println("Incorrect tile input");
                            return;
                        }
                        int r = Integer.parseInt(tile.substring(1, 2)) - 1;
                        int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
                        playground[r][c] = players[i - 1];
                    }
                }
            } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
                System.out.println("Game configuration file is incorrect.");
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
    }

    void initTilesCount() {
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

    private void printPlayground() {
        String[] abc = "ABCDEFGH".split("");
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r <= 7; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < 8; c++) {
                switch (playground[r][c]) {
                    case 1: System.out.print("B "); break;
                    case 0: System.out.print("W "); break;
                    case -1: System.out.print("_ "); break;
                }
            }
            System.out.println();
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();

        if (!(r >= 0 && c >= 0 && r <= 7 && c < 8)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != -1) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = new ArrayList<>();
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
                tilesToFlip.add(new ArrayList<>(List.of(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (tilesToFlip.size() != 0) {
            tilesToFlip.add(new ArrayList<>(List.of(r, c)));
        }

        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> tile : tilesToFlip) {
            int tileR = tile.get(0);
            int tileC = tile.get(1);
            if (playground[tileR][tileC] == onTurn) break;
            if (playground[tileR][tileC] == -1) {
                playground[tileR][tileC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[tileR][tileC] = onTurn;
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
            printTilesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = 1;
            else if (getLeftW() > getLeftB()) winner = 0;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
                        toFLip.add(new ArrayList<>(List.of(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (toFLip.size() != 0) {
                    toFLip.add(new ArrayList<>(List.of(r, c)));
                }
                if (toFLip.size() == 0) continue;
                String rString = String.valueOf(r + 1);
                String cString = Alpha.values()[c].toString();
                tiles.add(cString.concat(rString));
            }
        }
        return tiles.size() != 0;
    }

    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("upload-dir/12345/game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Alpha.java', 5, 'public enum Alpha {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReversiTest.java', 5, 'import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameAllNum = new File(gameConfigDir + "game_all_num.txt").toPath();
    private Path gameAlmostComplete = new File(gameConfigDir + "game_almost_complete.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();


    // Alpha

    @Test
    public void testAlphaValueOf() {
        assertEquals("Value of Alpha A", Alpha.A, Alpha.valueOf("A"));
        assertEquals("Value of Alpha B", Alpha.B, Alpha.valueOf("B"));
        assertEquals("Value of Alpha C", Alpha.C, Alpha.valueOf("C"));
        assertEquals("Value of Alpha D", Alpha.D, Alpha.valueOf("D"));
        assertEquals("Value of Alpha E", Alpha.E, Alpha.valueOf("E"));
        assertEquals("Value of Alpha F", Alpha.F, Alpha.valueOf("F"));
        assertEquals("Value of Alpha G", Alpha.G, Alpha.valueOf("G"));
        assertEquals("Value of Alpha H", Alpha.H, Alpha.valueOf("H"));
    }


    // readGameConfig

    @Test
    public void testReadGameConfigInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigInitW() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigFourLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameFourLines);

        assertEquals(4, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("E4 D5", gameConfig[1]);
        assertEquals("D4 E5", gameConfig[2]);
        assertEquals("E4 D5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameNotExisting);

        String[] expectedGameConfig = new String[]{};
        assertArrayEquals(expectedGameConfig, gameConfig);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // initGame

    @Test
    public void testInitGameInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", 1, game.onTurn);
        assertEquals("init playground on initial game config", 1, getTile(game, Alpha.E, 4));
        assertEquals("init playground on initial game config", 1, getTile(game, Alpha.D, 5));
        assertEquals("init playground on initial game config", 0, getTile(game, Alpha.D, 4));
        assertEquals("init playground on initial game config", 0, getTile(game, Alpha.E, 5));
    }

    @Test
    public void testInitGameNoLines() {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOneLine() {
        String[] gameConfig = new String[] {"E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOnlyB() {
        String[] gameConfig = new String[] {"B", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void testInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("on turn player on initial game config", 1, game.onTurn);
        assertEquals("playground on initial game config", 0, getTile(game, Alpha.D, 4));
        assertEquals("playground on initial game config", 1, getTile(game, Alpha.E, 4));
        assertEquals("playground on initial game config", 1, getTile(game, Alpha.D, 5));
        assertEquals("playground on initial game config", 0, getTile(game, Alpha.E, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testOneLine() {
        Reversi game = new Reversi(gameOneLine);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testFourLines() {
        Reversi game = new Reversi(gameFourLines);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAllNum() {
        Reversi game = new Reversi(gameAllNum);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testAllAlpha() {
        Reversi game = new Reversi(gameAllAlpha);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(-1, game.onTurn);
        assertFalse(game.ended);
        assertEquals(-1, game.winner);
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("...", game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(gameComplete);

        assertFalse("...", game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E,5);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,9);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,1);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.C,4);

        assertEquals("check if flipped", 1, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", 1, getTile(game, Alpha.C, 4));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E, 6);

        assertEquals("check if flipped", 1, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", 1, getTile(game, Alpha.E, 6));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.F, 5);

        assertEquals("check if flipped", 1, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", 1, getTile(game, Alpha.F, 5));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.D, 3);

        assertEquals("check if flipped", 1, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", 1, getTile(game, Alpha.D, 3));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 1, getTile(game, Alpha.D, 6));
        assertEquals("check if flipped", 1, getTile(game, Alpha.C, 7));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", 0, getTile(game, Alpha.F, 6));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 1, getTile(game, Alpha.E, 3));
        assertEquals("check if flipped", 1, getTile(game, Alpha.F, 2));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", 0, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", 0, getTile(game, Alpha.C, 3));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", 0, getTile(game, Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", 0, getTile(game, Alpha.E, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(gameAlmostComplete);
        game.move(Alpha.G, 7);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", 1, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6)); moves.add(new Pair<>(Alpha.F, 4));
        moves.add(new Pair<>(Alpha.D, 3)); moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.C, 3)); moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.E, 3)); moves.add(new Pair<>(Alpha.C, 2));
        moves.add(new Pair<>(Alpha.B, 3)); moves.add(new Pair<>(Alpha.F, 5));
        moves.add(new Pair<>(Alpha.F, 3)); moves.add(new Pair<>(Alpha.D, 2));
        moves.add(new Pair<>(Alpha.E, 2)); moves.add(new Pair<>(Alpha.B, 4));
        moves.add(new Pair<>(Alpha.C, 5)); moves.add(new Pair<>(Alpha.F, 1));
        moves.add(new Pair<>(Alpha.A, 3)); moves.add(new Pair<>(Alpha.F, 2));
        moves.add(new Pair<>(Alpha.C, 6)); moves.add(new Pair<>(Alpha.F, 6));
        moves.add(new Pair<>(Alpha.G, 6)); moves.add(new Pair<>(Alpha.A, 5));
        moves.add(new Pair<>(Alpha.B, 5)); moves.add(new Pair<>(Alpha.A, 6));
        moves.add(new Pair<>(Alpha.G, 5)); moves.add(new Pair<>(Alpha.C, 7));
        moves.add(new Pair<>(Alpha.G, 3)); moves.add(new Pair<>(Alpha.D, 7));
        moves.add(new Pair<>(Alpha.E, 7)); moves.add(new Pair<>(Alpha.H, 4));
        moves.add(new Pair<>(Alpha.D, 8)); moves.add(new Pair<>(Alpha.G, 4));
        moves.add(new Pair<>(Alpha.A, 4)); moves.add(new Pair<>(Alpha.A, 2));
        moves.add(new Pair<>(Alpha.H, 2)); moves.add(new Pair<>(Alpha.H, 3));
        moves.add(new Pair<>(Alpha.H, 5)); moves.add(new Pair<>(Alpha.B, 6));
        moves.add(new Pair<>(Alpha.C, 8)); moves.add(new Pair<>(Alpha.F, 7));
        moves.add(new Pair<>(Alpha.E, 8)); moves.add(new Pair<>(Alpha.B, 7));
        moves.add(new Pair<>(Alpha.C, 1)); moves.add(new Pair<>(Alpha.H, 6));
        moves.add(new Pair<>(Alpha.H, 7)); moves.add(new Pair<>(Alpha.D, 1));
        moves.add(new Pair<>(Alpha.A, 8)); moves.add(new Pair<>(Alpha.B, 1));
        moves.add(new Pair<>(Alpha.A, 7)); moves.add(new Pair<>(Alpha.F, 8));
        moves.add(new Pair<>(Alpha.G, 2)); moves.add(new Pair<>(Alpha.H, 1));
        moves.add(new Pair<>(Alpha.G, 1)); moves.add(new Pair<>(Alpha.H, 8));
        moves.add(new Pair<>(Alpha.E, 1)); moves.add(new Pair<>(Alpha.B, 8));
        moves.add(new Pair<>(Alpha.A, 1)); moves.add(new Pair<>(Alpha.B, 2));
        moves.add(new Pair<>(Alpha.G, 8)); moves.add(new Pair<>(Alpha.G, 7));
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", 1, game.winner);
    }


    // utility functions

    private int getTile(Reversi game, Alpha c0, int r0) {
        return game.playground[r0-1][c0.getValue()];
    }


    private Reversi setMoves(ArrayList<Pair<Alpha, Integer>> moves) {
        Reversi game = new Reversi(gameInitBStarts);
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    private int[][] getEmptyPlayground() {
        int[][] empty = new int[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = -1;
            }
        }
        return empty;
    }

    private int[][] getInitPlayground() {
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
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 5, 'import org.junit.Test;

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();

    @Test
    public void test() {
        Reversi game = rev;
        // TODO
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 5, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 5, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 5, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 6, 'import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class Reversi {

    private static final int SIZE = 8;
    int[][] playground;
    int leftB = 0;
    int leftW = 0;
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
            initTilesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != -1) break;
                if ((line = reader.readLine()) == null) break;
                if (!(line.length() == 2 && line.substring(1, 2).matches("[1-8]") &&  line.substring(0, 1).matches("[A-H]"))) {
                    System.out.println("Incorrect tile input");
                    return;
                }
                int r = Integer.parseInt(line.substring(1, 2));
                Alpha c = Alpha.valueOf(line.substring(0, 1));
                move(c, r);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Could not open game configuration file.");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file.");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        if (gameConfig.length != 3) {
            System.out.println("Game configuration must contain 3 lines.");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input.");
                return;
            }
            if ("B".equals(gameConfig[0])) {
                onTurn = 1;
            } else if ("W".equals(gameConfig[0])) {
                onTurn = 0;
            }
            playground = new int[SIZE][SIZE];
            for (int r = 0; r < SIZE; r++) {
                for (int c = 0; c < SIZE; c++) {
                    playground[r][c] = -1;
                }
            }
            try {
                for (int i = 1; i < 3; i++) {
                    String[] tiles = gameConfig[i].split(" ");
                    for (String tile : tiles) {
                        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[1-8]") &&  tile.substring(0, 1).matches("[A-H]"))) {
                            System.out.println("Incorrect tile input");
                            return;
                        }
                        int r = Integer.parseInt(tile.substring(1, 2)) - 1;
                        int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
                        playground[r][c] = players[i - 1];
                    }
                }
            } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
                System.out.println("Game configuration file is incorrect.");
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
    }

    void initTilesCount() {
        try {
            for (int r = 0; r < SIZE; r++) {
                for (int c = 0; c < SIZE; c++) {
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

    private void printPlayground() {
        String[] abc = "ABCDEFGH".split("");
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r < SIZE; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < SIZE; c++) {
                switch (playground[r][c]) {
                    case 1: System.out.print("B "); break;
                    case 0: System.out.print("W "); break;
                    case -1: System.out.print("_ "); break;
                }
            }
            System.out.println();
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();

        if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != -1) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (winner != -1) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = new ArrayList<>();
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
            if (dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                tilesToFlip.add(new ArrayList<>(List.of(dirR, dirC)));
            }
        }

        playground[r][c] = -1;
        if (tilesToFlip.size() != 0) {
            tilesToFlip.add(new ArrayList<>(List.of(r, c)));
        }

        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> tile : tilesToFlip) {
            int tileR = tile.get(0);
            int tileC = tile.get(1);
            if (playground[tileR][tileC] == onTurn) break;
            if (playground[tileR][tileC] == -1) {
                playground[tileR][tileC] = onTurn;
                if (onTurn == 1) leftB++;
                else if (onTurn == 0) leftW++;
            } else {
                playground[tileR][tileC] = onTurn;
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
            printTilesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = 1;
            else if (getLeftW() > getLeftB()) winner = 0;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != -1) continue;
                ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
                    if (dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFLip.add(new ArrayList<>(List.of(dirR, dirC)));
                    }
                }

                playground[r][c] = -1;
                if (toFLip.size() != 0) {
                    toFLip.add(new ArrayList<>(List.of(r, c)));
                }
                if (toFLip.size() == 0) continue;
                String rString = String.valueOf(r + 1);
                String cString = Alpha.values()[c].toString();
                tiles.add(cString.concat(rString));
            }
        }
        return tiles.size() != 0;
    }

    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("upload-dir/12345/game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Alpha.java', 6, 'public enum Alpha {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReversiTest.java', 6, 'import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameAllNum = new File(gameConfigDir + "game_all_num.txt").toPath();
    private Path gameAlmostComplete = new File(gameConfigDir + "game_almost_complete.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();


    // Player

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }


    // Alpha

    @Test
    public void testAlphaValueOf() {
        assertEquals("Value of Alpha A", Alpha.A, Alpha.valueOf("A"));
        assertEquals("Value of Alpha B", Alpha.B, Alpha.valueOf("B"));
        assertEquals("Value of Alpha C", Alpha.C, Alpha.valueOf("C"));
        assertEquals("Value of Alpha D", Alpha.D, Alpha.valueOf("D"));
        assertEquals("Value of Alpha E", Alpha.E, Alpha.valueOf("E"));
        assertEquals("Value of Alpha F", Alpha.F, Alpha.valueOf("F"));
        assertEquals("Value of Alpha G", Alpha.G, Alpha.valueOf("G"));
        assertEquals("Value of Alpha H", Alpha.H, Alpha.valueOf("H"));
    }


    // readGameConfig

    @Test
    public void testReadGameConfigInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigInitW() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigFourLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameFourLines);

        assertEquals(4, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("E4 D5", gameConfig[1]);
        assertEquals("D4 E5", gameConfig[2]);
        assertEquals("E4 D5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameNotExisting);

        String[] expectedGameConfig = new String[]{};
        assertArrayEquals(expectedGameConfig, gameConfig);
    }

    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }

    // initGame

    @Test
    public void testInitGameInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test
    public void testInitGameNoLines() {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOneLine() {
        String[] gameConfig = new String[] {"E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOnlyB() {
        String[] gameConfig = new String[] {"B", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void testInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testOneLine() {
        Reversi game = new Reversi(gameOneLine);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFourLines() {
        Reversi game = new Reversi(gameFourLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAllNum() {
        Reversi game = new Reversi(gameAllNum);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(Player.B, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAllAlpha() {
        Reversi game = new Reversi(gameAllAlpha);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(Player.B, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("...", game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(gameComplete);

        assertFalse("...", game.areValidMoves());
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E,5);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,9);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,1);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.C,4);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E, 6);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 6));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.F, 5);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.D, 3);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 3));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 6));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 7));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.F, 6));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 3));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.C, 3));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", Player.W, getTile(game, Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", Player.W, getTile(game, Alpha.E, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(gameAlmostComplete);
        game.move(Alpha.G, 7);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6)); moves.add(new Pair<>(Alpha.F, 4));
        moves.add(new Pair<>(Alpha.D, 3)); moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.C, 3)); moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.E, 3)); moves.add(new Pair<>(Alpha.C, 2));
        moves.add(new Pair<>(Alpha.B, 3)); moves.add(new Pair<>(Alpha.F, 5));
        moves.add(new Pair<>(Alpha.F, 3)); moves.add(new Pair<>(Alpha.D, 2));
        moves.add(new Pair<>(Alpha.E, 2)); moves.add(new Pair<>(Alpha.B, 4));
        moves.add(new Pair<>(Alpha.C, 5)); moves.add(new Pair<>(Alpha.F, 1));
        moves.add(new Pair<>(Alpha.A, 3)); moves.add(new Pair<>(Alpha.F, 2));
        moves.add(new Pair<>(Alpha.C, 6)); moves.add(new Pair<>(Alpha.F, 6));
        moves.add(new Pair<>(Alpha.G, 6)); moves.add(new Pair<>(Alpha.A, 5));
        moves.add(new Pair<>(Alpha.B, 5)); moves.add(new Pair<>(Alpha.A, 6));
        moves.add(new Pair<>(Alpha.G, 5)); moves.add(new Pair<>(Alpha.C, 7));
        moves.add(new Pair<>(Alpha.G, 3)); moves.add(new Pair<>(Alpha.D, 7));
        moves.add(new Pair<>(Alpha.E, 7)); moves.add(new Pair<>(Alpha.H, 4));
        moves.add(new Pair<>(Alpha.D, 8)); moves.add(new Pair<>(Alpha.G, 4));
        moves.add(new Pair<>(Alpha.A, 4)); moves.add(new Pair<>(Alpha.A, 2));
        moves.add(new Pair<>(Alpha.H, 2)); moves.add(new Pair<>(Alpha.H, 3));
        moves.add(new Pair<>(Alpha.H, 5)); moves.add(new Pair<>(Alpha.B, 6));
        moves.add(new Pair<>(Alpha.C, 8)); moves.add(new Pair<>(Alpha.F, 7));
        moves.add(new Pair<>(Alpha.E, 8)); moves.add(new Pair<>(Alpha.B, 7));
        moves.add(new Pair<>(Alpha.C, 1)); moves.add(new Pair<>(Alpha.H, 6));
        moves.add(new Pair<>(Alpha.H, 7)); moves.add(new Pair<>(Alpha.D, 1));
        moves.add(new Pair<>(Alpha.A, 8)); moves.add(new Pair<>(Alpha.B, 1));
        moves.add(new Pair<>(Alpha.A, 7)); moves.add(new Pair<>(Alpha.F, 8));
        moves.add(new Pair<>(Alpha.G, 2)); moves.add(new Pair<>(Alpha.H, 1));
        moves.add(new Pair<>(Alpha.G, 1)); moves.add(new Pair<>(Alpha.H, 8));
        moves.add(new Pair<>(Alpha.E, 1)); moves.add(new Pair<>(Alpha.B, 8));
        moves.add(new Pair<>(Alpha.A, 1)); moves.add(new Pair<>(Alpha.B, 2));
        moves.add(new Pair<>(Alpha.G, 8)); moves.add(new Pair<>(Alpha.G, 7));
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // utility functions

    private Player getTile(Reversi game, Alpha c0, int r0) {
        return game.playground[r0-1][c0.getValue()];
    }


    private Reversi setMoves(ArrayList<Pair<Alpha, Integer>> moves) {
        Reversi game = new Reversi(gameInitBStarts);
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.playground = getEmptyPlayground();
        return rev;
    }

    private Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    private Player[][] getInitPlayground() {
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
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 6, 'import org.junit.Test;

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();

    @Test
    public void test() {
        Reversi game = rev;
        // TODO
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 6, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 6, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 6, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 7, 'import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class Reversi {

    private static final int SIZE = 8;
    Player[][] playground;
    int leftB = 0;
    int leftW = 0;
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
            initTilesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                if (!(line.length() == 2 && line.substring(1, 2).matches("[1-8]") &&  line.substring(0, 1).matches("[A-H]"))) {
                    System.out.println("Incorrect tile input");
                    return;
                }
                int r = Integer.parseInt(line.substring(1, 2));
                Alpha c = Alpha.valueOf(line.substring(0, 1));
                move(c, r);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Could not open game configuration file.");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file.");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        if (gameConfig.length != 3) {
            System.out.println("Game configuration must contain 3 lines.");
            return;
        }
        try {
            if (gameConfig[0] == null || ! gameConfig[0].matches("[B|W]")) {
                System.out.println("Incorrect player on turn input.");
                return;
            }
            onTurn = Player.valueOf(gameConfig[0]);
            playground = new Player[SIZE][SIZE];
            for (int r = 0; r < SIZE; r++) {
                for (int c = 0; c < SIZE; c++) {
                    playground[r][c] = Player.NONE;
                }
            }
            try {
                for (int i = 1; i < 3; i++) {
                    String[] tiles = gameConfig[i].split(" ");
                    for (String tile : tiles) {
                        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[1-8]") &&  tile.substring(0, 1).matches("[A-H]"))) {
                            System.out.println("Incorrect tile input");
                            return;
                        }
                        int r = Integer.parseInt(tile.substring(1, 2)) - 1;
                        int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
                        playground[r][c] = players[i - 1];
                    }
                }
            } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
                System.out.println("Game configuration file is incorrect.");
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
    }

    void initTilesCount() {
        try {
            for (int r = 0; r < SIZE; r++) {
                for (int c = 0; c < SIZE; c++) {
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

    private void printPlayground() {
        String[] abc = "ABCDEFGH".split("");
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r < SIZE; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < SIZE; c++) {
                switch (playground[r][c]) {
                    case B: System.out.print("B "); break;
                    case W: System.out.print("W "); break;
                    case NONE: System.out.print("_ "); break;
                }
            }
            System.out.println();
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();

        if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != Player.NONE) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (winner != Player.NONE) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = new ArrayList<>();
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
            if (dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE && playground[dirR][dirC] != opposite) continue;
            dirR += direction[0];
            dirC += direction[1];
            if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
            while (playground[dirR][dirC] == opposite) {
                dirR += direction[0];
                dirC += direction[1];
                if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) break;
            }
            if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
            if (playground[dirR][dirC] != onTurn) continue;
            while (true) {
                dirR -= direction[0];
                dirC -= direction[1];
                if (dirR == r && dirC == c) break;
                tilesToFlip.add(new ArrayList<>(List.of(dirR, dirC)));
            }
        }

        playground[r][c] = Player.NONE;
        if (tilesToFlip.size() != 0) {
            tilesToFlip.add(new ArrayList<>(List.of(r, c)));
        }
        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        for (List<Integer> tile : tilesToFlip) {
            int tileR = tile.get(0);
            int tileC = tile.get(1);
            if (playground[tileR][tileC] == onTurn) break;
            if (playground[tileR][tileC] == Player.NONE) {
                playground[tileR][tileC] = onTurn;
                if (onTurn == Player.B) leftB++;
                else if (onTurn == Player.W) leftW++;
            } else {
                playground[tileR][tileC] = onTurn;
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
            printTilesLeftCount();
            ended = true;
            if (getLeftB() > getLeftW()) winner = Player.B;
            else if (getLeftW() > getLeftB()) winner = Player.W;
        }
    }

    boolean areValidMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != Player.NONE) continue;
                ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
                    if (dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE && playground[dirR][dirC] != opposite) continue;
                    dirR += direction[0];
                    dirC += direction[1];
                    if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
                    while (playground[dirR][dirC] == opposite) {
                        dirR += direction[0];
                        dirC += direction[1];
                        if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) break;
                    }
                    if (!(dirR >= 0 && dirC >= 0 && dirR < SIZE && dirC < SIZE)) continue;
                    if (playground[dirR][dirC] != onTurn) continue;
                    while (true) {
                        dirR -= direction[0];
                        dirC -= direction[1];
                        if (dirR == r && dirC == c) break;
                        toFLip.add(new ArrayList<>(List.of(dirR, dirC)));
                    }
                }

                playground[r][c] = Player.NONE;
                if (toFLip.size() != 0) {
                    toFLip.add(new ArrayList<>(List.of(r, c)));
                }
                if (toFLip.size() == 0) continue;
                String rString = String.valueOf(r + 1);
                String cString = Alpha.values()[c].toString();
                tiles.add(cString.concat(rString));
            }
        }
        return tiles.size() != 0;
    }

    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("upload-dir/12345/game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Alpha.java', 7, 'public enum Alpha {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 7, 'public enum Player {
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReversiTest.java', 7, 'import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameAllNum = new File(gameConfigDir + "game_all_num.txt").toPath();
    private Path gameAlmostComplete = new File(gameConfigDir + "game_almost_complete.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();


    // Player

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }


    // Alpha

    @Test
    public void testAlphaValueOf() {
        assertEquals("Value of Alpha A", Alpha.A, Alpha.valueOf("A"));
        assertEquals("Value of Alpha B", Alpha.B, Alpha.valueOf("B"));
        assertEquals("Value of Alpha C", Alpha.C, Alpha.valueOf("C"));
        assertEquals("Value of Alpha D", Alpha.D, Alpha.valueOf("D"));
        assertEquals("Value of Alpha E", Alpha.E, Alpha.valueOf("E"));
        assertEquals("Value of Alpha F", Alpha.F, Alpha.valueOf("F"));
        assertEquals("Value of Alpha G", Alpha.G, Alpha.valueOf("G"));
        assertEquals("Value of Alpha H", Alpha.H, Alpha.valueOf("H"));
    }


    // readGameConfig

    @Test
    public void testReadGameConfigInitB() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigInitW() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigFourLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameFourLines);

        assertEquals(4, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("E4 D5", gameConfig[1]);
        assertEquals("D4 E5", gameConfig[2]);
        assertEquals("E4 D5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameNotExisting);

        String[] expectedGameConfig = new String[]{};
        assertArrayEquals(expectedGameConfig, gameConfig);
    }


    // isOnTurnInputCorrect

//    @Test
//    public void testIsOnTurnInputCorrectB() {
//        Reversi game = rev;
//
//        assertTrue("on turn value of config file: B", game.isOnTurnInputCorrect("B"));
//    }
//
//    @Test
//    public void testIsOnTurnInputCorrectW() {
//        Reversi game = rev;
//
//        assertTrue("on turn value of config file: W", game.isOnTurnInputCorrect("W"));
//    }
//
//    @Test
//    public void testIsOnTurnInputCorrectA() {
//        Reversi game = rev;
//
//        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("A"));
//    }
//
//    @Test
//    public void testIsOnTurnInputCorrectNONE() {
//        Reversi game = rev;
//
//        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect("NONE"));
//    }
//
//    @Test
//    public void testIsOnTurnInputCorrectnull() {
//        Reversi game = rev;
//
//        assertFalse("on turn value of config file: A", game.isOnTurnInputCorrect(null));
//    }


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
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // setTile

    @Test
    public void testSetTileA1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A1", Player.B);

        assertEquals("set player B on tile A1", Player.B, getTile(game, Alpha.A, 1));
    }

    @Test
    public void testSetTileAA() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("AA", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTile11() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("11", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTilea1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("a1", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTile1A() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("1A", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileI1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I1", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileA9() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A9", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileI9() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I9", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlaygroundInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[] {"one"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundIncorrectConfig() {
        String[] gameConfig = new String[] {"B", "AA BB", "CC DD"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGame

    @Test
    public void testInitGameInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test
    public void testInitGameNoLines() {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOneLine() {
        String[] gameConfig = new String[] {"E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOnlyB() {
        String[] gameConfig = new String[] {"B", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void testInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testOneLine() {
        Reversi game = new Reversi(gameOneLine);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFourLines() {
        Reversi game = new Reversi(gameFourLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAllNum() {
        Reversi game = new Reversi(gameAllNum);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(Player.B, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAllAlpha() {
        Reversi game = new Reversi(gameAllAlpha);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(Player.B, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }


    // isEmpty

//    @Test
//    public void testIsEmptyInit00() {
//        Reversi game = new Reversi(gameInitBStarts);
//
//        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
//    }
//
//    @Test
//    public void testIsEmptyInit33() {
//        Reversi game = new Reversi(gameInitBStarts);
//
//        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
//    }


    // isGameOver

//    @Test
//    public void testIsGameOverInit() {
//        Reversi game = new Reversi(gameInitBStarts);
//
//        assertFalse("is game over on init", game.isGameOver());
//    }
//
//    @Test
//    public void testIsGameOverOnEnd() {
//        Reversi game = new Reversi(gameComplete);
//        assertFalse("is game over on init", game.isGameOver());
//    }


    // getTilesToFlip

    @Test
    public void testGetTilesToFlipInit32() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(3, 2);
        ArrayList<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("tiles to flip on onit - (3, 2)", 2, tiles.size());
        assertEquals("...", expected.get(0).get(0), tiles.get(0).get(0));
        assertEquals("...", expected.get(0).get(1), tiles.get(0).get(1));
        assertEquals("...", expected.get(1).get(0), tiles.get(1).get(0));
        assertEquals("...", expected.get(1).get(1), tiles.get(1).get(1));
    }

    @Test
    public void testGetTilesToFlipInit00() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(0, 0);

        assertEquals("tiles to flip on onit - (0, 0)", 0, tiles.size());
    }


    // flipTiles

    @Test
    public void testFlipTiles() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = new ArrayList<>();
        tiles.add(Arrays.asList(3, 3));
        tiles.add(Arrays.asList(3, 2));
        game.flipTiles(tiles);

        assertEquals("...", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("...", Player.B, getTile(game, Alpha.D, 4));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMovesEmptyInit() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 4, tiles.size());
        assertEquals("valid moves", "D3", tiles.get(0));
        assertEquals("valid moves", "C4", tiles.get(1));
        assertEquals("valid moves", "F5", tiles.get(2));
        assertEquals("valid moves", "E6", tiles.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = getRevWithPlayground();
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 0, tiles.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("...", game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(gameComplete);

        assertFalse("...", game.areValidMoves());
    }


    // swapPlayerOnTurn

//    @Test
//    public void testSwapPlayerOnTurnBtoW() {
//        Reversi game = new Reversi(gameInitBStarts);
//        game.swapPlayerOnTurn();
//
//        assertEquals("...", Player.W, game.onTurn);
//    }
//
//    @Test
//    public void testSwapPlayerOnTurnWtoB() {
//        Reversi game = new Reversi(gameInitWStarts);
//        game.swapPlayerOnTurn();
//
//        assertEquals("...", Player.B, game.onTurn);
//    }

    // endGame

    @Test
    public void testEndGame() {
        Reversi game = new Reversi(gameComplete);
        game.endGame();

        assertTrue("...", game.ended);
        assertEquals("...", Player.B, game.winner);
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E,5);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,9);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,1);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.C,4);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E, 6);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 6));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.F, 5);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.D, 3);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 3));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 6));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 7));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.F, 6));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 3));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.C, 3));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", Player.W, getTile(game, Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", Player.W, getTile(game, Alpha.E, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(gameAlmostComplete);
        game.move(Alpha.G, 7);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6)); moves.add(new Pair<>(Alpha.F, 4));
        moves.add(new Pair<>(Alpha.D, 3)); moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.C, 3)); moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.E, 3)); moves.add(new Pair<>(Alpha.C, 2));
        moves.add(new Pair<>(Alpha.B, 3)); moves.add(new Pair<>(Alpha.F, 5));
        moves.add(new Pair<>(Alpha.F, 3)); moves.add(new Pair<>(Alpha.D, 2));
        moves.add(new Pair<>(Alpha.E, 2)); moves.add(new Pair<>(Alpha.B, 4));
        moves.add(new Pair<>(Alpha.C, 5)); moves.add(new Pair<>(Alpha.F, 1));
        moves.add(new Pair<>(Alpha.A, 3)); moves.add(new Pair<>(Alpha.F, 2));
        moves.add(new Pair<>(Alpha.C, 6)); moves.add(new Pair<>(Alpha.F, 6));
        moves.add(new Pair<>(Alpha.G, 6)); moves.add(new Pair<>(Alpha.A, 5));
        moves.add(new Pair<>(Alpha.B, 5)); moves.add(new Pair<>(Alpha.A, 6));
        moves.add(new Pair<>(Alpha.G, 5)); moves.add(new Pair<>(Alpha.C, 7));
        moves.add(new Pair<>(Alpha.G, 3)); moves.add(new Pair<>(Alpha.D, 7));
        moves.add(new Pair<>(Alpha.E, 7)); moves.add(new Pair<>(Alpha.H, 4));
        moves.add(new Pair<>(Alpha.D, 8)); moves.add(new Pair<>(Alpha.G, 4));
        moves.add(new Pair<>(Alpha.A, 4)); moves.add(new Pair<>(Alpha.A, 2));
        moves.add(new Pair<>(Alpha.H, 2)); moves.add(new Pair<>(Alpha.H, 3));
        moves.add(new Pair<>(Alpha.H, 5)); moves.add(new Pair<>(Alpha.B, 6));
        moves.add(new Pair<>(Alpha.C, 8)); moves.add(new Pair<>(Alpha.F, 7));
        moves.add(new Pair<>(Alpha.E, 8)); moves.add(new Pair<>(Alpha.B, 7));
        moves.add(new Pair<>(Alpha.C, 1)); moves.add(new Pair<>(Alpha.H, 6));
        moves.add(new Pair<>(Alpha.H, 7)); moves.add(new Pair<>(Alpha.D, 1));
        moves.add(new Pair<>(Alpha.A, 8)); moves.add(new Pair<>(Alpha.B, 1));
        moves.add(new Pair<>(Alpha.A, 7)); moves.add(new Pair<>(Alpha.F, 8));
        moves.add(new Pair<>(Alpha.G, 2)); moves.add(new Pair<>(Alpha.H, 1));
        moves.add(new Pair<>(Alpha.G, 1)); moves.add(new Pair<>(Alpha.H, 8));
        moves.add(new Pair<>(Alpha.E, 1)); moves.add(new Pair<>(Alpha.B, 8));
        moves.add(new Pair<>(Alpha.A, 1)); moves.add(new Pair<>(Alpha.B, 2));
        moves.add(new Pair<>(Alpha.G, 8)); moves.add(new Pair<>(Alpha.G, 7));
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // execute

    @Test
    public void testExecute() {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("C4");

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecuteA1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("A1");

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testFinishGame() {
        Reversi game = new Reversi(gameAlmostComplete);
        game.execute("G7");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // utility functions

    private Player getTile(Reversi game, Alpha c0, int r0) {
        return game.playground[r0-1][c0.getValue()];
    }

    private Reversi setMoves(ArrayList<Pair<Alpha, Integer>> moves) {
        Reversi game = new Reversi(gameInitBStarts);
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.createPlayground();
        return rev;
    }

    private Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    private Player[][] getInitPlayground() {
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

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();

    @Test
    public void test() {
        Reversi game = rev;
        // TODO
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 7, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 7, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 7, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 8, 'import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class Reversi {

    private static final int SIZE = 8;
    Player[][] playground;
    int leftB = 0;
    int leftW = 0;
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
            initTilesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Could not open game configuration file.");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file.");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        if (gameConfig.length != 3) {
            System.out.println("Game configuration must contain 3 lines.");
            return;
        }
        try {
            setOnTurn(gameConfig[0]);
            createPlayground();
            fillPlayground(gameConfig);
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
    }

    void setOnTurn(String player) {
        if (player == null || ! player.matches("[B|W]")) {
            System.out.println("Incorrect player on turn input.");
            return;
        }
        onTurn = Player.valueOf(player);
    }

    void createPlayground() {
        playground = new Player[SIZE][SIZE];
        for (int r = 0; r < SIZE; r++) {
            for (int c = 0; c < SIZE; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) {
        try {
            for (int i = 1; i < 3; i++) {
                String[] tiles = gameConfig[i].split(" ");
                for (String tile : tiles) {
                    setTile(tile, players[i - 1]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect.");
        }
    }

    void setTile(String tile, Player player) {
        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[1-8]") &&  tile.substring(0, 1).matches("[A-H]"))) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(1, 2)) - 1;
        int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
        playground[r][c] = player;
    }

    void initTilesCount() {
        try {
            for (int r = 0; r < SIZE; r++) {
                for (int c = 0; c < SIZE; c++) {
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

    private void printPlayground() {
        String[] abc = "ABCDEFGH".split("");
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r < SIZE; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < SIZE; c++) {
                switch (playground[r][c]) {
                    case B: System.out.print("B "); break;
                    case W: System.out.print("W "); break;
                    case NONE: System.out.print("_ "); break;
                }
            }
            System.out.println();
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void execute(String tile) {
        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[1-8]") &&  tile.substring(0, 1).matches("[A-H]"))) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(1, 2));
        Alpha c = Alpha.valueOf(tile.substring(0, 1));
        move(c, r);
    }

    void move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();

        if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (playground[r][c] != Player.NONE) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (winner != Player.NONE) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = getTilesToFlip(r, c);
        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        flipTiles(tilesToFlip);

        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
        if (! areValidMoves()) endGame();
    }

    ArrayList<List<Integer>> getTilesToFlip(int r0, int c0) {
        ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
            if (r >= 0 && c >= 0 && r < SIZE && c < SIZE && playground[r][c] != opposite) continue;
            r += direction[0];
            c += direction[1];
            if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) continue;
            while (playground[r][c] == opposite) {
                r += direction[0];
                c += direction[1];
                if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) break;
            }
            if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) continue;
            if (playground[r][c] != onTurn) continue;
            while (true) {
                r -= direction[0];
                c -= direction[1];
                if (r == r0 && c == c0) break;
                toFLip.add(new ArrayList<>(List.of(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (toFLip.size() != 0) {
            toFLip.add(new ArrayList<>(List.of(r0, c0)));
        }
        return toFLip;
    }

    void flipTiles(List<List<Integer>> tiles) {
        for (List<Integer> tile : tiles) {
            int r = tile.get(0);
            int c = tile.get(1);
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
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getTilesToFlip(r,c).size() == 0) continue;
                String rString = String.valueOf(r + 1);
                String cString = Alpha.values()[c].toString();
                tiles.add(cString.concat(rString));
            }
        }
        return tiles;
    }

    void endGame() {
        printTilesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }


    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("upload-dir/12345/game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Alpha.java', 8, 'public enum Alpha {
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
VALUES ('private_test', 'ReversiTest.java', 8, 'import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameAllNum = new File(gameConfigDir + "game_all_num.txt").toPath();
    private Path gameAlmostComplete = new File(gameConfigDir + "game_almost_complete.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();


    // Player

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }


    // Alpha

    @Test
    public void testAlphaValueOf() {
        assertEquals("Value of Alpha A", Alpha.A, Alpha.valueOf("A"));
        assertEquals("Value of Alpha B", Alpha.B, Alpha.valueOf("B"));
        assertEquals("Value of Alpha C", Alpha.C, Alpha.valueOf("C"));
        assertEquals("Value of Alpha D", Alpha.D, Alpha.valueOf("D"));
        assertEquals("Value of Alpha E", Alpha.E, Alpha.valueOf("E"));
        assertEquals("Value of Alpha F", Alpha.F, Alpha.valueOf("F"));
        assertEquals("Value of Alpha G", Alpha.G, Alpha.valueOf("G"));
        assertEquals("Value of Alpha H", Alpha.H, Alpha.valueOf("H"));
    }


    // readGameConfig

    @Test
    public void testReadGameConfigInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigInitW() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigFourLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameFourLines);

        assertEquals(4, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("E4 D5", gameConfig[1]);
        assertEquals("D4 E5", gameConfig[2]);
        assertEquals("E4 D5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameNotExisting);

        String[] expectedGameConfig = new String[]{};
        assertArrayEquals(expectedGameConfig, gameConfig);
    }


    // isOnTurnInputCorrect

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
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // isTileInputCorrect

//    @Test
//    public void testTileInputA1() {
//        Reversi game = new Reversi(gameInitBStarts);
//        assertTrue("tile input: A1", game.isTileInputCorrect("A1"));
//    }
//
//    @Test
//    public void testTileInputAA() {
//        Reversi game = new Reversi(gameInitBStarts);
//        assertFalse("tile input: AA", game.isTileInputCorrect("a1"));
//    }
//
//    @Test
//    public void testTileInput11() {
//        Reversi game = new Reversi(gameInitBStarts);
//        assertFalse("tile input: AA", game.isTileInputCorrect("a1"));
//    }
//
//    @Test
//    public void testTileInputa1()  {
//        Reversi game = new Reversi(gameInitBStarts);
//        assertFalse("tile input: a1", game.isTileInputCorrect("a1"));
//    }
//
//    @Test
//    public void testTileInput1A() {
//        Reversi game = new Reversi(gameInitBStarts);
//        assertFalse("tile input: 1A", game.isTileInputCorrect("1A"));
//    }
//
//    @Test
//    public void testTileInputI1() {
//        Reversi game = new Reversi(gameInitBStarts);
//        assertFalse("tile input: I1", game.isTileInputCorrect("I1"));
//    }
//
//    @Test
//    public void testTileInputA9() {
//        Reversi game = new Reversi(gameInitBStarts);
//        assertFalse("tile input: A9", game.isTileInputCorrect("A9"));
//    }
//
//    @Test
//    public void testTileInputI9() {
//        Reversi game = new Reversi(gameInitBStarts);
//        assertFalse("tile input: I9", game.isTileInputCorrect("I9"));
//    }


    // setTile

    @Test
    public void testSetTileA1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A1", Player.B);

        assertEquals("set player B on tile A1", Player.B, getTile(game, Alpha.A, 1));
    }

    @Test
    public void testSetTileAA() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("AA", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTile11() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("11", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTilea1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("a1", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTile1A() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("1A", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileI1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I1", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileA9() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A9", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileI9() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I9", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlaygroundInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[] {"one"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundIncorrectConfig() {
        String[] gameConfig = new String[] {"B", "AA BB", "CC DD"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGame

    @Test
    public void testInitGameInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test
    public void testInitGameNoLines() {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOneLine() {
        String[] gameConfig = new String[] {"E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOnlyB() {
        String[] gameConfig = new String[] {"B", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void testInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testOneLine() {
        Reversi game = new Reversi(gameOneLine);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFourLines() {
        Reversi game = new Reversi(gameFourLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAllNum() {
        Reversi game = new Reversi(gameAllNum);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(Player.B, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAllAlpha() {
        Reversi game = new Reversi(gameAllAlpha);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(Player.B, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }


    // printPlayground

//    @Test
//    public void testPrintPlaygroundInit() {
//        /// ?
//    }


    // printTilesLeftCount

//    @Test
//    public void testprintTilesLeftCountInit() {
//        /// ?
//    }


    // isWithinPlayground

//    @Test
//    public void testIsWithinPlayground00() {
//        Reversi game = rev;
//
//        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
//    }
//
//    @Test
//    public void testIsWithinPlayground77() {
//        Reversi game = rev;
//
//        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
//    }
//
//    @Test
//    public void testIsWithinPlaygroundNegR() {
//        Reversi game = rev;
//
//        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
//    }
//
//    @Test
//    public void testIsWithinPlaygroundNegC() {
//        Reversi game = rev;
//
//        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
//    }
//
//    @Test
//    public void testIsWithinPlaygroundLargeR() {
//        Reversi game = rev;
//
//        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
//    }
//
//    @Test
//    public void testIsWithinPlaygroundLargeC() {
//        Reversi game = rev;
//
//        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
//    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() {
        Reversi game = new Reversi(gameInitBStarts);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() {
        Reversi game = new Reversi(gameComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // getTilesToFlip

    @Test
    public void testGetTilesToFlipInit32() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(3, 2);
        ArrayList<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("tiles to flip on onit - (3, 2)", 2, tiles.size());
        assertEquals("...", expected.get(0).get(0), tiles.get(0).get(0));
        assertEquals("...", expected.get(0).get(1), tiles.get(0).get(1));
        assertEquals("...", expected.get(1).get(0), tiles.get(1).get(0));
        assertEquals("...", expected.get(1).get(1), tiles.get(1).get(1));
    }

    @Test
    public void testGetTilesToFlipInit00() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(0, 0);

        assertEquals("tiles to flip on onit - (0, 0)", 0, tiles.size());
    }


    // flipTiles

    @Test
    public void testFlipTiles() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = new ArrayList<>();
        tiles.add(Arrays.asList(3, 3));
        tiles.add(Arrays.asList(3, 2));
        game.flipTiles(tiles);

        assertEquals("...", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("...", Player.B, getTile(game, Alpha.D, 4));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMovesEmptyInit() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 4, tiles.size());
        assertEquals("valid moves", "D3", tiles.get(0));
        assertEquals("valid moves", "C4", tiles.get(1));
        assertEquals("valid moves", "F5", tiles.get(2));
        assertEquals("valid moves", "E6", tiles.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = getRevWithPlayground();
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 0, tiles.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("...", game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(gameComplete);

        assertFalse("...", game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() {
        Reversi game = new Reversi(gameInitBStarts);
        game.swapPlayerOnTurn();

        assertEquals("...", Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() {
        Reversi game = new Reversi(gameInitWStarts);
        game.swapPlayerOnTurn();

        assertEquals("...", Player.B, game.onTurn);
    }

    // endGame

    @Test
    public void testEndGame() {
        Reversi game = new Reversi(gameComplete);
        game.endGame();

        assertTrue("...", game.ended);
        assertEquals("...", Player.B, game.winner);
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E,5);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,9);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,1);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.C,4);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E, 6);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 6));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.F, 5);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.D, 3);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 3));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 6));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 7));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.F, 6));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 3));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.C, 3));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", Player.W, getTile(game, Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", Player.W, getTile(game, Alpha.E, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(gameAlmostComplete);
        game.move(Alpha.G, 7);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6)); moves.add(new Pair<>(Alpha.F, 4));
        moves.add(new Pair<>(Alpha.D, 3)); moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.C, 3)); moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.E, 3)); moves.add(new Pair<>(Alpha.C, 2));
        moves.add(new Pair<>(Alpha.B, 3)); moves.add(new Pair<>(Alpha.F, 5));
        moves.add(new Pair<>(Alpha.F, 3)); moves.add(new Pair<>(Alpha.D, 2));
        moves.add(new Pair<>(Alpha.E, 2)); moves.add(new Pair<>(Alpha.B, 4));
        moves.add(new Pair<>(Alpha.C, 5)); moves.add(new Pair<>(Alpha.F, 1));
        moves.add(new Pair<>(Alpha.A, 3)); moves.add(new Pair<>(Alpha.F, 2));
        moves.add(new Pair<>(Alpha.C, 6)); moves.add(new Pair<>(Alpha.F, 6));
        moves.add(new Pair<>(Alpha.G, 6)); moves.add(new Pair<>(Alpha.A, 5));
        moves.add(new Pair<>(Alpha.B, 5)); moves.add(new Pair<>(Alpha.A, 6));
        moves.add(new Pair<>(Alpha.G, 5)); moves.add(new Pair<>(Alpha.C, 7));
        moves.add(new Pair<>(Alpha.G, 3)); moves.add(new Pair<>(Alpha.D, 7));
        moves.add(new Pair<>(Alpha.E, 7)); moves.add(new Pair<>(Alpha.H, 4));
        moves.add(new Pair<>(Alpha.D, 8)); moves.add(new Pair<>(Alpha.G, 4));
        moves.add(new Pair<>(Alpha.A, 4)); moves.add(new Pair<>(Alpha.A, 2));
        moves.add(new Pair<>(Alpha.H, 2)); moves.add(new Pair<>(Alpha.H, 3));
        moves.add(new Pair<>(Alpha.H, 5)); moves.add(new Pair<>(Alpha.B, 6));
        moves.add(new Pair<>(Alpha.C, 8)); moves.add(new Pair<>(Alpha.F, 7));
        moves.add(new Pair<>(Alpha.E, 8)); moves.add(new Pair<>(Alpha.B, 7));
        moves.add(new Pair<>(Alpha.C, 1)); moves.add(new Pair<>(Alpha.H, 6));
        moves.add(new Pair<>(Alpha.H, 7)); moves.add(new Pair<>(Alpha.D, 1));
        moves.add(new Pair<>(Alpha.A, 8)); moves.add(new Pair<>(Alpha.B, 1));
        moves.add(new Pair<>(Alpha.A, 7)); moves.add(new Pair<>(Alpha.F, 8));
        moves.add(new Pair<>(Alpha.G, 2)); moves.add(new Pair<>(Alpha.H, 1));
        moves.add(new Pair<>(Alpha.G, 1)); moves.add(new Pair<>(Alpha.H, 8));
        moves.add(new Pair<>(Alpha.E, 1)); moves.add(new Pair<>(Alpha.B, 8));
        moves.add(new Pair<>(Alpha.A, 1)); moves.add(new Pair<>(Alpha.B, 2));
        moves.add(new Pair<>(Alpha.G, 8)); moves.add(new Pair<>(Alpha.G, 7));
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // execute

    @Test
    public void testExecute() {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("C4");

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecuteA1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("A1");

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testFinishGame() {
        Reversi game = new Reversi(gameAlmostComplete);
        game.execute("G7");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // utility functions

    private Player getTile(Reversi game, Alpha c0, int r0) {
        return game.playground[r0-1][c0.getValue()];
    }


    private Reversi setMoves(ArrayList<Pair<Alpha, Integer>> moves) {
        Reversi game = new Reversi(gameInitBStarts);
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.createPlayground();
        return rev;
    }

    private Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    private Player[][] getInitPlayground() {
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

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();

    @Test
    public void test() {
        Reversi game = rev;
        // TODO
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 8, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 8, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 8, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 9, 'import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class Reversi {

    private static final int SIZE = 8;
    Player[][] playground;
    int leftB = 0;
    int leftW = 0;
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
            initTilesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Could not open game configuration file.");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file.");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        if (gameConfig.length != 3) {
            System.out.println("Game configuration must contain 3 lines.");
            return;
        }
        try {
            setOnTurn(gameConfig[0]);
            createPlayground();
            fillPlayground(gameConfig);
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
    }

    void setOnTurn(String player) {
        if (!isOnTurnInputCorrect(player)) {
            System.out.println("Incorrect player on turn input.");
            return;
        }
        onTurn = Player.valueOf(player);
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    void createPlayground() {
        playground = new Player[SIZE][SIZE];
        for (int r = 0; r < SIZE; r++) {
            for (int c = 0; c < SIZE; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) {
        try {
            for (int i = 1; i < 3; i++) {
                String[] tiles = gameConfig[i].split(" ");
                for (String tile : tiles) {
                    setTile(tile, players[i - 1]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect.");
        }
    }

    void setTile(String tile, Player player) {
        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[1-8]") &&  tile.substring(0, 1).matches("[A-H]"))) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(1, 2)) - 1;
        int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
        playground[r][c] = player;
    }

    void initTilesCount() {
        try {
            for (int r = 0; r < SIZE; r++) {
                for (int c = 0; c < SIZE; c++) {
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

    private void printPlayground() {
        String[] abc = "ABCDEFGH".split("");
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r < SIZE; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < SIZE; c++) {
                switch (playground[r][c]) {
                    case B: System.out.print("B "); break;
                    case W: System.out.print("W "); break;
                    case NONE: System.out.print("_ "); break;
                }
            }
            System.out.println();
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void execute(String tile) {
        if (!(tile.length() == 2 && tile.substring(1, 2).matches("[1-8]") &&  tile.substring(0, 1).matches("[A-H]"))) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(1, 2));
        Alpha c = Alpha.valueOf(tile.substring(0, 1));
        move(c, r);
    }

//    boolean isTileInputCorrect(String tile) {
//        if (tile.length() != 2) return false;
//        String r = tile.substring(1, 2);
//        String c = tile.substring(0, 1);
//        return r.matches("[1-8]") && c.matches("[A-H]");
//    }

    void move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();

        if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = getTilesToFlip(r, c);
        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        flipTiles(tilesToFlip);

        swapPlayerOnTurn();
        if (! areValidMoves()) endGame();
    }

//    boolean isWithinPlayground(int r, int c) {
//        return r >= 0 && c >= 0 && r < SIZE && c < SIZE;
//    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    ArrayList<List<Integer>> getTilesToFlip(int r0, int c0) {
        ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
            if (r >= 0 && c >= 0 && r < SIZE && c < SIZE && playground[r][c] != opposite) continue;
            r += direction[0];
            c += direction[1];
            if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) continue;
            while (playground[r][c] == opposite) {
                r += direction[0];
                c += direction[1];
                if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) break;
            }
            if (!(r >= 0 && c >= 0 && r < SIZE && c < SIZE)) continue;
            if (playground[r][c] != onTurn) continue;
            while (true) {
                r -= direction[0];
                c -= direction[1];
                if (r == r0 && c == c0) break;
                toFLip.add(new ArrayList<>(List.of(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (toFLip.size() != 0) {
            toFLip.add(new ArrayList<>(List.of(r0, c0)));
        }
        return toFLip;
    }

    void flipTiles(List<List<Integer>> tiles) {
        for (List<Integer> tile : tiles) {
            int r = tile.get(0);
            int c = tile.get(1);
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
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getTilesToFlip(r,c).size() == 0) continue;
                String rString = String.valueOf(r + 1);
                String cString = Alpha.values()[c].toString();
                tiles.add(cString.concat(rString));
            }
        }
        return tiles;
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    void endGame() {
        printTilesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }


    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("upload-dir/12345/game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Alpha.java', 9, 'public enum Alpha {
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
VALUES ('private_test', 'ReversiTest.java', 9, 'import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameAllNum = new File(gameConfigDir + "game_all_num.txt").toPath();
    private Path gameAlmostComplete = new File(gameConfigDir + "game_almost_complete.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();


    // Player

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }


    // Alpha

    @Test
    public void testAlphaValueOf() {
        assertEquals("Value of Alpha A", Alpha.A, Alpha.valueOf("A"));
        assertEquals("Value of Alpha B", Alpha.B, Alpha.valueOf("B"));
        assertEquals("Value of Alpha C", Alpha.C, Alpha.valueOf("C"));
        assertEquals("Value of Alpha D", Alpha.D, Alpha.valueOf("D"));
        assertEquals("Value of Alpha E", Alpha.E, Alpha.valueOf("E"));
        assertEquals("Value of Alpha F", Alpha.F, Alpha.valueOf("F"));
        assertEquals("Value of Alpha G", Alpha.G, Alpha.valueOf("G"));
        assertEquals("Value of Alpha H", Alpha.H, Alpha.valueOf("H"));
    }


    // readGameConfig

    @Test
    public void testReadGameConfigInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigInitW() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigFourLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameFourLines);

        assertEquals(4, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("E4 D5", gameConfig[1]);
        assertEquals("D4 E5", gameConfig[2]);
        assertEquals("E4 D5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameNotExisting);

        String[] expectedGameConfig = new String[]{};
        assertArrayEquals(expectedGameConfig, gameConfig);
    }


    // isOnTurnInputCorrect

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
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // isTileInputCorrect

    @Test
    public void testTileInputA1() {
        Reversi game = new Reversi(gameInitBStarts);
        assertTrue("tile input: A1", game.isTileInputCorrect("A1"));
    }

    @Test
    public void testTileInputAA() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: AA", game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInput11() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: AA", game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInputa1()  {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: a1", game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInput1A() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: 1A", game.isTileInputCorrect("1A"));
    }

    @Test
    public void testTileInputI1() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: I1", game.isTileInputCorrect("I1"));
    }

    @Test
    public void testTileInputA9() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: A9", game.isTileInputCorrect("A9"));
    }

    @Test
    public void testTileInputI9() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: I9", game.isTileInputCorrect("I9"));
    }


    // setTile

    @Test
    public void testSetTileA1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A1", Player.B);

        assertEquals("set player B on tile A1", Player.B, getTile(game, Alpha.A, 1));
    }

    @Test
    public void testSetTileAA() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("AA", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTile11() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("11", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTilea1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("a1", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTile1A() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("1A", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileI1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I1", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileA9() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A9", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileI9() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I9", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlaygroundInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[] {"one"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundIncorrectConfig() {
        String[] gameConfig = new String[] {"B", "AA BB", "CC DD"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGame

    @Test
    public void testInitGameInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test
    public void testInitGameNoLines() {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOneLine() {
        String[] gameConfig = new String[] {"E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOnlyB() {
        String[] gameConfig = new String[] {"B", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void testInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testOneLine() {
        Reversi game = new Reversi(gameOneLine);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFourLines() {
        Reversi game = new Reversi(gameFourLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAllNum() {
        Reversi game = new Reversi(gameAllNum);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(Player.B, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAllAlpha() {
        Reversi game = new Reversi(gameAllAlpha);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(Player.B, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }


    // printPlayground

//    @Test
//    public void testPrintPlaygroundInit() {
//        /// ?
//    }


    // printTilesLeftCount

//    @Test
//    public void testprintTilesLeftCountInit() {
//        /// ?
//    }


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = rev;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = rev;

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNegR() {
        Reversi game = rev;

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlaygroundNegC() {
        Reversi game = rev;

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlaygroundLargeR() {
        Reversi game = rev;

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlaygroundLargeC() {
        Reversi game = rev;

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() {
        Reversi game = new Reversi(gameInitBStarts);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() {
        Reversi game = new Reversi(gameComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // getTilesToFlip

    @Test
    public void testGetTilesToFlipInit32() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(3, 2);
        ArrayList<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("tiles to flip on onit - (3, 2)", 2, tiles.size());
        assertEquals("...", expected.get(0).get(0), tiles.get(0).get(0));
        assertEquals("...", expected.get(0).get(1), tiles.get(0).get(1));
        assertEquals("...", expected.get(1).get(0), tiles.get(1).get(0));
        assertEquals("...", expected.get(1).get(1), tiles.get(1).get(1));
    }

    @Test
    public void testGetTilesToFlipInit00() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(0, 0);

        assertEquals("tiles to flip on onit - (0, 0)", 0, tiles.size());
    }


    // flipTiles

    @Test
    public void testFlipTiles() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = new ArrayList<>();
        tiles.add(Arrays.asList(3, 3));
        tiles.add(Arrays.asList(3, 2));
        game.flipTiles(tiles);

        assertEquals("...", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("...", Player.B, getTile(game, Alpha.D, 4));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMovesEmptyInit() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 4, tiles.size());
        assertEquals("valid moves", "D3", tiles.get(0));
        assertEquals("valid moves", "C4", tiles.get(1));
        assertEquals("valid moves", "F5", tiles.get(2));
        assertEquals("valid moves", "E6", tiles.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = getRevWithPlayground();
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 0, tiles.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("...", game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(gameComplete);

        assertFalse("...", game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() {
        Reversi game = new Reversi(gameInitBStarts);
        game.swapPlayerOnTurn();

        assertEquals("...", Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() {
        Reversi game = new Reversi(gameInitWStarts);
        game.swapPlayerOnTurn();

        assertEquals("...", Player.B, game.onTurn);
    }

    // endGame

    @Test
    public void testEndGame() {
        Reversi game = new Reversi(gameComplete);
        game.endGame();

        assertTrue("...", game.ended);
        assertEquals("...", Player.B, game.winner);
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E,5);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,9);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,1);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.C,4);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E, 6);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 6));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.F, 5);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.D, 3);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 3));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 6));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 7));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.F, 6));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 3));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.C, 3));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", Player.W, getTile(game, Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", Player.W, getTile(game, Alpha.E, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(gameAlmostComplete);
        game.move(Alpha.G, 7);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6)); moves.add(new Pair<>(Alpha.F, 4));
        moves.add(new Pair<>(Alpha.D, 3)); moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.C, 3)); moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.E, 3)); moves.add(new Pair<>(Alpha.C, 2));
        moves.add(new Pair<>(Alpha.B, 3)); moves.add(new Pair<>(Alpha.F, 5));
        moves.add(new Pair<>(Alpha.F, 3)); moves.add(new Pair<>(Alpha.D, 2));
        moves.add(new Pair<>(Alpha.E, 2)); moves.add(new Pair<>(Alpha.B, 4));
        moves.add(new Pair<>(Alpha.C, 5)); moves.add(new Pair<>(Alpha.F, 1));
        moves.add(new Pair<>(Alpha.A, 3)); moves.add(new Pair<>(Alpha.F, 2));
        moves.add(new Pair<>(Alpha.C, 6)); moves.add(new Pair<>(Alpha.F, 6));
        moves.add(new Pair<>(Alpha.G, 6)); moves.add(new Pair<>(Alpha.A, 5));
        moves.add(new Pair<>(Alpha.B, 5)); moves.add(new Pair<>(Alpha.A, 6));
        moves.add(new Pair<>(Alpha.G, 5)); moves.add(new Pair<>(Alpha.C, 7));
        moves.add(new Pair<>(Alpha.G, 3)); moves.add(new Pair<>(Alpha.D, 7));
        moves.add(new Pair<>(Alpha.E, 7)); moves.add(new Pair<>(Alpha.H, 4));
        moves.add(new Pair<>(Alpha.D, 8)); moves.add(new Pair<>(Alpha.G, 4));
        moves.add(new Pair<>(Alpha.A, 4)); moves.add(new Pair<>(Alpha.A, 2));
        moves.add(new Pair<>(Alpha.H, 2)); moves.add(new Pair<>(Alpha.H, 3));
        moves.add(new Pair<>(Alpha.H, 5)); moves.add(new Pair<>(Alpha.B, 6));
        moves.add(new Pair<>(Alpha.C, 8)); moves.add(new Pair<>(Alpha.F, 7));
        moves.add(new Pair<>(Alpha.E, 8)); moves.add(new Pair<>(Alpha.B, 7));
        moves.add(new Pair<>(Alpha.C, 1)); moves.add(new Pair<>(Alpha.H, 6));
        moves.add(new Pair<>(Alpha.H, 7)); moves.add(new Pair<>(Alpha.D, 1));
        moves.add(new Pair<>(Alpha.A, 8)); moves.add(new Pair<>(Alpha.B, 1));
        moves.add(new Pair<>(Alpha.A, 7)); moves.add(new Pair<>(Alpha.F, 8));
        moves.add(new Pair<>(Alpha.G, 2)); moves.add(new Pair<>(Alpha.H, 1));
        moves.add(new Pair<>(Alpha.G, 1)); moves.add(new Pair<>(Alpha.H, 8));
        moves.add(new Pair<>(Alpha.E, 1)); moves.add(new Pair<>(Alpha.B, 8));
        moves.add(new Pair<>(Alpha.A, 1)); moves.add(new Pair<>(Alpha.B, 2));
        moves.add(new Pair<>(Alpha.G, 8)); moves.add(new Pair<>(Alpha.G, 7));
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // execute

    @Test
    public void testExecute() {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("C4");

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecuteA1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("A1");

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testExecuteFinishGame() {
        Reversi game = new Reversi(gameAlmostComplete);
        game.execute("G7");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // utility functions

    private Player getTile(Reversi game, Alpha c0, int r0) {
        return game.playground[r0-1][c0.getValue()];
    }


    private Reversi setMoves(ArrayList<Pair<Alpha, Integer>> moves) {
        Reversi game = new Reversi(gameInitBStarts);
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.createPlayground();
        return rev;
    }

    private Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    private Player[][] getInitPlayground() {
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
VALUES ('public_test', 'ReversiTest.java', 9, 'import org.junit.Test;

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();

    @Test
    public void test() {
        Reversi game = rev;
        // TODO
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 9, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 9, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 9, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 10, 'import java.io.*;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.*;

public class Reversi {

    private static final int SIZE = 8;
    Player[][] playground;
    int leftB = 0;
    int leftW = 0;
    //    private HashMap<Player, Integer> left = new HashMap<>() {{ put(Player.B, 0); put(Player.W, 0); }};
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
            initTilesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Could not open game configuration file.");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file.");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        if (gameConfig.length != 3) {
            System.out.println("Game configuration must contain 3 lines.");
            return;
        }
        try {
            setOnTurn(gameConfig[0]);
            createPlayground();
            fillPlayground(gameConfig);
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
    }

    void setOnTurn(String player) {
        if (!isOnTurnInputCorrect(player)) {
            System.out.println("Incorrect player on turn input.");
            return;
        }
        onTurn = Player.valueOf(player);
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    void createPlayground() {
        playground = new Player[SIZE][SIZE];
        for (int r = 0; r < SIZE; r++) {
            for (int c = 0; c < SIZE; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) {
        try {
            for (int i = 1; i < 3; i++) {
                String[] tiles = gameConfig[i].split(" ");
                for (String tile : tiles) {
                    setTile(tile, players[i - 1]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect.");
        }
    }

    void setTile(String tile, Player player) {
        if (!isTileInputCorrect(tile)) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(1, 2)) - 1;
        int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
        playground[r][c] = player;
    }

    void initTilesCount() {
        try {
            for (int r = 0; r < SIZE; r++) {
                for (int c = 0; c < SIZE; c++) {
                    if (playground[r][c] == Player.B) {
                        leftB++;
//                        left.put(Player.B, left.get(Player.B) + 1);
                    } else if (playground[r][c] == Player.W) {
                        leftW++;
//                        left.put(Player.W, left.get(Player.W) + 1);
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            System.out.println("Playground  is not valid" + e.getMessage());
        }
    }

    private void printPlayground() {
        String[] abc = "ABCDEFGH".split("");
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r < SIZE; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < SIZE; c++) {
                switch (playground[r][c]) {
                    case B: System.out.print("B "); break;
                    case W: System.out.print("W "); break;
                    case NONE: System.out.print("_ "); break;
                }
            }
            System.out.println();
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return leftB;
    }

    int getLeftW() {
        return leftW;
    }

    void execute(String tile) {
        if (!isTileInputCorrect(tile)) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(1, 2));
        Alpha c = Alpha.valueOf(tile.substring(0, 1));
        move(c, r);
    }

    boolean isTileInputCorrect(String tile) {
        if (tile.length() != 2) return false;
        String r = tile.substring(1, 2);
        String c = tile.substring(0, 1);
        return r.matches("[1-8]") && c.matches("[A-H]");
    }

    void move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();

        if (!(isWithinPlayground(r, c))) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = getTilesToFlip(r, c);
        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        flipTiles(tilesToFlip);

        swapPlayerOnTurn();
        if (! areValidMoves()) endGame();
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < SIZE && c < SIZE;
    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    ArrayList<List<Integer>> getTilesToFlip(int r0, int c0) {
        ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
                toFLip.add(new ArrayList<>(List.of(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (toFLip.size() != 0) {
            toFLip.add(new ArrayList<>(List.of(r0, c0)));
        }
        return toFLip;
    }

    void flipTiles(List<List<Integer>> tiles) {
        for (List<Integer> tile : tiles) {
            int r = tile.get(0);
            int c = tile.get(1);
            if (playground[r][c] == onTurn) break; // debugging [4]
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
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getTilesToFlip(r,c).size() == 0) continue;
                String rString = String.valueOf(r + 1);
                String cString = Alpha.values()[c].toString();
                tiles.add(cString.concat(rString));
            }
        }
        return tiles;
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    void endGame() {
        printTilesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }


    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("./game_config_num/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Alpha.java', 10, 'public enum Alpha {
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
VALUES ('private_test', 'ReversiTest.java', 10, 'import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameAllNum = new File(gameConfigDir + "game_all_num.txt").toPath();
    private Path gameAlmostComplete = new File(gameConfigDir + "game_almost_complete.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();


    // Player

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }


    // Alpha

    @Test
    public void testAlphaValueOf() {
        assertEquals("Value of Alpha A", Alpha.A, Alpha.valueOf("A"));
        assertEquals("Value of Alpha B", Alpha.B, Alpha.valueOf("B"));
        assertEquals("Value of Alpha C", Alpha.C, Alpha.valueOf("C"));
        assertEquals("Value of Alpha D", Alpha.D, Alpha.valueOf("D"));
        assertEquals("Value of Alpha E", Alpha.E, Alpha.valueOf("E"));
        assertEquals("Value of Alpha F", Alpha.F, Alpha.valueOf("F"));
        assertEquals("Value of Alpha G", Alpha.G, Alpha.valueOf("G"));
        assertEquals("Value of Alpha H", Alpha.H, Alpha.valueOf("H"));
    }


    // readGameConfig

    @Test
    public void testReadGameConfigInit() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigInitW() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigFourLines() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameFourLines);

        assertEquals(4, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("E4 D5", gameConfig[1]);
        assertEquals("D4 E5", gameConfig[2]);
        assertEquals("E4 D5", gameConfig[3]);
    }

    @Test
    public void testReadGameConfigNotExisting() {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameNotExisting);

        String[] expectedGameConfig = new String[]{};
        assertArrayEquals(expectedGameConfig, gameConfig);
    }


    // isOnTurnInputCorrect

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
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // isTileInputCorrect

    @Test
    public void testTileInputA1() {
        Reversi game = new Reversi(gameInitBStarts);
        assertTrue("tile input: A1", game.isTileInputCorrect("A1"));
    }

    @Test
    public void testTileInputAA() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: AA", game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInput11() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: AA", game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInputa1()  {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: a1", game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInput1A() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: 1A", game.isTileInputCorrect("1A"));
    }

    @Test
    public void testTileInputI1() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: I1", game.isTileInputCorrect("I1"));
    }

    @Test
    public void testTileInputA9() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: A9", game.isTileInputCorrect("A9"));
    }

    @Test
    public void testTileInputI9() {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse("tile input: I9", game.isTileInputCorrect("I9"));
    }


    // setTile

    @Test
    public void testSetTileA1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A1", Player.B);

        assertEquals("set player B on tile A1", Player.B, getTile(game, Alpha.A, 1));
    }

    @Test
    public void testSetTileAA() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("AA", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTile11() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("11", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTilea1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("a1", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTile1A() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("1A", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileI1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I1", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileA9() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A9", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }

    @Test
    public void testSetTileI9() {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I9", Player.B);

        Player[][] expectedPlayground = getInitPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
        assertEquals(Player.B, game.onTurn);
    }


    // fillPlayground

    @Test
    public void testFillPlaygroundInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test
    public void testFillPlaygroundConfigLen1() {
        String[] gameConfig = new String[] {"one"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundNull() {
        Reversi game = getRevWithPlayground();
        game.fillPlayground(null);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }

    @Test
    public void testFillPlaygroundIncorrectConfig() {
        String[] gameConfig = new String[] {"B", "AA BB", "CC DD"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        Player[][] expectedPlayground = getEmptyPlayground();
        assertArrayEquals(expectedPlayground, game.playground);
    }


    // initGame

    @Test
    public void testInitGameInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test
    public void testInitGameNoLines() {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOneLine() {
        String[] gameConfig = new String[] {"E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameFourLines() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameNull() {
        Reversi game = rev;
        game.initGame(null);

        assertArrayEquals(null, game.playground);
    }

    @Test
    public void testInitGameOnlyB() {
        String[] gameConfig = new String[] {"B", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertArrayEquals(null, game.playground);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void testInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testEmpty() {
        Reversi game = new Reversi(gameEmpty);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testOneLine() {
        Reversi game = new Reversi(gameOneLine);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testFourLines() {
        Reversi game = new Reversi(gameFourLines);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAllNum() {
        Reversi game = new Reversi(gameAllNum);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(Player.B, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testAllAlpha() {
        Reversi game = new Reversi(gameAllAlpha);

        assertArrayEquals(getEmptyPlayground(), game.playground);
        assertEquals(Player.B, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }

    @Test
    public void testNoOnTurn() {
        Reversi game = new Reversi(gameNoOnTurn);

        assertArrayEquals(null, game.playground);
        assertEquals(Player.NONE, game.onTurn);
        assertFalse(game.ended);
        assertEquals(Player.NONE, game.winner);
    }


    // printPlayground

//    @Test
//    public void testPrintPlaygroundInit() {
//        /// ?
//    }


    // printTilesLeftCount

//    @Test
//    public void testprintTilesLeftCountInit() {
//        /// ?
//    }


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = rev;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = rev;

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNegR() {
        Reversi game = rev;

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlaygroundNegC() {
        Reversi game = rev;

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlaygroundLargeR() {
        Reversi game = rev;

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlaygroundLargeC() {
        Reversi game = rev;

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() {
        Reversi game = new Reversi(gameInitBStarts);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() {
        Reversi game = new Reversi(gameComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // getTilesToFlip

    @Test
    public void testGetTilesToFlipInit32() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(3, 2);
        ArrayList<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("tiles to flip on onit - (3, 2)", 2, tiles.size());
        assertEquals("...", expected.get(0).get(0), tiles.get(0).get(0));
        assertEquals("...", expected.get(0).get(1), tiles.get(0).get(1));
        assertEquals("...", expected.get(1).get(0), tiles.get(1).get(0));
        assertEquals("...", expected.get(1).get(1), tiles.get(1).get(1));
    }

    @Test
    public void testGetTilesToFlipInit00() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(0, 0);

        assertEquals("tiles to flip on onit - (0, 0)", 0, tiles.size());
    }


    // flipTiles

    @Test
    public void testFlipTiles() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = new ArrayList<>();
        tiles.add(Arrays.asList(3, 3));
        tiles.add(Arrays.asList(3, 2));
        game.flipTiles(tiles);

        assertEquals("...", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("...", Player.B, getTile(game, Alpha.D, 4));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMovesEmptyInit() {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 4, tiles.size());
        assertEquals("valid moves", "D3", tiles.get(0));
        assertEquals("valid moves", "C4", tiles.get(1));
        assertEquals("valid moves", "F5", tiles.get(2));
        assertEquals("valid moves", "E6", tiles.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = getRevWithPlayground();
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 0, tiles.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("...", game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() {
        Reversi game = new Reversi(gameComplete);

        assertFalse("...", game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() {
        Reversi game = new Reversi(gameInitBStarts);
        game.swapPlayerOnTurn();

        assertEquals("...", Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() {
        Reversi game = new Reversi(gameInitWStarts);
        game.swapPlayerOnTurn();

        assertEquals("...", Player.B, game.onTurn);
    }

    // endGame

    @Test
    public void testEndGame() {
        Reversi game = new Reversi(gameComplete);
        game.endGame();

        assertTrue("...", game.ended);
        assertEquals("...", Player.B, game.winner);
    }


    // move

    @Test
    public void testMoveOnNotEmpty() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E,5);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,9);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,1);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.C,4);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E, 6);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 6));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.F, 5);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.D, 3);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 3));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 6));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 7));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.F, 6));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 3));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.C, 3));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", Player.W, getTile(game, Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", Player.W, getTile(game, Alpha.E, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() {
        Reversi game = new Reversi(gameAlmostComplete);
        game.move(Alpha.G, 7);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }

    @Test
    public void testMovesCompleteGame() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6)); moves.add(new Pair<>(Alpha.F, 4));
        moves.add(new Pair<>(Alpha.D, 3)); moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.C, 3)); moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.E, 3)); moves.add(new Pair<>(Alpha.C, 2));
        moves.add(new Pair<>(Alpha.B, 3)); moves.add(new Pair<>(Alpha.F, 5));
        moves.add(new Pair<>(Alpha.F, 3)); moves.add(new Pair<>(Alpha.D, 2));
        moves.add(new Pair<>(Alpha.E, 2)); moves.add(new Pair<>(Alpha.B, 4));
        moves.add(new Pair<>(Alpha.C, 5)); moves.add(new Pair<>(Alpha.F, 1));
        moves.add(new Pair<>(Alpha.A, 3)); moves.add(new Pair<>(Alpha.F, 2));
        moves.add(new Pair<>(Alpha.C, 6)); moves.add(new Pair<>(Alpha.F, 6));
        moves.add(new Pair<>(Alpha.G, 6)); moves.add(new Pair<>(Alpha.A, 5));
        moves.add(new Pair<>(Alpha.B, 5)); moves.add(new Pair<>(Alpha.A, 6));
        moves.add(new Pair<>(Alpha.G, 5)); moves.add(new Pair<>(Alpha.C, 7));
        moves.add(new Pair<>(Alpha.G, 3)); moves.add(new Pair<>(Alpha.D, 7));
        moves.add(new Pair<>(Alpha.E, 7)); moves.add(new Pair<>(Alpha.H, 4));
        moves.add(new Pair<>(Alpha.D, 8)); moves.add(new Pair<>(Alpha.G, 4));
        moves.add(new Pair<>(Alpha.A, 4)); moves.add(new Pair<>(Alpha.A, 2));
        moves.add(new Pair<>(Alpha.H, 2)); moves.add(new Pair<>(Alpha.H, 3));
        moves.add(new Pair<>(Alpha.H, 5)); moves.add(new Pair<>(Alpha.B, 6));
        moves.add(new Pair<>(Alpha.C, 8)); moves.add(new Pair<>(Alpha.F, 7));
        moves.add(new Pair<>(Alpha.E, 8)); moves.add(new Pair<>(Alpha.B, 7));
        moves.add(new Pair<>(Alpha.C, 1)); moves.add(new Pair<>(Alpha.H, 6));
        moves.add(new Pair<>(Alpha.H, 7)); moves.add(new Pair<>(Alpha.D, 1));
        moves.add(new Pair<>(Alpha.A, 8)); moves.add(new Pair<>(Alpha.B, 1));
        moves.add(new Pair<>(Alpha.A, 7)); moves.add(new Pair<>(Alpha.F, 8));
        moves.add(new Pair<>(Alpha.G, 2)); moves.add(new Pair<>(Alpha.H, 1));
        moves.add(new Pair<>(Alpha.G, 1)); moves.add(new Pair<>(Alpha.H, 8));
        moves.add(new Pair<>(Alpha.E, 1)); moves.add(new Pair<>(Alpha.B, 8));
        moves.add(new Pair<>(Alpha.A, 1)); moves.add(new Pair<>(Alpha.B, 2));
        moves.add(new Pair<>(Alpha.G, 8)); moves.add(new Pair<>(Alpha.G, 7));
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // execute

    @Test
    public void testExecute() {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("C4");

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecuteA1() {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("A1");

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testFinishGame() {
        Reversi game = new Reversi(gameAlmostComplete);
        game.execute("G7");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // utility functions

    private Player getTile(Reversi game, Alpha c0, int r0) {
        return game.playground[r0-1][c0.getValue()];
    }


    private Reversi setMoves(ArrayList<Pair<Alpha, Integer>> moves) {
        Reversi game = new Reversi(gameInitBStarts);
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.createPlayground();
        return rev;
    }

    private Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    private Player[][] getInitPlayground() {
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

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();

    @Test
    public void test() {
        Reversi game = rev;
        // TODO
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 10, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 10, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 10, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 11, 'import java.io.*;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.*;

class Reversi {

    private static final int SIZE = 8;
    Player[][] playground;
    private HashMap<Player, Integer> left = new HashMap<>() {{ put(Player.B, 0); put(Player.W, 0); }};
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
            initTilesCount();
        } catch (Exception e) {
            ended = true;
            System.out.println(e.getMessage());
        }
    }

    private void run() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                reader.close();
            }
        } catch (Exception e) {
            System.out.println("IO exception occurred on reading input: " + e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) {
        String[] gameConfig = new String[] {};
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            System.out.println("Could not open game configuration file.");
        } catch (IOException e) {
            System.out.println("Could not read game configuration file.");
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) {
        if (gameConfig == null) {
            System.out.println("Game configuration is null");
            return;
        }
        if (gameConfig.length != 3) {
            System.out.println("Game configuration must contain 3 lines.");
            return;
        }
        try {
            setOnTurn(gameConfig[0]);
            createPlayground();
            fillPlayground(gameConfig);
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration is incorrect.");
        }
    }

    void setOnTurn(String player) {
        if (!isOnTurnInputCorrect(player)) {
            System.out.println("Incorrect player on turn input.");
            return;
        }
        onTurn = Player.valueOf(player);
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    void createPlayground() {
        playground = new Player[SIZE][SIZE];
        for (int r = 0; r < SIZE; r++) {
            for (int c = 0; c < SIZE; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) {
        try {
            for (int i = 1; i < 3; i++) {
                String[] tiles = gameConfig[i].split(" ");
                for (String tile : tiles) {
                    setTile(tile, players[i - 1]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            System.out.println("Game configuration file is incorrect.");
        }
    }

    void setTile(String tile, Player player) {
        if (!isTileInputCorrect(tile)) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(1, 2)) - 1;
        int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
        playground[r][c] = player;
    }

    void initTilesCount() {
        try {
            for (int r = 0; r < SIZE; r++) {
                for (int c = 0; c < SIZE; c++) {
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

    private void printPlayground() {
        String[] abc = "ABCDEFGH".split("");
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r < SIZE; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < SIZE; c++) {
                switch (playground[r][c]) {
                    case B: System.out.print("B "); break;
                    case W: System.out.print("W "); break;
                    case NONE: System.out.print("_ "); break;
                }
            }
            System.out.println();
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return left.get(Player.B);
    }

    int getLeftW() {
        return left.get(Player.W);
    }

    void execute(String tile) {
        if (!isTileInputCorrect(tile)) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(1, 2));
        Alpha c = Alpha.valueOf(tile.substring(0, 1));
        move(c, r);
    }

    boolean isTileInputCorrect(String tile) {
        if (tile.length() != 2) return false;
        String r = tile.substring(1, 2);
        String c = tile.substring(0, 1);
        return r.matches("[1-8]") && c.matches("[A-H]");
    }

    void move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();

        if (!(isWithinPlayground(r, c))) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = getTilesToFlip(r, c);
        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        flipTiles(tilesToFlip);

        swapPlayerOnTurn();
        if (! areValidMoves()) endGame();
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < SIZE && c < SIZE;
    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    ArrayList<List<Integer>> getTilesToFlip(int r0, int c0) {
        ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
                toFLip.add(new ArrayList<>(List.of(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (toFLip.size() != 0) {
            toFLip.add(new ArrayList<>(List.of(r0, c0)));
        }
        return toFLip;
    }

    void flipTiles(ArrayList<List<Integer>> tiles) {
        tiles.forEach(tile -> {
            Player previous = playground[tile.get(0)][tile.get(1)];
            playground[tile.get(0)][tile.get(1)] = onTurn;
            if (previous == Player.NONE) {
                left.put(onTurn, left.get(onTurn) + 1);
            } else if (previous != onTurn) {
                left.put(previous, left.get(previous) - 1);
                left.put(onTurn, left.get(onTurn) + 1);
            }
        });
    }

    boolean areValidMoves() {
        int movesNum = getPossibleMoves().size();
        return movesNum != 0;
    }

    ArrayList<String> getPossibleMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getTilesToFlip(r,c).size() == 0) continue;
                String rString = String.valueOf(r + 1);
                String cString = Alpha.values()[c].toString();
                tiles.add(cString.concat(rString));
            }
        }
        return tiles;
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    void endGame() {
        printTilesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }


    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("upload-dir/12345/game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev = new Reversi(gameFilePath);
        rev.run();

    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Alpha.java', 11, 'public enum Alpha {
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

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReversiTest.java', 11, 'import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameAllNum = new File(gameConfigDir + "game_all_num.txt").toPath();
    private Path gameAlmostComplete = new File(gameConfigDir + "game_almost_complete.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();


    // Player

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }


    // Alpha

    @Test
    public void testAlphaValueOf() {
        assertEquals("Value of Alpha A", Alpha.A, Alpha.valueOf("A"));
        assertEquals("Value of Alpha B", Alpha.B, Alpha.valueOf("B"));
        assertEquals("Value of Alpha C", Alpha.C, Alpha.valueOf("C"));
        assertEquals("Value of Alpha D", Alpha.D, Alpha.valueOf("D"));
        assertEquals("Value of Alpha E", Alpha.E, Alpha.valueOf("E"));
        assertEquals("Value of Alpha F", Alpha.F, Alpha.valueOf("F"));
        assertEquals("Value of Alpha G", Alpha.G, Alpha.valueOf("G"));
        assertEquals("Value of Alpha H", Alpha.H, Alpha.valueOf("H"));
    }


    // readGameConfig

    @Test
    public void testReadGameConfigInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigInitW() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigFourLines() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameFourLines);

        assertEquals(4, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("E4 D5", gameConfig[1]);
        assertEquals("D4 E5", gameConfig[2]);
        assertEquals("E4 D5", gameConfig[3]);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testReadGameConfigNotExisting() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        game.readGameConfig(gameNotExisting);
    }


    // isOnTurnInputCorrect

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

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetOnTurnA() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        game.setOnTurn("A");
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetOnTurnNone() throws IncorrectGameConfigFileException {
        Reversi game = rev;

        game.setOnTurn("set player on turn: NONE");
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetOnTurnnull() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setOnTurn(null);

        assertEquals(Player.NONE, game.onTurn);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // isTileInputCorrect

    @Test
    public void testTileInputA1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertTrue(game.isTileInputCorrect("A1"));
    }

    @Test
    public void testTileInputAA() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInput11() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInputa1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInput1A() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("1A"));
    }

    @Test
    public void testTileInputI1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("I1"));
    }

    @Test
    public void testTileInputA9() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("A9"));
    }

    @Test
    public void testTileInputI9() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("I9"));
    }


    // setTile

    @Test
    public void testSetTileA1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A1", Player.B);

        assertEquals(Player.B, getTile(game, Alpha.A, 1));
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTileAA() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("AA", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTile11() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("11", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTilea1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("a1", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTile1A() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("1A", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTileI1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I1", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTileA9() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A9", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTileI9() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I9", Player.B);
    }


    // fillPlayground

    @Test
    public void testFillPlaygroundInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testFillPlaygroundConfigLen1() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"one"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testFillPlaygroundNull() throws IncorrectGameConfigFileException {
        Reversi game = getRevWithPlayground();
        game.fillPlayground(null);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testFillPlaygroundIncorrectConfig() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "AA BB", "CC DD"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);
    }


    // initGame

    @Test
    public void testInitGameInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitGameNoLines() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitGameOneLine() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitGameFourLines() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitGameNull() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.initGame(null);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitGameOnlyB() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitTilesCountNullPlayground() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.initTilesCount();
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitTilesCountInvalidPlaygroundSize() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.playground = getSmallPlayground();
        game.initTilesCount();
    }


    // getLeftB

    @Test
    public void testGetLeftB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void testInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testEmpty() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameEmpty);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testOneLine() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameOneLine);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testFourLines() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameFourLines);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testAllNum() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameAllNum);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testAllAlpha() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameAllAlpha);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testNoOnTurn() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameNoOnTurn);
    }


    // printPlayground

//    @Test
//    public void testPrintPlaygroundInit() {
//        /// ?
//    }


    // printTilesLeftCount

//    @Test
//    public void testprintTilesLeftCountInit() {
//        /// ?
//    }


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = rev;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = rev;

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNegR() {
        Reversi game = rev;

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlaygroundNegC() {
        Reversi game = rev;

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlaygroundLargeR() {
        Reversi game = rev;

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlaygroundLargeC() {
        Reversi game = rev;

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // getTilesToFlip

    @Test
    public void testGetTilesToFlipInit32() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(3, 2);
        ArrayList<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("tiles to flip on onit - (3, 2)", 2, tiles.size());
        assertEquals("...", expected.get(0).get(0), tiles.get(0).get(0));
        assertEquals("...", expected.get(0).get(1), tiles.get(0).get(1));
        assertEquals("...", expected.get(1).get(0), tiles.get(1).get(0));
        assertEquals("...", expected.get(1).get(1), tiles.get(1).get(1));
    }

    @Test
    public void testGetTilesToFlipInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(0, 0);

        assertEquals("tiles to flip on onit - (0, 0)", 0, tiles.size());
    }


    // flipTiles

    @Test
    public void testFlipTiles() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = new ArrayList<>();
        tiles.add(Arrays.asList(3, 3));
        tiles.add(Arrays.asList(3, 2));
        game.flipTiles(tiles);

        assertEquals("...", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("...", Player.B, getTile(game, Alpha.D, 4));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMovesEmptyInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 4, tiles.size());
        assertEquals("valid moves", "D3", tiles.get(0));
        assertEquals("valid moves", "C4", tiles.get(1));
        assertEquals("valid moves", "F5", tiles.get(2));
        assertEquals("valid moves", "E6", tiles.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = getRevWithPlayground();
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 0, tiles.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("...", game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameComplete);

        assertFalse("...", game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW()  throws IncorrectGameConfigFileException{
        Reversi game = new Reversi(gameInitBStarts);
        game.swapPlayerOnTurn();

        assertEquals("...", Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitWStarts);
        game.swapPlayerOnTurn();

        assertEquals("...", Player.B, game.onTurn);
    }

    // endGame

    @Test
    public void testEndGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameComplete);
        game.endGame();

        assertTrue("...", game.ended);
        assertEquals("...", Player.B, game.winner);
    }


    // move

    @Test
    public void testMoveOnNotEmpty() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E,5);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsBelow() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,9);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOutOfBoundsAbove() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,0);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveOnNotAdjacent() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,1);

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testMoveFlipRight() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.C,4);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E, 6);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 6));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.F, 5);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.D, 3);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 3));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() throws IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 6));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 7));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() throws IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.F, 6));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() throws IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 3));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() throws IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.C, 3));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() throws IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", Player.W, getTile(game, Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", Player.W, getTile(game, Alpha.E, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameAlmostComplete);
        game.move(Alpha.G, 7);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }

    @Test
    public void testMovesCompleteGame() throws IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6)); moves.add(new Pair<>(Alpha.F, 4));
        moves.add(new Pair<>(Alpha.D, 3)); moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.C, 3)); moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.E, 3)); moves.add(new Pair<>(Alpha.C, 2));
        moves.add(new Pair<>(Alpha.B, 3)); moves.add(new Pair<>(Alpha.F, 5));
        moves.add(new Pair<>(Alpha.F, 3)); moves.add(new Pair<>(Alpha.D, 2));
        moves.add(new Pair<>(Alpha.E, 2)); moves.add(new Pair<>(Alpha.B, 4));
        moves.add(new Pair<>(Alpha.C, 5)); moves.add(new Pair<>(Alpha.F, 1));
        moves.add(new Pair<>(Alpha.A, 3)); moves.add(new Pair<>(Alpha.F, 2));
        moves.add(new Pair<>(Alpha.C, 6)); moves.add(new Pair<>(Alpha.F, 6));
        moves.add(new Pair<>(Alpha.G, 6)); moves.add(new Pair<>(Alpha.A, 5));
        moves.add(new Pair<>(Alpha.B, 5)); moves.add(new Pair<>(Alpha.A, 6));
        moves.add(new Pair<>(Alpha.G, 5)); moves.add(new Pair<>(Alpha.C, 7));
        moves.add(new Pair<>(Alpha.G, 3)); moves.add(new Pair<>(Alpha.D, 7));
        moves.add(new Pair<>(Alpha.E, 7)); moves.add(new Pair<>(Alpha.H, 4));
        moves.add(new Pair<>(Alpha.D, 8)); moves.add(new Pair<>(Alpha.G, 4));
        moves.add(new Pair<>(Alpha.A, 4)); moves.add(new Pair<>(Alpha.A, 2));
        moves.add(new Pair<>(Alpha.H, 2)); moves.add(new Pair<>(Alpha.H, 3));
        moves.add(new Pair<>(Alpha.H, 5)); moves.add(new Pair<>(Alpha.B, 6));
        moves.add(new Pair<>(Alpha.C, 8)); moves.add(new Pair<>(Alpha.F, 7));
        moves.add(new Pair<>(Alpha.E, 8)); moves.add(new Pair<>(Alpha.B, 7));
        moves.add(new Pair<>(Alpha.C, 1)); moves.add(new Pair<>(Alpha.H, 6));
        moves.add(new Pair<>(Alpha.H, 7)); moves.add(new Pair<>(Alpha.D, 1));
        moves.add(new Pair<>(Alpha.A, 8)); moves.add(new Pair<>(Alpha.B, 1));
        moves.add(new Pair<>(Alpha.A, 7)); moves.add(new Pair<>(Alpha.F, 8));
        moves.add(new Pair<>(Alpha.G, 2)); moves.add(new Pair<>(Alpha.H, 1));
        moves.add(new Pair<>(Alpha.G, 1)); moves.add(new Pair<>(Alpha.H, 8));
        moves.add(new Pair<>(Alpha.E, 1)); moves.add(new Pair<>(Alpha.B, 8));
        moves.add(new Pair<>(Alpha.A, 1)); moves.add(new Pair<>(Alpha.B, 2));
        moves.add(new Pair<>(Alpha.G, 8)); moves.add(new Pair<>(Alpha.G, 7));
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // execute

    @Test
    public void testExecute() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("C4");

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testExecuteA1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("A1");

        assertArrayEquals("check if didn''t change", getInitPlayground(), game.playground);
    }

    @Test
    public void testFinishGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameAlmostComplete);
        game.execute("G7");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // utility functions

    private Player getTile(Reversi game, Alpha c0, int r0) {
        return game.playground[r0-1][c0.getValue()];
    }


    private Reversi setMoves(ArrayList<Pair<Alpha, Integer>> moves) throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) throws IncorrectGameConfigFileException {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.createPlayground();
        return rev;
    }

    private Player[][] getEmptyPlayground() {
        Player[][] empty = new Player[8][8];
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }

    private Player[][] getInitPlayground() {
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

    private Player[][] getSmallPlayground() {
        Player[][] empty = new Player[7][7];
        for (int r = 0; r < 7; r++) {
            for (int c = 0; c < 7; c++) {
                empty[r][c] = Player.NONE;
            }
        }
        return empty;
    }
}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_test', 'ReversiTest.java', 11, 'import org.junit.Test;

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();

    @Test
    public void test() {
        Reversi game = rev;
        // TODO
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 11, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 11, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 11, 'public_file');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Reversi.java', 12, 'import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
            initGame(gameConfig);
            initTilesCount();
        } catch (IncorrectGameConfigFileException e) {
            ended = true;
            throw new IncorrectGameConfigFileException(e.getMessage());
        }
    }

    private void run() throws IncorrectGameConfigFileException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line;
            while (!ended) {
                printPlayground();
                printTilesLeftCount();
                System.out.format("Make a move. %s is on turn\n", onTurn);
                if (winner != Player.NONE) break;
                if ((line = reader.readLine()) == null) break;
                execute(line);
                reader.close();
            }
        } catch (IOException e) {
            throw new IncorrectGameConfigFileException("IO exception occurred on reading user input: " + e.getMessage());
        }
    }

    String[] readGameConfig(Path gameFilePath) throws IncorrectGameConfigFileException {
        String[] gameConfig;
        try {
            gameConfig = Files.readAllLines(gameFilePath).toArray(new String[0]);
        } catch (NoSuchFileException e) {
            throw new IncorrectGameConfigFileException("Game configuration file does not exist.");
        } catch (IOException e) {
            throw new IncorrectGameConfigFileException("Could not read game configuration file.", e);
        }
        return gameConfig;
    }

    void initGame(String[] gameConfig) throws IncorrectGameConfigFileException {
        if (gameConfig == null) {
            throw new IncorrectGameConfigFileException("Game configuration is null");
        }
        if (gameConfig.length != 3) {
            throw new IncorrectGameConfigFileException("Game configuration must contain 3 lines.");
        }
        try {
            setOnTurn(gameConfig[0]);
            createPlayground();
            fillPlayground(gameConfig);
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            throw new IncorrectGameConfigFileException("Game configuration is incorrect.");
        }
    }

    void setOnTurn(String player) throws IncorrectGameConfigFileException {
        if (!isOnTurnInputCorrect(player)) {
            throw new IncorrectGameConfigFileException("Incorrect player on turn input.");
        }
        onTurn = Player.valueOf(player);
    }

    boolean isOnTurnInputCorrect(String onTurn) {
        return onTurn != null && onTurn.matches("[B|W]");
    }

    void createPlayground() {
        playground = new Player[SIZE][SIZE];
        for (int r = 0; r < SIZE; r++) {
            for (int c = 0; c < SIZE; c++) {
                playground[r][c] = Player.NONE;
            }
        }
    }

    void fillPlayground(String[] gameConfig) throws IncorrectGameConfigFileException {
        try {
            for (int i = 1; i < 3; i++) {
                String[] tiles = gameConfig[i].split(" ");
                for (String tile : tiles) {
                    setTile(tile, players[i - 1]);
                }
            }
        } catch (ArrayIndexOutOfBoundsException | NullPointerException e) {
            throw new IncorrectGameConfigFileException("Game configuration file is incorrect.");
        }
    }

    void setTile(String tile, Player player) throws IncorrectGameConfigFileException {
        if (!isTileInputCorrect(tile)) {
            throw new IncorrectGameConfigFileException("Incorrect tile input");
        }
        int r = Integer.parseInt(tile.substring(1, 2)) - 1;
        int c = Alpha.valueOf(tile.substring(0, 1)).getValue();
        playground[r][c] = player;
    }

    void initTilesCount() throws IncorrectGameConfigFileException {
        try {
            for (int r = 0; r < SIZE; r++) {
                for (int c = 0; c < SIZE; c++) {
                    if (playground[r][c] == Player.B) {
                        left.put(Player.B, left.get(Player.B) + 1);
                    } else if (playground[r][c] == Player.W) {
                        left.put(Player.W, left.get(Player.W) + 1);
                    }
                }
            }
        } catch (NullPointerException | ArrayIndexOutOfBoundsException e) {
            throw new IncorrectGameConfigFileException("Playground  is not valid");
        }
    }

    private void printPlayground() {
        String[] abc = "ABCDEFGH".split("");
        System.out.printf("  %s\n", String.join(" ", abc));
        for (int r = 0; r < SIZE; r++) {
            System.out.print((r + 1) + " ");
            for (int c = 0; c < SIZE; c++) {
                switch (playground[r][c]) {
                    case B: System.out.print("B "); break;
                    case W: System.out.print("W "); break;
                    case NONE: System.out.print("_ "); break;
                }
            }
            System.out.println();
        }
    }

    private void printTilesLeftCount() {
        System.out.printf("Number of tiles: B: %s; W: %s\n\n", getLeftB(), getLeftW());
    }

    int getLeftB() {
        return left.get(Player.B);
    }

    int getLeftW() {
        return left.get(Player.W);
    }

    void execute(String tile) {
        if (!isTileInputCorrect(tile)) {
            System.out.println("Incorrect tile input");
            return;
        }
        int r = Integer.parseInt(tile.substring(1, 2));
        Alpha c = Alpha.valueOf(tile.substring(0, 1));
        move(c, r);
    }

    boolean isTileInputCorrect(String tile) {
        if (tile.length() != 2) return false;
        String r = tile.substring(1, 2);
        String c = tile.substring(0, 1);
        return r.matches("[1-8]") && c.matches("[A-H]");
    }

    void move(Alpha c0, int r0) {
        int r = r0 - 1;
        int c = c0.getValue();

        if (!(isWithinPlayground(r, c))) {
            System.out.println("Move out of bounds is not permitted");
            return;
        }
        if (!isEmpty(r, c)) {
            System.out.println("Move on not empty tile is not permitted");
            return;
        }
        if (isGameOver()) {
            System.out.println("The game is over. No moves are permitted");
            return;
        }

        ArrayList<List<Integer>> tilesToFlip = getTilesToFlip(r, c);
        if (tilesToFlip.size() == 0) {
            System.out.println("Move is not permitted");
            return;
        }
        flipTiles(tilesToFlip);

        swapPlayerOnTurn();
        if (! areValidMoves()) endGame();
    }

    boolean isWithinPlayground(int r, int c) {
        return r >= 0 && c >= 0 && r < SIZE && c < SIZE;
    }

    boolean isEmpty(int r, int c) {
        return playground[r][c] == Player.NONE;
    }

    boolean isGameOver() {
        return winner != Player.NONE;
    }

    ArrayList<List<Integer>> getTilesToFlip(int r0, int c0) {
        ArrayList<List<Integer>> toFLip = new ArrayList<>();
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
                toFLip.add(new ArrayList<>(List.of(r, c)));
            }
        }

        playground[r0][c0] = Player.NONE;
        if (toFLip.size() != 0) {
            toFLip.add(new ArrayList<>(List.of(r0, c0)));
        }
        return toFLip;
    }

    void flipTiles(ArrayList<List<Integer>> tiles) {
        tiles.forEach(tile -> {
            Player previous = playground[tile.get(0)][tile.get(1)];
            playground[tile.get(0)][tile.get(1)] = onTurn;
            if (previous == Player.NONE) {
                left.put(onTurn, left.get(onTurn) + 1);
            } else if (previous != onTurn) {
                left.put(previous, left.get(previous) - 1);
                left.put(onTurn, left.get(onTurn) + 1);
            }
        });
    }

    boolean areValidMoves() {
        int movesNum = getPossibleMoves().size();
        return movesNum != 0;
    }

    ArrayList<String> getPossibleMoves() {
        ArrayList<String> tiles = new ArrayList<>();
        for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
                if (playground[r][c] != Player.NONE) continue;
                if (getTilesToFlip(r,c).size() == 0) continue;
                String rString = String.valueOf(r + 1);
                String cString = Alpha.values()[c].toString();
                tiles.add(cString.concat(rString));
            }
        }
        return tiles;
    }

    void swapPlayerOnTurn() {
        if (onTurn == Player.W) onTurn = Player.B;
        else if (onTurn == Player.B) onTurn = Player.W;
    }

    void endGame() {
        printTilesLeftCount();
        ended = true;
        if (getLeftB() > getLeftW()) winner = Player.B;
        else if (getLeftW() > getLeftB()) winner = Player.W;
    }


    public static void main(String[] args) {
        String fileName = "game_init_b_starts.txt";
//        String fileName = "game_empty.txt";
//        String fileName = "game_one_line.txt";
//        String fileName = "game_three_lines.txt";
//        String fileName = "game_all_num.txt";
//        String fileName = "game_all_alpha.txt";

        File gameFile = new File("upload-dir/12345/game_config/" + fileName);
        Path gameFilePath = gameFile.toPath();

        Reversi rev;
        try {
            rev = new Reversi(gameFilePath);
            rev.run();
        } catch (IncorrectGameConfigFileException e) {
            System.out.println(e.getMessage());
        }

    }

}');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Alpha.java', 12, 'public enum Alpha {
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

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'Player.java', 12, 'public enum Player {
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
VALUES ('public_source', 'IncorrectGameConfigFileException.java', 12, 'public class IncorrectGameConfigFileException extends Exception {

    public IncorrectGameConfigFileException(String message) {
        super(message);
    }

}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('public_source', 'NotPermittedMoveException.java', 12, 'public class NotPermittedMoveException extends Exception {

    public NotPermittedMoveException(String message) {
        super(message);
    }
}
');

INSERT INTO exercise_content (exercise_content_type, filename, exercise_id, content)
VALUES ('private_test', 'ReversiTest.java', 12, 'import javafx.util.Pair;
import org.junit.Test;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameAllNum = new File(gameConfigDir + "game_all_num.txt").toPath();
    private Path gameAlmostComplete = new File(gameConfigDir + "game_almost_complete.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();


    // Player

    @Test
    public void testPlayerValueOf() {
        assertEquals("Value of Player B", Player.B, Player.valueOf("B"));
        assertEquals("Value of Player W", Player.W, Player.valueOf("W"));
        assertEquals("Value of Player NONE", Player.NONE, Player.valueOf("NONE"));
    }


    // Alpha

    @Test
    public void testAlphaValueOf() {
        assertEquals("Value of Alpha A", Alpha.A, Alpha.valueOf("A"));
        assertEquals("Value of Alpha B", Alpha.B, Alpha.valueOf("B"));
        assertEquals("Value of Alpha C", Alpha.C, Alpha.valueOf("C"));
        assertEquals("Value of Alpha D", Alpha.D, Alpha.valueOf("D"));
        assertEquals("Value of Alpha E", Alpha.E, Alpha.valueOf("E"));
        assertEquals("Value of Alpha F", Alpha.F, Alpha.valueOf("F"));
        assertEquals("Value of Alpha G", Alpha.G, Alpha.valueOf("G"));
        assertEquals("Value of Alpha H", Alpha.H, Alpha.valueOf("H"));
    }


    // readGameConfig

    @Test
    public void testReadGameConfigInit() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitBStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "B", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigInitW() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameInitWStarts);

        assertEquals("reading initial config file: lines number should be 3", 3, gameConfig.length);
        assertEquals("1st line of initial config file", "W", gameConfig[0]);
        assertEquals("2nd line of initial config file", "E4 D5", gameConfig[1]);
        assertEquals("3rd line of initial config file", "D4 E5", gameConfig[2]);
    }

    @Test
    public void testReadGameConfigEmpty() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameEmpty);

        assertEquals("lines number of empty config file", 0, gameConfig.length);
    }

    @Test
    public void testReadGameConfigOneLine() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameOneLine);

        assertEquals("lines number of 1-line config file", 1, gameConfig.length);
        assertEquals("1st line of 1-line config file", "E4 D5", gameConfig[0]);
    }

    @Test
    public void testReadGameConfigFourLines() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        String[] gameConfig = game.readGameConfig(gameFourLines);

        assertEquals(4, gameConfig.length);
        assertEquals("B", gameConfig[0]);
        assertEquals("E4 D5", gameConfig[1]);
        assertEquals("D4 E5", gameConfig[2]);
        assertEquals("E4 D5", gameConfig[3]);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testReadGameConfigNotExisting() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.readGameConfig(gameNotExisting);
    }


    // isOnTurnInputCorrect

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

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetOnTurnA() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setOnTurn("A");
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetOnTurnNone() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setOnTurn("NONE");
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetOnTurnnull() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.setOnTurn(null);

        assertEquals(Player.NONE, game.onTurn);
    }


    // createPlayground

    @Test
    public void testCreatePlayground() {
        Reversi game = getRevWithPlayground();

        assertArrayEquals("create empty playground", getEmptyPlayground(), game.playground);
    }


    // isTileInputCorrect

    @Test
    public void testTileInputA1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertTrue(game.isTileInputCorrect("A1"));
    }

    @Test
    public void testTileInputAA() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInput11() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInputa1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("a1"));
    }

    @Test
    public void testTileInput1A() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("1A"));
    }

    @Test
    public void testTileInputI1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("I1"));
    }

    @Test
    public void testTileInputA9() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("A9"));
    }

    @Test
    public void testTileInputI9() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        assertFalse(game.isTileInputCorrect("I9"));
    }


    // setTile

    @Test
    public void testSetTileA1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A1", Player.B);

        assertEquals(Player.B, getTile(game, Alpha.A, 1));
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTileAA() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("AA", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTile11() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("11", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTilea1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("a1", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTile1A() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("1A", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTileI1() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I1", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTileA9() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("A9", Player.B);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testSetTileI9() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.setTile("I9", Player.B);
    }


    // fillPlayground

    @Test
    public void testFillPlaygroundInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);

        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("fill playground with initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("fill playground with initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testFillPlaygroundConfigLen1() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"one"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testFillPlaygroundNull() throws IncorrectGameConfigFileException {
        Reversi game = getRevWithPlayground();
        game.fillPlayground(null);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testFillPlaygroundIncorrectConfig() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "AA BB", "CC DD"};
        Reversi game = getRevWithPlayground();
        game.fillPlayground(gameConfig);
    }


    // initGame

    @Test
    public void testInitGameInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = rev;
        game.initGame(gameConfig);

        assertEquals("init playground on initial game config", Player.B, game.onTurn);
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("init playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("init playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitGameNoLines() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {};
        Reversi game = rev;
        game.initGame(gameConfig);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitGameOneLine() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitGameFourLines() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitGameNull() throws IncorrectGameConfigFileException {
        Reversi game = rev;
        game.initGame(null);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testInitGameOnlyB() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5"};
        Reversi game = rev;
        game.initGame(gameConfig);
    }


    // initTilesCount

    @Test
    public void testInitTilesCountInit() throws IncorrectGameConfigFileException {
        String[] gameConfig = new String[] {"B", "E4 D5", "D4 E5"};
        Reversi game = initReversi(gameConfig);
        game.initTilesCount();

        assertEquals("init tiles count on initial game config", 2, game.getLeftB());
        assertEquals("init tiles count on initial game config", 2, game.getLeftW());
    }

    @Test
    public void testInitTilesCountEmpty() {
        Reversi game = getRevWithPlayground();

        assertEquals("init tiles count on empty game config", 0, game.getLeftB());
        assertEquals("init tiles count on empty game config", 0, game.getLeftW());
    }


    // getLeftB

    @Test
    public void testGetLeftB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Bs on initial game config", 2, game.getLeftB());
    }

    // getLeftW

    @Test
    public void testGetLeftW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }


    // Reversi

    @Test
    public void testInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertEquals("on turn player on initial game config", Player.B, game.onTurn);
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.E, 4));
        assertEquals("playground on initial game config", Player.B, getTile(game, Alpha.D, 5));
        assertEquals("playground on initial game config", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("left Bs on initial game config", 2, game.getLeftB());
        assertEquals("left Ws on initial game config", 2, game.getLeftW());
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testEmpty() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameEmpty);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testOneLine() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameOneLine);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testFourLines() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameFourLines);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testAllNum() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameAllNum);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testAllAlpha() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameAllAlpha);
    }

    @Test(expected = IncorrectGameConfigFileException.class)
    public void testNoOnTurn() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameNoOnTurn);
    }


    // printPlayground

//    @Test
//    public void testPrintPlaygroundInit() {
//        /// ?
//    }


    // printTilesLeftCount

//    @Test
//    public void testprintTilesLeftCountInit() {
//        /// ?
//    }


    // isWithinPlayground

    @Test
    public void testIsWithinPlayground00() {
        Reversi game = rev;

        assertTrue("within playground (0, 0)", game.isWithinPlayground(0, 0));
    }

    @Test
    public void testIsWithinPlayground77() {
        Reversi game = rev;

        assertTrue("within playground (7, 7)", game.isWithinPlayground(7, 7));
    }

    @Test
    public void testIsWithinPlaygroundNegR() {
        Reversi game = rev;

        assertFalse("within playground (-1, 0)", game.isWithinPlayground(-1, 0));
    }

    @Test
    public void testIsWithinPlaygroundNegC() {
        Reversi game = rev;

        assertFalse("within playground (0, -1)", game.isWithinPlayground(0, -1));
    }

    @Test
    public void testIsWithinPlaygroundLargeR() {
        Reversi game = rev;

        assertFalse("within playground (8, 0)", game.isWithinPlayground(8, 0));
    }

    @Test
    public void testIsWithinPlaygroundLargeC() {
        Reversi game = rev;

        assertFalse("within playground (0, 8)", game.isWithinPlayground(0, 8));
    }


    // isEmpty

    @Test
    public void testIsEmptyInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("is empty (0, 0) on init", game.isEmpty(0, 0));
    }

    @Test
    public void testIsEmptyInit33() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertFalse("is empty (3, 3) on init", game.isEmpty(3, 3));
    }


    // isGameOver

    @Test
    public void testIsGameOverInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertFalse("is game over on init", game.isGameOver());
    }

    @Test
    public void testIsGameOverOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameComplete);
        assertFalse("is game over on init", game.isGameOver());
    }


    // getTilesToFlip

    @Test
    public void testGetTilesToFlipInit32() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(3, 2);
        ArrayList<List<Integer>> expected = new ArrayList<>();
        expected.add(Arrays.asList(3, 3));
        expected.add(Arrays.asList(3, 2));

        assertEquals("tiles to flip on onit - (3, 2)", 2, tiles.size());
        assertEquals("...", expected.get(0).get(0), tiles.get(0).get(0));
        assertEquals("...", expected.get(0).get(1), tiles.get(0).get(1));
        assertEquals("...", expected.get(1).get(0), tiles.get(1).get(0));
        assertEquals("...", expected.get(1).get(1), tiles.get(1).get(1));
    }

    @Test
    public void testGetTilesToFlipInit00() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = game.getTilesToFlip(0, 0);

        assertEquals("tiles to flip on onit - (0, 0)", 0, tiles.size());
    }


    // flipTiles

    @Test
    public void testFlipTiles() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<List<Integer>> tiles = new ArrayList<>();
        tiles.add(Arrays.asList(3, 3));
        tiles.add(Arrays.asList(3, 2));
        game.flipTiles(tiles);

        assertEquals("...", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("...", Player.B, getTile(game, Alpha.D, 4));
    }

    // getPossibleMoves

    @Test
    public void testGetPossibleMovesEmptyInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 4, tiles.size());
        assertEquals("valid moves", "D3", tiles.get(0));
        assertEquals("valid moves", "C4", tiles.get(1));
        assertEquals("valid moves", "F5", tiles.get(2));
        assertEquals("valid moves", "E6", tiles.get(3));
    }

    @Test
    public void testGetPossibleMovesEmpty() {
        Reversi game = getRevWithPlayground();
        ArrayList<String> tiles = game.getPossibleMoves();

        assertEquals("valid length", 0, tiles.size());
    }


    // areValidMoves

    @Test
    public void testAreValidMovesInit() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);

        assertTrue("...", game.areValidMoves());
    }

    @Test
    public void testAreValidMovesOnEnd() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameComplete);

        assertFalse("...", game.areValidMoves());
    }


    // swapPlayerOnTurn

    @Test
    public void testSwapPlayerOnTurnBtoW() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.swapPlayerOnTurn();

        assertEquals("...", Player.W, game.onTurn);
    }

    @Test
    public void testSwapPlayerOnTurnWtoB() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitWStarts);
        game.swapPlayerOnTurn();

        assertEquals("...", Player.B, game.onTurn);
    }

    // endGame

    @Test
    public void testEndGame() throws IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameComplete);
        game.endGame();

        assertTrue("...", game.ended);
        assertEquals("...", Player.B, game.winner);
    }


    // move

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOnNotEmpty() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E,5);
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOutOfBoundsBelow() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,9);
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOutOfBoundsAbove() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,0);
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOnNotAdjacent() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.A,1);
    }

    @Test
    public void testMoveFlipRight() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.C,4);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipUp() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.E, 6);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 6));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeft() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.F, 5);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipDown() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.move(Alpha.D, 3);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 3));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightUp() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 6));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 7));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftUp() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.E, 5));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.F, 6));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFlipLeftDown() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.E, 3));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.F, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testMoveFlipRightDown() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped", Player.W, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.W, getTile(game, Alpha.C, 3));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveDoubleFlip() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        Reversi game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", Player.W, getTile(game, Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", Player.W, getTile(game, Alpha.E, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testMoveFinishGame() throws IncorrectGameConfigFileException, NotPermittedMoveException {
        Reversi game = new Reversi(gameAlmostComplete);
        game.move(Alpha.G, 7);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }

    @Test
    public void testMovesCompleteGame() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6)); moves.add(new Pair<>(Alpha.F, 4));
        moves.add(new Pair<>(Alpha.D, 3)); moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.C, 3)); moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.E, 3)); moves.add(new Pair<>(Alpha.C, 2));
        moves.add(new Pair<>(Alpha.B, 3)); moves.add(new Pair<>(Alpha.F, 5));
        moves.add(new Pair<>(Alpha.F, 3)); moves.add(new Pair<>(Alpha.D, 2));
        moves.add(new Pair<>(Alpha.E, 2)); moves.add(new Pair<>(Alpha.B, 4));
        moves.add(new Pair<>(Alpha.C, 5)); moves.add(new Pair<>(Alpha.F, 1));
        moves.add(new Pair<>(Alpha.A, 3)); moves.add(new Pair<>(Alpha.F, 2));
        moves.add(new Pair<>(Alpha.C, 6)); moves.add(new Pair<>(Alpha.F, 6));
        moves.add(new Pair<>(Alpha.G, 6)); moves.add(new Pair<>(Alpha.A, 5));
        moves.add(new Pair<>(Alpha.B, 5)); moves.add(new Pair<>(Alpha.A, 6));
        moves.add(new Pair<>(Alpha.G, 5)); moves.add(new Pair<>(Alpha.C, 7));
        moves.add(new Pair<>(Alpha.G, 3)); moves.add(new Pair<>(Alpha.D, 7));
        moves.add(new Pair<>(Alpha.E, 7)); moves.add(new Pair<>(Alpha.H, 4));
        moves.add(new Pair<>(Alpha.D, 8)); moves.add(new Pair<>(Alpha.G, 4));
        moves.add(new Pair<>(Alpha.A, 4)); moves.add(new Pair<>(Alpha.A, 2));
        moves.add(new Pair<>(Alpha.H, 2)); moves.add(new Pair<>(Alpha.H, 3));
        moves.add(new Pair<>(Alpha.H, 5)); moves.add(new Pair<>(Alpha.B, 6));
        moves.add(new Pair<>(Alpha.C, 8)); moves.add(new Pair<>(Alpha.F, 7));
        moves.add(new Pair<>(Alpha.E, 8)); moves.add(new Pair<>(Alpha.B, 7));
        moves.add(new Pair<>(Alpha.C, 1)); moves.add(new Pair<>(Alpha.H, 6));
        moves.add(new Pair<>(Alpha.H, 7)); moves.add(new Pair<>(Alpha.D, 1));
        moves.add(new Pair<>(Alpha.A, 8)); moves.add(new Pair<>(Alpha.B, 1));
        moves.add(new Pair<>(Alpha.A, 7)); moves.add(new Pair<>(Alpha.F, 8));
        moves.add(new Pair<>(Alpha.G, 2)); moves.add(new Pair<>(Alpha.H, 1));
        moves.add(new Pair<>(Alpha.G, 1)); moves.add(new Pair<>(Alpha.H, 8));
        moves.add(new Pair<>(Alpha.E, 1)); moves.add(new Pair<>(Alpha.B, 8));
        moves.add(new Pair<>(Alpha.A, 1)); moves.add(new Pair<>(Alpha.B, 2));
        moves.add(new Pair<>(Alpha.G, 8)); moves.add(new Pair<>(Alpha.G, 7));
        Reversi game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // execute

    @Test
    public void testExecute() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("C4");

        assertEquals("check if flipped", Player.B, getTile(game, Alpha.D, 4));
        assertEquals("check if flipped", Player.B, getTile(game, Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testExecuteA1() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        game.execute("A1");
    }

    @Test
    public void testFinishGame() throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameAlmostComplete);
        game.execute("G7");

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
        assertEquals("winner", Player.B, game.winner);
    }


    // utility functions

    private Player getTile(Reversi game, Alpha c0, int r0) {
        return game.playground[r0-1][c0.getValue()];
    }


    private Reversi setMoves(ArrayList<Pair<Alpha, Integer>> moves) throws NotPermittedMoveException, IncorrectGameConfigFileException {
        Reversi game = new Reversi(gameInitBStarts);
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }

    private Reversi initReversi(String[] gameConfig) throws IncorrectGameConfigFileException {
        Reversi rev = new Reversi();
        rev.initGame(gameConfig);
        return rev;
    }

    private Reversi getRevWithPlayground() {
        Reversi rev = new Reversi();
        rev.createPlayground();
        return rev;
    }

    private Player[][] getEmptyPlayground() {
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
VALUES ('public_test', 'ReversiTest.java', 12, 'import org.junit.Test;

import java.io.File;
import java.nio.file.Path;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class ReversiTest {

    private Reversi rev = new Reversi();

    private String gameConfigDir = "upload-dir/12345/game_config/";
    private Path gameAllAlpha = new File(gameConfigDir + "game_all_alpha.txt").toPath();
    private Path gameComplete = new File(gameConfigDir + "game_complete.txt").toPath();
    private Path gameEmpty = new File(gameConfigDir + "game_empty.txt").toPath();
    private Path gameFourLines = new File(gameConfigDir + "game_four_lines.txt").toPath();
    private Path gameInitBStarts = new File(gameConfigDir + "game_init_b_starts.txt").toPath();
    private Path gameInitWStarts = new File(gameConfigDir + "game_init_w_starts.txt").toPath();
    private Path gameNoOnTurn = new File(gameConfigDir + "game_no_on_turn.txt").toPath();
    private Path gameOneLine = new File(gameConfigDir + "game_one_line.txt").toPath();
    private Path gameNotExisting = new File(gameConfigDir + "game_not_existing.txt").toPath();

    @Test
    public void test() {
        Reversi game = rev;
        // TODO
    }

}');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_alpha.txt', 'B
EE DD
DD EE
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_all_num.txt', 'B
44 55
44 55
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_almost_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 F7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 H7 H8
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_complete.txt', 'W
A1 B1 C1 D1 E1 F1 G1 A2 D2 E2 F2 G2 A3 E3 G3 A4 C4 G4 A5 D5 E5 F5 G5 A6 C6 E6 G6 A7 D7 A8 B8 C8 D8 E8 F8 G8
H1 B2 C2 H2 B3 C3 D3 F3 H3 B4 D4 E4 F4 H4 B5 C5 H5 B6 D6 F6 H6 B7 C7 E7 F7 G7 H7 H8
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_empty.txt', '', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_four_lines.txt', 'B
E4 D5
D4 E5
E4 D5
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_b_starts.txt', 'B
E4 D5
D4 E5
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_init_w_starts.txt', 'W
E4 D5
D4 E5
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_no_on_turn.txt', 'E4 D5
D4 E5
', 12, 'public_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 12, 'private_file');

INSERT INTO exercise_content (filename, content, exercise_id, exercise_content_type)
VALUES ('game_one_line.txt', 'E4 D5
', 12, 'public_file');

