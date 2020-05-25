package sa775.Sprint.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sa775.Sprint.Domain.Team;

public interface TeamRepository extends JpaRepository<Team, Integer> {
}
