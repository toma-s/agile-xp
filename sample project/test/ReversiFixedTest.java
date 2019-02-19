import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class ReversiFixedTest {

    private ReversiFixed rev = new ReversiFixed();

    @Test
    public void testInit() {
        ReversiFixed game = rev;

        assertEquals("on turn", 1, game.onTurn);
        assertEquals("playground init", 0, game.playground[3][3]);
        assertEquals("playground init", 1, game.playground[3][4]);
        assertEquals("playground init", 1, game.playground[4][3]);
        assertEquals("playground init", 0, game.playground[4][4]);
        assertEquals("left X init", 2, game.leftX);
        assertEquals("left O init", 2, game.leftO);
    }

    @Test
    public void testMoveOnNotEmpty() {
        ReversiFixed game = rev;
        assertFalse("move on not empty tile (4,4)", game.move(4,4));

        assertEquals("check if didn't change", 0, game.playground[4][4]);
    }

    @Test
    public void testMoveOutOfBounds() {
        ReversiFixed game = rev;
        assertFalse("move on tile out of bounds (0,8)", game.move(0,8));

        assertFalse("move on tile out of bounds (0,-1)", game.move(0,-1));
    }

    @Test
    public void testMoveOnNotAdjacent() {
        ReversiFixed game = rev;
        assertFalse("not valid move (0,0)", game.move(0,0));

        assertEquals("check if didn't change", -1, game.playground[0][0]);
    }

    @Test
    public void testFlipRight() {
        ReversiFixed game = rev;
        assertTrue("move to flip", game.move(3, 2));

        assertEquals("check if flipped", 1, game.playground[3][3]);
        assertEquals("check if flipped", 1, game.playground[3][2]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipUp() {
        ReversiFixed game = rev;
        assertTrue("move to flip", game.move(5, 4));

        assertEquals("check if flipped", 1, game.playground[4][4]);
        assertEquals("check if flipped", 1, game.playground[5][4]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipLeft() {
        ReversiFixed game = rev;
        assertTrue("move to flip", game.move(4, 5));

        assertEquals("check if flipped", 1, game.playground[4][4]);
        assertEquals("check if flipped", 1, game.playground[4][5]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipDown() {
        ReversiFixed game = rev;
        assertTrue("move to flip", game.move(2, 3));

        assertEquals("check if flipped", 1, game.playground[3][3]);
        assertEquals("check if flipped", 1, game.playground[2][3]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 1, game.leftO);
        assertEquals("X left", 4, game.leftX);
    }

    @Test
    public void testFlipRightUp() {
        int[][] moves = {{5, 4}, {5, 3}, {6, 2}};
        ReversiFixed game = setMoves(moves);

        assertEquals("check if flipped", 1, game.playground[5][3]);
        assertEquals("check if flipped", 1, game.playground[6][2]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 2, game.leftO);
        assertEquals("X left", 5, game.leftX);
    }

    @Test
    public void testFlipLeftUp() {
        int[][] moves = {{5, 4}, {5, 5}};
        ReversiFixed game = setMoves(moves);

        assertEquals("check if flipped", 0, game.playground[4][4]);
        assertEquals("check if flipped", 0, game.playground[5][5]);
        assertEquals("check on turn", 1, game.onTurn);
        assertEquals("O left", 3, game.leftO);
        assertEquals("X left", 3, game.leftX);
    }

    @Test
    public void testFlipLeftDown() {
        int[][] moves = {{2, 3}, {2, 4}, {1, 5}};
        ReversiFixed game = setMoves(moves);

        assertEquals("check if flipped", 1, game.playground[2][4]);
        assertEquals("check if flipped", 1, game.playground[1][5]);
        assertEquals("check on turn", 0, game.onTurn);
        assertEquals("O left", 2, game.leftO);
        assertEquals("X left", 5, game.leftX);
    }

    @Test
    public void testFlipRightDown() {
        int[][] moves = {{2, 3}, {2, 2}};
        ReversiFixed game = setMoves(moves);

        assertEquals("check if flipped", 0, game.playground[3][3]);
        assertEquals("check if flipped", 0, game.playground[2][2]);
        assertEquals("check on turn", 1, game.onTurn);
        assertEquals("O left", 3, game.leftO);
        assertEquals("X left", 3, game.leftX);
    }

    @Test
    public void testDoubleFlip() {
        int[][] moves = {{2, 3}, {2, 2}, {3, 2}, {2, 4}};
        ReversiFixed game = setMoves(moves);

        assertEquals("check if flipped (2,3) correctly",0, game.playground[2][3]);
        assertEquals("check if flipped (3,4) correctly",0, game.playground[3][4]);
        assertEquals("O left", 5, game.leftO);
        assertEquals("X left", 3, game.leftX);
    }

    @Test
    public void testGame1() {
        int[][] moves = {{4, 5}, {5, 3}, {3, 2}, {2, 3}, {2, 2}, {3, 5}, {4, 2}, {2, 1}, {1, 2}, {5, 4},
                {5, 2}, {3, 1}, {4, 1}, {1, 3}, {2, 4}, {5, 0}, {0, 2}, {5, 1}, {2, 5}, {5, 5}, {6, 5},
                {0, 4}, {1, 4}, {0, 5}, {6, 4}, {2, 6}, {6, 2}, {3, 6}, {4, 6}, {7, 3}, {3, 7}, {6, 3},
                {0, 3}, {0, 1}, {7, 1}, {7, 2}, {7, 4}, {1, 5}, {2, 7}, {5, 6}, {4, 7}, {1, 6}, {2, 0},
                {7, 5}, {7, 6}, {3, 0}, {0, 7}, {1, 0}, {0, 6}, {5, 7}, {6, 1}, {7, 0}, {6, 0}, {7, 7},
                {4, 0}, {1, 7}, {0, 0}, {1, 1}, {6, 7}, {6, 6}};
        ReversiFixed game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        game.gameOver();
        assertEquals("winner", 0, game.winner);
        assertEquals("O left", 33, game.leftO);
        assertEquals("X left", 31, game.leftX);
        assertFalse("game is over", game.move(0, 1));
    }

    private ReversiFixed setMoves(int[][] moves) {
        ReversiFixed game = new ReversiFixed();
        for (int[] move  : moves) {
            int r = move[0];
            int c = move[1];
            game.move(r, c);
        }
        return game;
    }
}