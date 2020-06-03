package com.sprint.controller;

import com.sprint.domain.*;
import com.sprint.repository.BoardRepository;
import com.sprint.repository.TaskRepository;
import com.sprint.repository.TodoRepository;
import com.sprint.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("/task")
public class TaskController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BoardRepository boardRepository;
    @Autowired
    private TaskRepository taskRepository;

    @GetMapping("/add")
    public void add(@RequestParam String name, @RequestParam String list) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId());

        switch (list) {
            case "backlog":
                Task task = new Task(name, board.getBacklog().size()+1);
                board.addBacklog(task);
                break;
            case "todo":
                Task task1 = new Task(name, board.getTodo().size()+1);
                board.addTodo(task1);
                break;
            case "inprogress":
                Task task2 = new Task(name, board.getInprogress().size()+1);
                board.addInprogress(task2);
                break;
            case "complete":
                Task task3 = new Task(name, board.getComplete().size()+1);
                board.addComplete(task3);
                break;
        }
        boardRepository.save(board);
    }

    @GetMapping("/delete")
    public void delete(@RequestParam int id) {
        taskRepository.deleteById(id);
    }

    @GetMapping("/vote")
    public void vote(@RequestParam int id) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Task task = taskRepository.findById(id);

        if (task.getUsersVoted().contains(user)) {
            task.getUsersVoted().remove(user);
            user.getVotedTasks().remove(task);
        }
        else {
            task.getUsersVoted().add(user);
            user.getVotedTasks().add(task);
        }
        userRepository.save(user);
    }


    // Sort
    @GetMapping("/get")
    public HashMap<String, Object> get(@RequestParam int id) {
        Task task = taskRepository.findById(id);
        HashMap<String, Object> returnMap = new HashMap<>();
        returnMap.put("name", task.getName());
        returnMap.put("description", task.getDescription());
        returnMap.put("dod", task.isDefinitionOfDone());

        if(task.getDue() == null) {
            returnMap.put("due", "");
        }
        else {
            returnMap.put("due", task.getFormattedDue());
        }

        return returnMap;
    }

    @GetMapping("/getProgress")
    public int getProgress(@RequestParam int id) {
        return taskRepository.findById(id).getProgress();
    }


    @GetMapping("/updateName")
    public void updateName(@RequestParam int id, @RequestParam String name) {
        Task t = taskRepository.findById(id);
        t.setName(name);
        taskRepository.save(t);
    }

    @GetMapping("/updateDescription")
    public void updateDescription(@RequestParam int id, @RequestParam String description) {
        Task t = taskRepository.findById(id);
        t.setDescription(description);
        taskRepository.save(t);
    }

    @GetMapping("/updateDod")
    public void updateDod(@RequestParam int id) {
        Task task = taskRepository.findById(id);
        task.setDefinitionOfDone(!task.isDefinitionOfDone());
        taskRepository.save(task);
    }

    @GetMapping("/updateDue")
    public void updateDue(@RequestParam int id, @RequestParam String due) throws ParseException {
        Task task = taskRepository.findById(id);
        Date date = new SimpleDateFormat("MM/dd/yyyy").parse(due);
        task.setDue(date);
        taskRepository.save(task);
    }

    @GetMapping("/updatePosition")
    public void updatePosition(@RequestParam int id, @RequestParam int position, @RequestParam String list) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId());
        Task task = taskRepository.findById(id);

        switch (list) {
            case "backlog-list":
                if(position > task.getPosition()) {
                    for(int i = position; i > task.getPosition(); i--) {
                        board.getBacklog().get(i).setPosition(i-1);
                    }
                }
                else if(position < task.getPosition()) {
                    for(int i = position; i < task.getPosition(); i++) {
                        board.getBacklog().get(i).setPosition(i+1);
                    }
                }
                break;
            case "todo-list":
                if(position > task.getPosition()) {
                    for(int i = position; i > task.getPosition(); i--) {
                        board.getTodo().get(i).setPosition(i-1);
                    }
                }
                else if(position < task.getPosition()) {
                    for(int i = position; i < task.getPosition(); i++) {
                        board.getTodo().get(i).setPosition(i+1);
                    }
                }
                break;
            case "inprogress-list":
                if(position > task.getPosition()) {
                    for(int i = position; i > task.getPosition(); i--) {
                        board.getInprogress().get(i).setPosition(i-1);
                    }
                }
                else if(position < task.getPosition()) {
                    for(int i = position; i < task.getPosition(); i++) {
                        board.getInprogress().get(i).setPosition(i+1);
                    }
                }
                break;
            case "complete-list":
                if(position > task.getPosition()) {
                    for(int i = position; i > task.getPosition(); i--) {
                        board.getComplete().get(i).setPosition(i-1);
                    }
                }
                else if(position < task.getPosition()) {
                    for(int i = position; i < task.getPosition(); i++) {
                        board.getComplete().get(i).setPosition(i+1);
                    }
                }
                break;
        }

        boardRepository.save(board);

        task.setPosition(position);
        taskRepository.save(task);
    }

    @GetMapping("/updateList")
    public void updateList(@RequestParam int id, @RequestParam int position, @RequestParam String list) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId());
        Task task = taskRepository.findById(id);

        // Copying contents of old task to new task
        Task copy = new Task(task.getName(), task.getDescription(), task.isDefinitionOfDone(), task.getProgress());
        copy.setComments(task.getComments());
        copy.setPosition(position);
        copy.setTodos(task.getTodos());

        // Adding new task to specified list in specified position
        switch (list) {
            case "backlog-list":
                for(int i=position; i<board.getBacklog().size(); i++) {
                    board.getBacklog().get(i).setPosition(i+1);
                }
                board.getBacklog().add(copy);
                for (User voter : task.getUsersVoted()) {
                    copy.getUsersVoted().add(voter);
                    voter.getVotedTasks().add(copy);
                    userRepository.save(voter);
                }
                taskRepository.delete(task);
                break;
            case "todo-list":
                for(int i=position; i<board.getTodo().size(); i++) {
                    board.getTodo().get(i).setPosition(i+1);
                }
                board.getTodo().add(copy);
                for (User voter : task.getUsersVoted()) {
                    copy.getUsersVoted().add(voter);
                    voter.getVotedTasks().add(copy);
                    userRepository.save(voter);
                }
                taskRepository.delete(task);
                break;
            case "inprogress-list":
                for(int i=position; i<board.getInprogress().size(); i++) {
                    board.getInprogress().get(i).setPosition(i+1);
                }
                board.getInprogress().add(copy);
                for (User voter : task.getUsersVoted()) {
                    copy.getUsersVoted().add(voter);
                    voter.getVotedTasks().add(copy);
                    userRepository.save(voter);
                }
                taskRepository.delete(task);
                break;
            case "complete-list":
                if (task.getProgress() != 100) {
                    taskRepository.delete(copy);
                }
                else {
                    for(int i=position; i<board.getComplete().size(); i++) {
                        board.getComplete().get(i).setPosition(i+1);
                    }
                    board.getComplete().add(copy);
                    for (User voter : task.getUsersVoted()) {
                        copy.getUsersVoted().add(voter);
                        voter.getVotedTasks().add(copy);
                        userRepository.save(voter);
                    }
                    taskRepository.delete(task);
                }
                break;
        }
        boardRepository.save(board);

    }
}
