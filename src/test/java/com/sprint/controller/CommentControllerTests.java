package com.sprint.controller;

import com.sprint.domain.Comment;
import com.sprint.domain.Task;
import com.sprint.repository.CommentRepository;
import com.sprint.repository.TaskRepository;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class CommentControllerTests {

    @InjectMocks
    private CommentController commentController;

    @Mock
    private TaskRepository taskRepository;
    @Mock
    private CommentRepository commentRepository;

    private Task task;
    private Comment comment;

    @Before
    public void init() {
        task = new Task("Test Task", 0);
        task.setId(1);
        comment = new Comment("Test User", "Test Comment");
        task.getComments().add(comment);

        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetAll() {
        when(taskRepository.findById(1)).thenReturn(task);

        List<Comment> test = commentController.getAll(1);

        verify(taskRepository).findById(1);

        assertTrue(test.contains(comment));
    }

//    @Test
//    public void testDelete() {
//        commentController.delete(1);
//        verify(commentRepository).delete(comment);
//    }
}
