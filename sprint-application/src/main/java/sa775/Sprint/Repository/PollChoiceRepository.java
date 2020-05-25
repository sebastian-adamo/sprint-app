package sa775.Sprint.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sa775.Sprint.Domain.PollChoice;

public interface PollChoiceRepository extends JpaRepository<PollChoice, Long> {
}
