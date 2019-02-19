import javafx.util.Pair;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class ReversiFeatureMovesTest {
    private ReversiFeatureMoves rev = new ReversiFeatureMoves();

    @Test
    public void testInit() {
        ReversiFeatureMoves game = rev;

        assertEquals("on turn", 1, game.onTurn);
        assertEquals("playground init", 0, game.getTile(Alpha.D, 4));
        assertEquals("playground init", 1, game.getTile(Alpha.E, 4));
        assertEquals("playground init", 1, game.getTile(Alpha.D, 5));
        assertEquals("playground init", 0, game.getTile(Alpha.E, 5));
        assertEquals("left B init", 2, game.leftB);
        assertEquals("left W init", 2, game.leftW);
    }

    @Test
    public void testInitValidMoves() {
        ReversiFeatureMoves game = rev;
        ArrayList<ArrayList<Integer>> tiles = game.getPossibleMoves();

        assertEquals("valid length", 4, tiles.size());
        assertEquals("valid moves", List.of(2, 3), tiles.get(0));
        assertEquals("valid moves", List.of(3, 2), tiles.get(1));
        assertEquals("valid moves", List.of(4, 5), tiles.get(2));
        assertEquals("valid moves", List.of(5, 4), tiles.get(3));
    }

    @Test
    public void testMoveOnNotEmpty() {
        ReversiFeatureMoves game = rev;
        assertFalse("move on not empty tile (e,5)", game.move(Alpha.E,5));

        assertEquals("check if didn't change", 0, game.getTile(Alpha.E, 5));
    }

    @Test
    public void testMoveOutOfBounds() {
        ReversiFeatureMoves game = rev;
        assertFalse("move on tile out of bounds (a,9)", game.move(Alpha.A,9));

        assertFalse("move on tile out of bounds (a,0)", game.move(Alpha.A,0));
    }

    @Test
    public void testMoveOnNotAdjacent() {
        ReversiFeatureMoves game = rev;
        assertFalse("not valid move (a,1)", game.move(Alpha.A,1));

        assertEquals("check if didn't change", -1, game.getTile(Alpha.A, 1));
    }

    @Test
    public void testFlipRight() {
        ReversiFeatureMoves game = rev;
        assertTrue("move to flip (c,4)", game.move(Alpha.C,4));

        assertEquals("check if flipped", 1, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", 1, game.getTile(Alpha.C, 4));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.leftW);
        assertEquals("B left", 4, game.leftB);
    }

    @Test
    public void testFlipUp() {
        ReversiFeatureMoves game = rev;
        assertTrue("move to flip", game.move(Alpha.E, 6));

        assertEquals("check if flipped", 1, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", 1, game.getTile(Alpha.E, 6));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.leftW);
        assertEquals("B left", 4, game.leftB);
    }

    @Test
    public void testFlipLeft() {
        ReversiFeatureMoves game = rev;
        assertTrue("move to flip", game.move(Alpha.F, 5));

        assertEquals("check if flipped",1, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", 1, game.getTile(Alpha.F, 5));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.leftW);
        assertEquals("B left", 4, game.leftB);
    }

    @Test
    public void testFlipDown() {
        ReversiFeatureMoves game = rev;
        assertTrue("move to flip", game.move(Alpha.D, 3));

        assertEquals("check if flipped", 1, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", 1, game.getTile(Alpha.D, 3));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 1, game.leftW);
        assertEquals("B left", 4, game.leftB);
    }

    @Test
    public void testFlipRightUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        ReversiFeatureMoves game = setMoves(moves);

        assertEquals("check if flipped", 1, game.getTile(Alpha.D, 6));
        assertEquals("check if flipped", 1, game.getTile(Alpha.C, 7));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.leftW);
        assertEquals("B left", 5, game.leftB);
    }

    @Test
    public void testFlipLeftUp() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        ReversiFeatureMoves game = setMoves(moves);

        assertEquals("check if flipped", 0, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", 0, game.getTile(Alpha.F, 6));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.leftW);
        assertEquals("B left", 3, game.leftB);
    }

    @Test
    public void testFlipLeftDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        ReversiFeatureMoves game = setMoves(moves);

        assertEquals("check if flipped",1, game.getTile(Alpha.E, 3));
        assertEquals("check if flipped", 1, game.getTile(Alpha.F, 2));
        assertEquals("on turn", 0, game.onTurn);
        assertEquals("W left", 2, game.leftW);
        assertEquals("B left", 5, game.leftB);
    }

    @Test
    public void testFlipRightDown() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        ReversiFeatureMoves game = setMoves(moves);

        assertEquals("check if flipped", 0, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", 0, game.getTile(Alpha.C, 3));
        assertEquals("on turn", 1, game.onTurn);
        assertEquals("W left", 3, game.leftW);
        assertEquals("B left", 3, game.leftB);
    }

    @Test
    public void testDoubleFlip() {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        ReversiFeatureMoves game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", 0, game.getTile(Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", 0, game.getTile(Alpha.E, 4));
        assertEquals("W left", 5, game.leftW);
        assertEquals("B left", 3, game.leftB);
    }

    @Test
    public void testGame1() {
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
        ReversiFeatureMoves game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        game.gameOver();
        assertEquals("winner", 0, game.winner);
        assertEquals("W left", 33, game.leftW);
        assertEquals("B left", 31, game.leftB);
        assertFalse("game is over", game.move(Alpha.A, 1));
    }

    private ReversiFeatureMoves setMoves(ArrayList<Pair<Alpha, Integer>> moves) {
        ReversiFeatureMoves game = new ReversiFeatureMoves();
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }
}
