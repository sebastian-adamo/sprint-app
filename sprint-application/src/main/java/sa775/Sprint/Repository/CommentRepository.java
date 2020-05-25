package sa775.Sprint.Repository;

import org.springframework.data.repository.CrudRepository;
import sa775.Sprint.Domain.Comment;

public interface CommentRepository extends CrudRepository<Comment, Integer> {
    Comment findById(int id);
}
