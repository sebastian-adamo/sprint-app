package sa775.Sprint.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import sa775.Sprint.Domain.Board;

import java.util.List;

public interface BoardRepository extends JpaRepository<Board, Long> {
}
