package sa775.Sprint.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sa775.Sprint.Domain.Poll;

public interface PollRepository extends JpaRepository<Poll, Long> {
}
