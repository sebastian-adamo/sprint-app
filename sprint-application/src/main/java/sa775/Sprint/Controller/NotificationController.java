package sa775.Sprint.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import sa775.Sprint.Domain.Notification;
import sa775.Sprint.Domain.User;
import sa775.Sprint.Repository.NotificationRepository;
import sa775.Sprint.Repository.UserRepository;

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
