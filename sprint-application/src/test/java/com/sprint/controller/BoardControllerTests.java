package com.sprint.controller;

import com.sprint.domain.Board;
import com.sprint.repository.BoardRepository;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.HashMap;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

public class BoardControllerTests {

    @InjectMocks
    private BoardController boardController;

    @Mock
    private BoardRepository boardRepository;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

//    @Test
//    public void testGetMyBoard() {
//        Board board = new Board("Testing", "Testing 123", "");
//        board.setId(1L);
//        when(boardRepository.findById(1L).orElse(null)).thenReturn(board);
//
//        HashMap<String, Object> test = boardController.getMyBoard(1L);
//
//        assertEquals(test.get("name"), "Testing");
//    }
}
