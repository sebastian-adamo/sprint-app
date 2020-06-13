package com.sprint.repository;

import com.sprint.domain.Todo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TodoRepository extends JpaRepository<Todo, Integer> {
    Todo findById(int id);
}
