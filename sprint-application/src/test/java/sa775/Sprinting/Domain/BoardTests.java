package sa775.Sprinting.Domain;

import org.junit.Before;
import org.junit.Test;
import sa775.Sprint.Domain.Board;
import sa775.Sprint.Domain.Task;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class BoardTests {

    private Board board;
    private Task task;

    @Before
    public void setupBoard() {
        board = new Board("Board");
        task = new Task("Task 1", "Task 1", false, true, 50);
    }

    @Test
    public void testBacklog_Add() {
        board.getBacklog().add(task);
        assertEquals(1, board.getBacklog().size());
        assertTrue(board.getBacklog().contains(task));
    }

    @Test
    public void testTodo_Add() {
        board.getTodo().add(task);
        assertEquals(1, board.getTodo().size());
        assertTrue(board.getTodo().contains(task));
    }

    @Test
    public void testInprogress_Add() {
        board.getInprogress().add(task);
        assertEquals(1, board.getInprogress().size());
        assertTrue(board.getInprogress().contains(task));
    }

    @Test
    public void testComplete_Add() {
        board.getComplete().add(task);
        assertEquals(1, board.getComplete().size());
        assertTrue(board.getComplete().contains(task));
    }
}
