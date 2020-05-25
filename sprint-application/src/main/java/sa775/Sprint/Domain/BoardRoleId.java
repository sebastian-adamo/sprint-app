package sa775.Sprint.Domain;

import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class BoardRoleId implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long userId;
    private Long boardId;

    public BoardRoleId() {

    }

    public BoardRoleId(Long userId, Long boardId) {
        super();
        this.userId = userId;
        this.boardId = boardId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getBoardId() {
        return boardId;
    }

    public void setBoardId(Long boardId) {
        this.boardId = boardId;
    }
}
