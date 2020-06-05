package com.sprint.controller;

import com.sprint.domain.User;
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

    @PutMapping("/update/details")
    public void updateDetails(@RequestParam String fullname, @RequestParam String company, @RequestParam String bio) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        user.setFullname(fullname);
        user.setCompany(company);
        user.setBio(bio);
        userRepository.save(user);
    }

    @PostMapping("/update/password")
    public void updatePassword(@RequestParam String newPassword) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        String encodedNew = new BCryptPasswordEncoder().encode(newPassword);
        user.setPassword(encodedNew);
        userRepository.save(user);
    }
}
