package com.sprint.controller;

import com.sprint.domain.Board;
import com.sprint.domain.User;
import com.sprint.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import com.sprint.repository.UserRepository;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BoardRepository boardRepository;

    @PutMapping("/updateName")
    public void updateName(@RequestParam String name) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        user.setName(name);
        userRepository.save(user);
    }

    @PutMapping("/updateCompany")
    public void updateCompany(@RequestParam String company) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        user.setCompany(company);
        userRepository.save(user);
    }

    @PutMapping("/updateBio")
    public void updateBio(@RequestParam String bio) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        user.setBio(bio);
        userRepository.save(user);
    }

    @PutMapping("/updateRecent")
    public void updateRecent(@RequestParam int id) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(id);
        if (!user.getRecentBoards().contains(board)) {
            user.addRecentBoard(board);
            userRepository.save(user);
        }
    }
//
//    @PostMapping("/updatePassword")
//    public String updatePassword(@RequestParam String password) {
//        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
//        String encoded = new BCryptPasswordEncoder().encode(password);
//        user.setPassword(encoded);
//        userRepository.save(user);
//    }
}
