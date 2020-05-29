package com.sprint.controller;

import com.sprint.domain.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/login")
public class LoginController {

    @RequestMapping("/error")
    public RedirectView loginError(@ModelAttribute("users") User user, RedirectAttributes redirectAttributes) {
        RedirectView redirectView = new RedirectView("/login", true);
        redirectAttributes.addFlashAttribute("invalid", true);
        return redirectView;
    }
}
