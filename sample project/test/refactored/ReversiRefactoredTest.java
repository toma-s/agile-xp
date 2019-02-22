package refactored;

import exception.NotPermittedMoveException;
import javafx.util.Pair;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class ReversiRefactoredTest {
    private int size = 8;
    private ReversiRefactored rev = new ReversiRefactored(size);

    @Test
    public void testInit() {
        ReversiRefactored game = rev;

        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("playground init", Player.W, game.getTile(Alpha.D, 4));
        assertEquals("playground init", Player.B, game.getTile(Alpha.E, 4));
        assertEquals("playground init", Player.B, game.getTile(Alpha.D, 5));
        assertEquals("playground init", Player.W, game.getTile(Alpha.E, 5));
        assertEquals("left B init", 2, game.getLeftB());
        assertEquals("left W init", 2, game.getLeftW());
    }

    @Test
    public void testInitValidMoves() {
        ReversiRefactored game = rev;
        ArrayList<ArrayList<Integer>> tiles = game.getPossibleMoves();

        assertEquals("valid length", 4, tiles.size());
        assertEquals("valid moves", List.of(2, 3), tiles.get(0));
        assertEquals("valid moves", List.of(3, 2), tiles.get(1));
        assertEquals("valid moves", List.of(4, 5), tiles.get(2));
        assertEquals("valid moves", List.of(5, 4), tiles.get(3));
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOnNotEmpty() throws NotPermittedMoveException {
        ReversiRefactored game = rev;
        game.move(Alpha.E,5);

        assertEquals("check if didn't change", Player.W, game.getTile(Alpha.E, 5));
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOutOfBoundsBelow() throws NotPermittedMoveException {
        ReversiRefactored game = rev;
        game.move(Alpha.A,9);

        assertEquals("check if didn't change", Player.NONE, game.getTile(Alpha.A, 9));
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOutOfBoundsAbove() throws NotPermittedMoveException {
        ReversiRefactored game = rev;
        game.move(Alpha.A,0);

        assertEquals("check if didn't change", Player.NONE, game.getTile(Alpha.A, 0));
    }

    @Test(expected = NotPermittedMoveException.class)
    public void testMoveOnNotAdjacent() throws NotPermittedMoveException {
        ReversiRefactored game = rev;
        game.move(Alpha.A,1);

        assertEquals("check if didn't change", Player.NONE, game.getTile(Alpha.A, 1));
    }

    @Test
    public void testFlipRight() throws NotPermittedMoveException {
        ReversiRefactored game = rev;
        game.move(Alpha.C,4);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.C, 4));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testFlipUp() throws NotPermittedMoveException {
        ReversiRefactored game = rev;
        game.move(Alpha.E, 6);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.E, 6));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testFlipLeft() throws NotPermittedMoveException {
        ReversiRefactored game = rev;
        game.move(Alpha.F, 5);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.F, 5));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testFlipDown() throws NotPermittedMoveException {
        ReversiRefactored game = rev;
        game.move(Alpha.D, 3);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.D, 3));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 1, game.getLeftW());
        assertEquals("B left", 4, game.getLeftB());
    }

    @Test
    public void testFlipRightUp() throws NotPermittedMoveException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.D, 6));
        moves.add(new Pair<>(Alpha.C, 7));
        ReversiRefactored game = setMoves(moves);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.D, 6));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.C, 7));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testFlipLeftUp() throws NotPermittedMoveException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.E, 6));
        moves.add(new Pair<>(Alpha.F, 6));
        ReversiRefactored game = setMoves(moves);

        assertEquals("check if flipped", Player.W, game.getTile(Alpha.E, 5));
        assertEquals("check if flipped", Player.W, game.getTile(Alpha.F, 6));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testFlipLeftDown() throws NotPermittedMoveException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.E, 3));
        moves.add(new Pair<>(Alpha.F, 2));
        ReversiRefactored game = setMoves(moves);

        assertEquals("check if flipped", Player.B, game.getTile(Alpha.E, 3));
        assertEquals("check if flipped", Player.B, game.getTile(Alpha.F, 2));
        assertEquals("on turn", Player.W, game.onTurn);
        assertEquals("W left", 2, game.getLeftW());
        assertEquals("B left", 5, game.getLeftB());
    }

    @Test
    public void testFlipRightDown() throws NotPermittedMoveException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        ReversiRefactored game = setMoves(moves);

        assertEquals("check if flipped", Player.W, game.getTile(Alpha.D, 4));
        assertEquals("check if flipped", Player.W, game.getTile(Alpha.C, 3));
        assertEquals("on turn", Player.B, game.onTurn);
        assertEquals("W left", 3, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testDoubleFlip() throws NotPermittedMoveException {
        ArrayList<Pair<Alpha, Integer>> moves = new ArrayList<>();
        moves.add(new Pair<>(Alpha.D, 3));
        moves.add(new Pair<>(Alpha.C, 3));
        moves.add(new Pair<>(Alpha.C, 4));
        moves.add(new Pair<>(Alpha.E, 3));
        ReversiRefactored game = setMoves(moves);

        assertEquals("check if flipped (D,3) correctly", Player.W, game.getTile(Alpha.D, 3));
        assertEquals("check if flipped (E,4) correctly", Player.W, game.getTile(Alpha.E, 4));
        assertEquals("W left", 5, game.getLeftW());
        assertEquals("B left", 3, game.getLeftB());
    }

    @Test
    public void testGame1() throws NotPermittedMoveException {
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
        ReversiRefactored game = setMoves(moves);

        assertFalse("if the are valid moves", game.areValidMoves());
        assertEquals("winner", Player.B, game.winner);
        assertEquals("W left", 28, game.getLeftW());
        assertEquals("B left", 36, game.getLeftB());
    }

    private ReversiRefactored setMoves(ArrayList<Pair<Alpha, Integer>> moves) throws NotPermittedMoveException {
        ReversiRefactored game = rev;
        for (Pair<Alpha, Integer> move  : moves) {
            Alpha r = move.getKey();
            Integer c = move.getValue();
            game.move(r, c);
        }
        return game;
    }
}
