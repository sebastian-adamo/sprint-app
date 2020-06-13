package com.sprint.repository;

import com.sprint.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findById(int id);
    User findByUsername(String username);
    User findByEmail(String email);

    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
}
