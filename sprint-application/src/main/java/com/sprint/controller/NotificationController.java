package com.sprint.controller;

import com.sprint.domain.Notification;
import com.sprint.domain.User;
import com.sprint.repository.NotificationRepository;
import com.sprint.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/notifications")
public class NotificationController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private NotificationRepository notificationRepository;

    @GetMapping("/refresh")
    public String refresh(@RequestParam("id") Long id) {
        Notification notification = notificationRepository.findById(id)
                .orElse(null);
        assert notification != null;
        notification.setSeen(true);
        notificationRepository.save(notification);
        return "success";
    }

    @GetMapping("/clear")
    public String clear() {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        for (Notification notification : user.getNotifications()) {
            notificationRepository.delete(notification);
        }
        return "success";
    }

}
