package sa775.Sprint.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sa775.Sprint.Domain.Board;
import sa775.Sprint.Domain.BoardRole;
import sa775.Sprint.Domain.User;

import java.util.List;

public interface BoardRoleRepository extends JpaRepository<BoardRole, Long> {
    List<BoardRole> findAllByUserId(Long id);
    List<BoardRole> findAllByBoardId(Long id);
    List<BoardRole> findAllByBoard(Board board);
    BoardRole findByUserAndBoard(User user, Board board);
    BoardRole findByUserEmail(String email);
}
