package com.sprint.controller;

import com.sprint.domain.Task;
import com.sprint.domain.Todo;
import com.sprint.repository.TaskRepository;
import com.sprint.repository.TodoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Comparator;
import java.util.List;

@RestController
@RequestMapping("/todo")
public class TodoController {

    @Autowired
    private TaskRepository taskRepository;
    @Autowired
    private TodoRepository todoRepository;

    @GetMapping("/add")
    public void add(@RequestParam int id, @RequestParam String description) {
        Task task = taskRepository.findById(id);
        Todo todo = new Todo(description);
        task.getTodos().add(todo);
        taskRepository.save(task);
    }

    @GetMapping("/getAll")
    public List<Todo> getAll(@RequestParam int id) {
        Task task = taskRepository.findById(id);
        task.getTodos().sort(Comparator.comparing(Todo::getCreated));
        return task.getTodos();
    }

    @GetMapping("/update")
    public void update(@RequestParam int id) {
        Todo todo = todoRepository.findById(id);
        todo.setComplete(!todo.isComplete());
        todoRepository.save(todo);
    }

    //DELETE

}
