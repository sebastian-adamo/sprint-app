package com.sprint.controller;

import com.sprint.domain.Task;
import com.sprint.domain.User;
import com.sprint.repository.TaskRepository;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.HashMap;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class TaskControllerTests {

    @InjectMocks
    private TaskController taskController;

    @Mock
    private TaskRepository taskRepository;

    private Task task;

    @Before
    public void init() {
        task = new Task("Testing", 0);
        task.setId(1);
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testDelete() {
        Task task = new Task("Testing", 0);
        task.setId(1);
        when(taskRepository.findById(1)).thenReturn(task);
//        verify(taskRepository).findById(1);
    }

    @Test
    public void testGet() {
        when(taskRepository.findById(1)).thenReturn(task);

        HashMap<String, Object> test = taskController.get(1);

        verify(taskRepository).findById(1);

        assertEquals(test.get("name"), "Testing");
    }

//    @Test
//    public void testVote() {
//        User user = new User("admin", "admin@sprint.com", "admin");
//        task.getUsersVoted().add(user);
//        when(taskRepository.findById(1)).thenReturn(task);
//
//        taskController.vote(1);
////        assertEquals(taskController.get, "Testing");
//    }
}
