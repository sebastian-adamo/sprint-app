package sa775.Sprinting.Controller;

import org.junit.Before;
import org.junit.Test;
import org.testng.xml.dom.Tag;
import sa775.Sprint.Domain.*;

import java.util.Date;
import java.util.HashMap;

import static org.junit.Assert.assertEquals;

public class TaskControllerTests {

    private User user;
    private Board board;
    private BoardRole boardRole;

    @Before
    public void setup() {
        user = new User("admin", "admin@sprint.com", "admin");
        board = new Board("Test Board");
        boardRole = new BoardRole(user, board, "Product Owner");
        board.setOwner(user);
        // Mock TODO List
        board.getBacklog().add(new Task("Task 0", "Task 0", false, false, 0));
        board.getTodo().add(new Task("Task 1", "Task 1", false, false, 0));
        board.getTodo().add(new Task("Task 2", "Task 2", false, false, 0));
        board.getTodo().add(new Task("Task 3", "Task 3", false, false, 0));
        board.getInprogress().add(new Task("Task 4", "Task 4", true, false, 50));
        board.getComplete().add(new Task("Task 5", "Task 5", false, false, 100));
    }

    public HashMap<String, Object> getMock() {
        // Getting random task for use in testing
        Task task = board.getTodo().get(1);

        HashMap<String, Object> returnMap = new HashMap<>();
        returnMap.put("name", task.getName());
        returnMap.put("description", task.getDescription());
        returnMap.put("dod", task.isDefinitionOfDone());
        returnMap.put("complete", task.isComplete());
        returnMap.put("progress", task.getProgress());
        if(task.getDue() == null) {
            returnMap.put("due", "");
        }
        else {
            returnMap.put("due", task.getFormattedDue());
        }

//        comments.sort(Comparator.comparing(Comment::getDatetime).reversed());
//        returnMap.put("comments", comments);

        return returnMap;
    }

    @Test
    @Tag(name = "Get")
    public void testGet_TaskDetails() {
        Task task = board.getTodo().get(1);
        HashMap<String, Object> taskDetails = getMock();

        assertEquals(task.getName(), taskDetails.get("name"));
        assertEquals(task.getDescription(), taskDetails.get("description"));
    }

    @Test
    @Tag(name = "Get")
    public void testGet_IsNotDod() {
        Task task = board.getTodo().get(1);
        HashMap<String, Object> taskDetails = getMock();

        assertEquals(task.isDefinitionOfDone(), taskDetails.get("dod"));
        assertEquals(task.getProgress(), taskDetails.get("progress"));
    }

    @Test
    @Tag(name = "Get")
    public void testGet_IsDod() {
        Task task = board.getTodo().get(1);
        task.setDefinitionOfDone(true);
        HashMap<String, Object> taskDetails = getMock();

        assertEquals(task.isDefinitionOfDone(), taskDetails.get("dod"));
        assertEquals(task.getProgress(), taskDetails.get("progress"));
    }

    @Test
    @Tag(name = "Get")
    public void testGet_IsNotComplete() {
        Task task = board.getTodo().get(1);
        HashMap<String, Object> taskDetails = getMock();

        assertEquals(task.isComplete(), taskDetails.get("complete"));
        assertEquals(task.getProgress(), taskDetails.get("progress"));
    }

    @Test
    @Tag(name = "Get")
    public void testGet_IsTaskComplete() {
        Task task = board.getTodo().get(1);
        task.setComplete(true);
        HashMap<String, Object> taskDetails = getMock();

        assertEquals(task.isComplete(), taskDetails.get("complete"));
        assertEquals(task.getProgress(), taskDetails.get("progress"));
    }

    @Test
    @Tag(name = "Get")
    public void testGet_NullDate() {
        Task task = board.getTodo().get(1);
        HashMap<String, Object> taskDetails = getMock();

        assertEquals("", taskDetails.get("due"));
    }

    @Test
    @Tag(name = "Get")
    public void testGet_Date() {
        Task task = board.getTodo().get(1);
        task.setDue(new Date());
        HashMap<String, Object> taskDetails = getMock();

        assertEquals(task.getFormattedDue(), taskDetails.get("due"));
    }

}
