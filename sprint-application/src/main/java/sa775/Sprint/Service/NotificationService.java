package sa775.Sprint.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sa775.Sprint.Domain.Board;
import sa775.Sprint.Domain.Notification;
import sa775.Sprint.Domain.User;
import sa775.Sprint.Repository.NotificationRepository;
import sa775.Sprint.Repository.UserRepository;

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
