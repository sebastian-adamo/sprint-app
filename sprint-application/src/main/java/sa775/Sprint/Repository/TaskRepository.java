package sa775.Sprint.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import sa775.Sprint.Domain.Task;

public interface TaskRepository extends JpaRepository<Task, Integer> {
    Task findById(int id);
}
