package sa775.Sprint.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import sa775.Sprint.Domain.*;
import sa775.Sprint.Repository.BoardRepository;
import sa775.Sprint.Repository.TeamRoleRepository;
import sa775.Sprint.Repository.TaskRepository;
import sa775.Sprint.Repository.UserRepository;
import sa775.Sprint.Service.NotificationService;

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
    private TeamRoleRepository boardRoleRepository;
    @Autowired
    private TaskRepository taskRepository;
    @Autowired
    private NotificationService notificationService;

    @GetMapping("/delete")
    public String delete(@RequestParam(value = "id") int id) {
        taskRepository.deleteById(id);
        return "success" ;
    }

    @GetMapping("/add/backlog")
    public String addBacklog(@RequestParam(value = "name") String name) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId()).orElse(null);
        Task t = new Task();
        t.setName(name);
        t.setPosition(board.getBacklog().size()+1);
        board.addBacklog(t);
        boardRepository.save(board);

        return "success";
    }

    @GetMapping("/add/todo")
    public String addTodo(@RequestParam(value = "name") String name) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId()).orElse(null);
        Task t = new Task();
        t.setName(name);
        t.setPosition(board.getTodo().size()+1);
        board.addTodo(t);
        boardRepository.save(board);


        return "success";
    }

    @GetMapping("/add/inprogress")
    public String addInprogress(@RequestParam(value = "name") String name) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId()).orElse(null);
        Task t = new Task();
        t.setName(name);
        t.setPosition(board.getInprogress().size()+1);
        board.addInprogress(t);
        boardRepository.save(board);

        return "success";
    }

    @GetMapping("/add/complete")
    public String addComplete(@RequestParam(value = "name") String name) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId()).orElse(null);
        Task t = new Task();
        t.setName(name);
        t.setPosition(board.getComplete().size()+1);
        board.addComplete(t);
        boardRepository.save(board);

        return "success";
    }

    @GetMapping("/get")
    public HashMap<String, Object> get(@RequestParam(value = "id") int id) {
        Task task = taskRepository.findById(id);
        HashMap<String, Object> returnMap = new HashMap<>();
        returnMap.put("name", task.getName());
        returnMap.put("description", task.getDescription());
        returnMap.put("dod", task.isDefinitionOfDone());
        returnMap.put("complete", task.isComplete());
        returnMap.put("progress", task.getProgress());
        if(task.getDue() == null) {
            returnMap.put("due", "");
        }
        else {
            returnMap.put("due", task.getFormattedDue());
        }

        List<Comment> comments = taskRepository.findById(id).getComments();
        comments.sort(Comparator.comparing(Comment::getDatetime).reversed());
        returnMap.put("comments", comments);

        return returnMap;
    }

    @GetMapping("/save")
    public int save(@RequestParam(value = "id") int id, @RequestParam(value = "name") String name, @RequestParam(value = "description") String description, @RequestParam("dod") boolean dod, @RequestParam("complete") boolean complete) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId()).orElse(null);

        Task t = taskRepository.findById(id);
        t.setName(name);
        t.setDescription(description);
        t.setDefinitionOfDone(dod);
        t.setComplete(complete);
        taskRepository.save(t);

        return t.getProgress();
    }

    @GetMapping("/comment")
    public Comment addTaskComment(@RequestParam(value = "id") int id, @RequestParam(value = "comment") String comment) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId()).orElse(null);
        Task t = taskRepository.findById(id);
        Comment c = new Comment(user.getUsername(), comment);
        t.getComments().add(c);
        taskRepository.save(t);

        return c;
    }

    @GetMapping("/position")
    public String movePosition(@RequestParam(value = "id") int id, @RequestParam(value = "position") int position, @RequestParam(value = "list") String list) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId()).orElse(null);
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

        return "success";
    }

    @GetMapping("/move")
    public String moveTask(@RequestParam(value = "id") int id, @RequestParam(value = "position") int position, @RequestParam(value = "list") String list) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId()).orElse(null);

        // Copying contents of old task to new task and deleting old task
        Task t = taskRepository.findById(id);

        Task t1 = new Task(t.getName(), t.getDescription(), t.isDefinitionOfDone(), t.isComplete(), t.getProgress());
        t1.setComments(t.getComments());
        t1.setPosition(position);

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
                    return "failure";
                }
                for(int i=position; i<board.getComplete().size(); i++) {
                    board.getComplete().get(i).setPosition(i+1);
                }
                board.getComplete().add(t1);
                taskRepository.delete(t);
                break;
        }
        boardRepository.save(board);

        return "success";
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
