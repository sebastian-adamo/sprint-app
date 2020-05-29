package com.sprint.controller;

import com.sprint.domain.Board;
import com.sprint.domain.Notification;
import com.sprint.domain.User;
import com.sprint.repository.BoardRepository;
import com.sprint.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
public class MainController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BoardRepository boardRepository;

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register(@ModelAttribute("users") User user) {
        return "register";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        user.getMyBoards().sort(Comparator.comparing(Board::getCreated));

        model.addAttribute("user", user);

        // Notifications
        List<Notification> notifications = new ArrayList<>(user.getNotifications());
        notifications.sort(Comparator.comparing(Notification::getDatetime).reversed());
        //Length
        int notificationsLength = 0;
        for (Notification notification : user.getNotifications()) {
            if (!notification.isSeen()) {
                notificationsLength++;
            }
        }
        model.addAttribute("notifications", notifications);
        model.addAttribute("notificationsLength", notificationsLength);

        return "dashboard";
    }

    @GetMapping("/tasks")
    public String tasks(Model model, @RequestParam(value = "id") Long id) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        user.setCurrentBoardId(id);
        userRepository.save(user);

        // Notifications
        List<Notification> notifications = new ArrayList<>(user.getNotifications());
        notifications.sort(Comparator.comparing(Notification::getDatetime).reversed());
        //Length
        int notificationsLength = 0;
        for (Notification notification : user.getNotifications()) {
            if (!notification.isSeen()) {
                notificationsLength++;
            }
        }

        Board board = boardRepository.findById(id).orElse(null);

        model.addAttribute("user", user);
        model.addAttribute("board", board);
        model.addAttribute("notifications", notifications);
        model.addAttribute("notificationsLength", notificationsLength);

        return "tasks";
    }
}