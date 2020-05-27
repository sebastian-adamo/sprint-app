package sa775.Sprinting.Controller;

import org.junit.Before;
import org.junit.Test;
import org.testng.xml.dom.Tag;
import sa775.Sprint.Domain.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;

public class BoardControllerTests {

    private User user;
    private Board board;
    private TeamRole boardRole;

    @Before
    public void setup() {
        user = new User("admin", "admin@sprint.com", "admin");
        board = new Board("Test Board");
        boardRole = new TeamRole(user, board, "Product Owner");
        board.setOwner(user);
        // Mock TODO List
        board.getTodo().add(new Task("Task 1", "Task 1", false, false, 0));
        board.getTodo().add(new Task("Task 2", "Task 2", false, false, 0));
    }

    public HashMap<String, Object> getMock() {
        HashMap<String, Object> returnMap = new HashMap<>();
        returnMap.put("name", board.getName());
        if (board.getDescription() == null) {
            returnMap.put("description", "");
        }
        else {
            returnMap.put("description", board.getDescription());
        }
        if (board.getDefinitionOfDone() == null) {
            returnMap.put("dod", "");
        }
        else {
            returnMap.put("dod", board.getDefinitionOfDone());
        }

        // Owner
        returnMap.put("owner", board.getOwner().getUsername());

        // Users
        List<HashMap<String, String>> userDetails = new ArrayList<>();
        user = boardRole.getUser();
        HashMap<String, String> userDetail = new HashMap<>();
        userDetail.put("username", user.getUsername());
        userDetail.put("fullname", user.getFullname());
        userDetail.put("email", user.getEmail());
        if  (boardRole.getRole().equals("Product Owner")) {
            userDetail.put("role", "Product Owner");
            userDetail.put("roleAlt", "Scrum Master");
            userDetail.put("roleAlt1", "Developer");
        }
        else if  (boardRole.getRole().equals("Scrum Master")){
            userDetail.put("role", "Scrum Master");
            userDetail.put("roleAlt", "Product Owner");
            userDetail.put("roleAlt1", "Developer");
        }
        else {
            userDetail.put("role", "Developer");
            userDetail.put("roleAlt", "Scrum Master");
            userDetail.put("roleAlt1", "Product Owner");
        }
        userDetails.add(userDetail);

        returnMap.put("users", userDetails);
        return returnMap;
    }

    @Test
    @Tag(name = "Get")
    public void testGet_BoardDetailsNoDescription() {
        board.setDefinitionOfDone("Definition of Done");
        HashMap<String, Object> boardDetails = getMock();
        assertEquals(board.getName(), boardDetails.get("name"));
        assertEquals("", boardDetails.get("description"));
        assertEquals(board.getDefinitionOfDone(), boardDetails.get("dod"));
    }

    @Test
    @Tag(name = "Get")
    public void testGet_BoardDetailsNoDefinitionOfDone() {
        board.setDescription("Description");
        HashMap<String, Object> boardDetails = getMock();
        assertEquals(board.getName(), boardDetails.get("name"));
        assertEquals(board.getDescription(), boardDetails.get("description"));
        assertEquals("", boardDetails.get("dod"));
    }

    @Test
    @Tag(name = "Get")
    public void testGet_Owner() {
        HashMap<String, Object> boardDetails = getMock();
        assertEquals(board.getOwner().getUsername(), boardDetails.get("owner"));
    }

    @Test
    @Tag(name = "Get")
    public void testGet_UserDetailsSize() {
        HashMap<String, Object> boardDetails = getMock();
        List<HashMap<String, String>> userDetails = (List<HashMap<String, String>>) boardDetails.get("users");
        assertEquals(1, userDetails.size());
    }

    @Test
    @Tag(name = "Get")
    public void testGet_UserDetailsUser() {
        HashMap<String, Object> boardDetails = getMock();
        List<HashMap<String, String>> userDetails = (List<HashMap<String, String>>) boardDetails.get("users");
        assertEquals(user.getUsername(), userDetails.get(0).get("username"));
        assertEquals(user.getFullname(), userDetails.get(0).get("fullname"));
        assertEquals(user.getEmail(), userDetails.get(0).get("email"));
    }

    @Test
    @Tag(name = "Get")
    public void testGet_UserDetailsUserRole() {
        HashMap<String, Object> boardDetails = getMock();
        List<HashMap<String, String>> userDetails = (List<HashMap<String, String>>) boardDetails.get("users");
        assertEquals(boardRole.getRole(), userDetails.get(0).get("role"));
    }

    public void changeRoleMock(String role) {
        if (role.equals("Product Owner")) {
            boardRole.setRole("Product Owner");
        }
        else if(role.equals("Scrum Master")) {
            boardRole.setRole("Scrum Master");
        }
        else {
            boardRole.setRole("Developer");
        }
    }

    @Test
    @Tag(name = "Change Role")
    public void testChangeRole_ScrumMaster() {
        changeRoleMock("Scrum Master");
        assertEquals(boardRole.getRole(), "Scrum Master");
    }

    @Test
    @Tag(name = "Change Role")
    public void testChangeRole_Developer() {
        changeRoleMock("Developer");
        assertEquals(boardRole.getRole(), "Developer");
    }

    @Test
    @Tag(name = "Change Role")
    public void testChangeRole_ProductOwner() {
        boardRole.setRole("Scrum Master");
        changeRoleMock("Product Owner");
        assertEquals(boardRole.getRole(), "Product Owner");
    }
}
