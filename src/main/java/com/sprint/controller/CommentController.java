package com.sprint.controller;

import com.sprint.domain.Comment;
import com.sprint.domain.Task;
import com.sprint.domain.User;
import com.sprint.repository.CommentRepository;
import com.sprint.repository.TaskRepository;
import com.sprint.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.Comparator;
import java.util.List;

@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private TaskRepository taskRepository;
    @Autowired
    private CommentRepository commentRepository;

    @PostMapping("/add")
    public void add(@RequestParam int id, @RequestParam String description) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Task task = taskRepository.findById(id);
        Comment comment = new Comment(user.getUsername(), description);
        task.getComments().add(comment);
        taskRepository.save(task);
    }

    @GetMapping("/getAll")
    public List<Comment> getAll(@RequestParam int id) {
        Task task = taskRepository.findById(id);
        task.getComments().sort(Comparator.comparing(Comment::getDatetime));
        return task.getComments();
    }

    @DeleteMapping("/delete")
    public void delete(@RequestParam int id) {
        commentRepository.deleteById(id);
    }

    //UPDATE

    //DELETE
}
