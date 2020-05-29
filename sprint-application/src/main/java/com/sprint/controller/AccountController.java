package com.sprint.controller;

import com.sprint.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import com.sprint.repository.UserRepository;
import com.sprint.service.NotificationService;

@RestController
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private NotificationService notificationService;

    @GetMapping("/save")
    public String saveAccountDetails(@RequestParam("fullname") String fullname, @RequestParam("company") String company, @RequestParam("bio") String bio) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        user.setFullname(fullname);
        user.setCompany(company);
        user.setBio(bio);
        userRepository.save(user);

        // Notification
        notificationService.notification("Account details have been updated", user);

        return "success";
    }

    @GetMapping("/password")
    public String savePassword(@RequestParam("new") String newPassword) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        String encodedNew = new BCryptPasswordEncoder().encode(newPassword);
        user.setPassword(encodedNew);
        userRepository.save(user);

        // Notification
        notificationService.notification("Password has been updated", user);

        return "success";
    }
}
