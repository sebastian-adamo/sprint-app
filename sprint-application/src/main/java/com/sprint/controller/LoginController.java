package com.sprint.controller;

import com.sprint.domain.User;
import com.sprint.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/login")
public class LoginController {

    @RequestMapping("/error")
    public RedirectView error(@ModelAttribute("users") User user, RedirectAttributes redirectAttributes) {
        RedirectView redirectView = new RedirectView("/login", true);
        redirectAttributes.addFlashAttribute("invalid", true);
        return redirectView;
    }

}
