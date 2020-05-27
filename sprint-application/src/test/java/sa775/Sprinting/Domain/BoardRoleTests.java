package sa775.Sprinting.Domain;

import org.junit.Before;
import org.junit.Test;
import sa775.Sprint.Domain.Board;
import sa775.Sprint.Domain.TeamRole;
import sa775.Sprint.Domain.User;

import static org.junit.Assert.assertEquals;

public class BoardRoleTests {

    private TeamRole boardRole;
    private Board board;
    private User user;

    @Before
    public void setup() {
        board = new Board("Board");
        user = new User("admin", "admin@sprint.com", "admin");
        boardRole = new TeamRole(user, board, "Product Owner");
    }

    @Test
    public void testCreation() {
        assertEquals(board, boardRole.getBoard());
        assertEquals(user, boardRole.getUser());
        assertEquals("Product Owner", boardRole.getRole());
    }

    @Test
    public void testRoleChange_ScrumMaster() {
        boardRole.setRole("Scrum Master");
        assertEquals("Scrum Master", boardRole.getRole());
    }

    @Test
    public void testRoleChange_Developer() {
        boardRole.setRole("Developer");
        assertEquals("Developer", boardRole.getRole());
    }

}
