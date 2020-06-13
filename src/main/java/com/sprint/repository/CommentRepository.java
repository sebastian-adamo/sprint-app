package com.sprint.repository;

import com.sprint.domain.Comment;
import org.springframework.data.repository.CrudRepository;

public interface CommentRepository extends CrudRepository<Comment, Integer> {
    Comment findById(int id);
}
