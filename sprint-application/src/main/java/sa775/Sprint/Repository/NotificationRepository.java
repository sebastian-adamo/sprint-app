package sa775.Sprint.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sa775.Sprint.Domain.Notification;

public interface NotificationRepository extends JpaRepository<Notification, Long> {
}
