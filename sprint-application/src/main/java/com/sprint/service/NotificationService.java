package com.sprint.service;

import com.sprint.domain.Board;
import com.sprint.domain.Notification;
import com.sprint.domain.User;
import com.sprint.repository.NotificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sprint.repository.UserRepository;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;
    @Autowired
    private UserRepository userRepository;

    public void notification(String message, User user) {
        Notification notification = new Notification(message);
        notificationRepository.save(notification);
        notification.getUsers().add(user);
        user.getNotifications().add(notification);
        notificationRepository.save(notification);
    }

    public void boardInvitation(User user, Board board) {
        Notification notification = new Notification("New invite to join board: '" + board.getName() + "'");
        notificationRepository.save(notification);
        notification.getUsers().add(user);
        user.getNotifications().add(notification);
        notification.setPending(true);
        notification.setBoard(board);
        notificationRepository.save(notification);
    }

    public void delete(Long id) {
        Notification notification = notificationRepository.findById(id).orElse(null);
        assert notification != null;
        notification.setBoard(null);
        notificationRepository.save(notification);
        notificationRepository.delete(notification);
    }
}
