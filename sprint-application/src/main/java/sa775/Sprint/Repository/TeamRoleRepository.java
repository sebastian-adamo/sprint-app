package sa775.Sprint.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sa775.Sprint.Domain.Board;
import sa775.Sprint.Domain.TeamRole;
import sa775.Sprint.Domain.User;

import java.util.List;

public interface TeamRoleRepository extends JpaRepository<TeamRole, Long> {
    List<TeamRole> findAllByTeamId(int teamId);
    void deleteAllByTeamId(int teamId);
}
