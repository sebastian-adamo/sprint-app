package com.sprint.controller;

import com.sprint.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;
import com.sprint.repository.UserRepository;

@Controller
@RequestMapping("/register")
public class RegisterController {

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/submit")
    public String registerSubmit(@ModelAttribute("users") User user) {
        if (userRepository.existsByUsername(user.getUsername())) {
            return "redirect:/register/user-error";
        }
        else if (userRepository.existsByEmail(user.getEmail())) {
            return "redirect:/register/user-error";
        }
        else {
            BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
            User u = new User(user.getUsername(), user.getEmail(), encoder.encode(user.getPassword()));
            userRepository.save(u);
            return "redirect:/login";
        }
    }

    @RequestMapping("/user-error")
    @ResponseBody
    public String registerError(@RequestParam("email") String email) {
        if (userRepository.existsByEmail(email)) {
            return "exists";
        }
        else {
            return "free";
        }
    }

    @PostMapping("/get-started")
    public RedirectView registerGetStarted(@RequestParam("email") String email, RedirectAttributes redirectAttributes) {
        RedirectView redirectView = new RedirectView("/register", true);
        redirectAttributes.addFlashAttribute("email", email);
        return redirectView;
    }
}
