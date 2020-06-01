package com.sprint.controller;

import com.sprint.domain.Board;
import com.sprint.domain.User;
import com.sprint.repository.BoardRepository;
import com.sprint.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BoardRepository boardRepository;

    @GetMapping("/add")
    public void add(@RequestParam String name, @RequestParam String description, @RequestParam String dod) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = new Board(name, description, dod);
        user.getMyBoards().add(board);
        userRepository.save(user);
    }

    @GetMapping("/get")
    public HashMap<String, Object> get(@RequestParam int id) {
        Board board = boardRepository.findById(id);
        HashMap<String, Object> returnMap = new HashMap<>();

        returnMap.put("name", board.getName());
        returnMap.put("description", board.getDescription());
        returnMap.put("dod", board.getDefinitionOfDone());

        return returnMap;
    }

    @GetMapping("/delete")
    public void delete(@RequestParam int id) {
        boardRepository.deleteById(id);
    }

    @GetMapping("/update")
    public void update(@RequestParam int id, @RequestParam String name, @RequestParam String description, @RequestParam String dod) {
        Board b = boardRepository.findById(id);
        b.setName(name);
        b.setDescription(description);
        b.setDefinitionOfDone(dod);
        boardRepository.save(b);
    }

}
