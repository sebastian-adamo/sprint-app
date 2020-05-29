package com.sprint.repository;

import com.sprint.domain.TeamRole;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TeamRoleRepository extends JpaRepository<TeamRole, Long> {
    List<TeamRole> findAllByTeamId(int teamId);
    void deleteAllByTeamId(int teamId);
}
