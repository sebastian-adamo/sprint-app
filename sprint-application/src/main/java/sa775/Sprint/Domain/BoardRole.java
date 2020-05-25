package sa775.Sprint.Domain;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;

@Entity
public class BoardRole {

    @EmbeddedId
    private BoardRoleId id = new BoardRoleId();

    @ManyToOne
    @MapsId("userId")
    private User user;

    @ManyToOne
    @MapsId("boardId")
    private Board board;

    private String role; // Product Owner, Scrum Master, Developer

    public BoardRole () {}

    public BoardRole(User user, Board board, String role) {
        this.user = user;
        this.board = board;
        this.role = role;
    }

    public BoardRoleId getId() {
        return id;
    }

    public void setId(BoardRoleId id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Board getBoard() {
        return board;
    }

    public void setBoard(Board board) {
        this.board = board;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
