package com.sprint.controller;

import com.sprint.domain.User;
import com.sprint.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/recovery")
public class RecoveryController {

    @Autowired
    private JavaMailSender javaMailSender;
    @Autowired
    private UserRepository userRepository;

    @GetMapping("/check-email")
    public boolean checkEmail(@RequestParam String email) {
        return userRepository.existsByEmail(email);
    }

    @GetMapping("/send")
    public void recovery(@RequestParam String email) {
        User to = userRepository.findByEmail(email);
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to.getEmail());
        message.setSubject("Sprint Password Recovery");
        message.setText("You have recently requested a password reset. Click the below link to be redirected to a secure site in which you can set a new password.");
        javaMailSender.send(message);
    }
}
