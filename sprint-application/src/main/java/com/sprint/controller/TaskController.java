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
@RequestMapping("/tasks")
public class TaskController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BoardRepository boardRepository;
    @Autowired
    private TaskRepository taskRepository;
    @Autowired
    private TodoRepository todoRepository;

    @GetMapping("/add")
    public void add(@RequestParam(value = "name") String name, @RequestParam(value = "list") String list) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId());
        assert board != null;

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
    public void delete(@RequestParam(value = "id") int id) {
        taskRepository.deleteById(id);
    }

    @GetMapping("/vote")
    public void vote(@RequestParam(value = "id") int id) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Task task = taskRepository.findById(id);

        task.getUsersVoted().add(user);
        user.getVotedTasks().add(task);
        userRepository.save(user);
    }

    @GetMapping("/unvote")
    public void unvote(@RequestParam(value = "id") int id) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Task task = taskRepository.findById(id);

        task.getUsersVoted().remove(user);
        user.getVotedTasks().remove(task);
        userRepository.save(user);
    }

    @GetMapping("/get")
    public HashMap<String, Object> get(@RequestParam(value = "id") int id) {
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
    public int getProgress(@RequestParam(value = "id") int id) {
        return taskRepository.findById(id).getProgress();
    }

    @GetMapping("/getTodos")
    public List<Todo> getTodos(@RequestParam(value = "id") int id) {
        Task task = taskRepository.findById(id);
        task.getTodos().sort(Comparator.comparing(Todo::getCreated));
        return task.getTodos();
    }

    @GetMapping("/updateTodo")
    public void updateTodo(@RequestParam(value = "id") int id) {
        Todo todo = todoRepository.findById(id).orElse(null);
        assert todo != null;
        todo.setComplete(!todo.isComplete());
        todoRepository.save(todo);
    }

    @GetMapping("/addTodo")
    public void addTodo(@RequestParam(value = "id") int id, @RequestParam(value = "description") String description) {
        Task task = taskRepository.findById(id);
        Todo todo = new Todo(description);
        task.getTodos().add(todo);
        taskRepository.save(task);
    }

    @GetMapping("/getActivity")
    public List<Comment> getActivity(@RequestParam(value = "id") int id) {
        Task task = taskRepository.findById(id);
        task.getComments().sort(Comparator.comparing(Comment::getDatetime));
        return task.getComments();
    }

    @GetMapping("/addComment")
    public Comment addComment(@RequestParam(value = "id") int id, @RequestParam(value = "description") String description) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Task task = taskRepository.findById(id);
        Comment comment = new Comment(user.getUsername(), description);
        task.getComments().add(comment);
        taskRepository.save(task);
        return comment;
    }

    @GetMapping("/saveName")
    public void saveName(@RequestParam(value = "id") int id, @RequestParam(value = "name") String name) {
        Task t = taskRepository.findById(id);
        t.setName(name);
        taskRepository.save(t);
    }

    @GetMapping("/saveDescription")
    public void saveDescription(@RequestParam(value = "id") int id, @RequestParam(value = "description") String description) {
        Task t = taskRepository.findById(id);
        t.setDescription(description);
        taskRepository.save(t);
    }

    @GetMapping("/updateDod")
    public void updateDod(@RequestParam(value = "id") int id) {
        Task task = taskRepository.findById(id);
        task.setDefinitionOfDone(!task.isDefinitionOfDone());
        taskRepository.save(task);
    }

    @GetMapping("/setDue")
    public void setDue(@RequestParam(value = "id") int id, @RequestParam(value = "due") String due) throws ParseException {
        Task task = taskRepository.findById(id);
        Date date = new SimpleDateFormat("MM/dd/yyyy").parse(due);
        task.setDue(date);
        taskRepository.save(task);
    }

    @GetMapping("/position")
    public void movePosition(@RequestParam(value = "id") int id, @RequestParam(value = "position") int position, @RequestParam(value = "list") String list) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId());
        assert board != null;
        Task t = taskRepository.findById(id);
        switch(list) {
            case "backlog-list":
                if(position > t.getPosition()) {
                    for(int i = position; i > t.getPosition(); i--) {
                        board.getBacklog().get(i).setPosition(i-1);
                    }
                }
                else if(position < t.getPosition()) {
                    for(int i = position; i < t.getPosition(); i++) {
                        board.getBacklog().get(i).setPosition(i+1);
                    }
                }
                break;
            case "todo-list":
                if(position > t.getPosition()) {
                    for(int i = position; i > t.getPosition(); i--) {
                        board.getTodo().get(i).setPosition(i-1);
                    }
                }
                else if(position < t.getPosition()) {
                    for(int i = position; i < t.getPosition(); i++) {
                        board.getTodo().get(i).setPosition(i+1);
                    }
                }
                break;
            case "inprogress-list":
                if(position > t.getPosition()) {
                    for(int i = position; i > t.getPosition(); i--) {
                        board.getInprogress().get(i).setPosition(i-1);
                    }
                }
                else if(position < t.getPosition()) {
                    for(int i = position; i < t.getPosition(); i++) {
                        board.getInprogress().get(i).setPosition(i+1);
                    }
                }
                break;
            case "complete-list":
                if(position > t.getPosition()) {
                    for(int i = position; i > t.getPosition(); i--) {
                        board.getComplete().get(i).setPosition(i-1);
                    }
                }
                else if(position < t.getPosition()) {
                    for(int i = position; i < t.getPosition(); i++) {
                        board.getComplete().get(i).setPosition(i+1);
                    }
                }
                break;
        }
        boardRepository.save(board);

        t.setPosition(position);
        taskRepository.save(t);
    }

    @GetMapping("/move")
    public void moveTask(@RequestParam(value = "id") int id, @RequestParam(value = "position") int position, @RequestParam(value = "list") String list) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId());
        assert board != null;
        // Copying contents of old task to new task and deleting old task
        Task t = taskRepository.findById(id);

        Task t1 = new Task(t.getName(), t.getDescription(), t.isDefinitionOfDone(), t.getProgress());
        t1.setComments(t.getComments());
        t1.setPosition(position);
        t1.setTodos(t.getTodos());

        boolean voted = t.getUsersVoted().contains(user);

        // Adding new task to specified list in specified position
        switch(list) {
            case "backlog-list":
                for(int i=position; i<board.getBacklog().size(); i++) {
                    board.getBacklog().get(i).setPosition(i+1);
                }
                board.getBacklog().add(t1);
                taskRepository.delete(t);
                break;
            case "todo-list":
                for(int i=position; i<board.getTodo().size(); i++) {
                    board.getTodo().get(i).setPosition(i+1);
                }
                board.getTodo().add(t1);
                taskRepository.delete(t);
                break;
            case "inprogress-list":
                for(int i=position; i<board.getInprogress().size(); i++) {
                    board.getInprogress().get(i).setPosition(i+1);
                }
                board.getInprogress().add(t1);
                taskRepository.delete(t);
                break;
            case "complete-list":
                if (t.getProgress() != 100) {
                    taskRepository.delete(t1);
                }
                for(int i=position; i<board.getComplete().size(); i++) {
                    board.getComplete().get(i).setPosition(i+1);
                }
                board.getComplete().add(t1);
                taskRepository.delete(t);
                break;
        }
        boardRepository.save(board);

        if (voted) {
            t1.getUsersVoted().add(user);
            user.getVotedTasks().add(t1);
            userRepository.save(user);
        }
    }

    @GetMapping("/date")
    public String date(@RequestParam("id") int id, @RequestParam("date") String date) throws ParseException {
        Date d = new SimpleDateFormat("MM/dd/yyyy").parse(date);
        Task task = taskRepository.findById(id);
        task.setDue(d);
        taskRepository.save(task);
        return "success";
    }
}
