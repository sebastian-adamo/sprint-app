package sa775.Sprint.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sa775.Sprint.Domain.Todo;

public interface TodoRepository extends JpaRepository<Todo, Integer> {
}
