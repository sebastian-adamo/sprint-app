package sa775.Sprinting.Controller;

import org.junit.Before;
import org.junit.Test;
import org.testng.xml.dom.Tag;
import sa775.Sprint.Domain.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class PollControllerTests {

    private Poll poll;
    private User user;
    private Board board;

    @Before
    public void setup() {
        user = new User("admin", "admin@sprint.com", "admin");
        board = new Board("Test Board");
        // Mock TODO List
        board.getTodo().add(new Task("Task 1", "Task 1", false, false, 0));
        board.getTodo().add(new Task("Task 2", "Task 2", false, false, 0));
        createMock();
    }

    public void createMock() {
        poll = new Poll("Testing the Poll Controller");
        poll.setCreator(user);

        for (Task task: board.getTodo()) {
            poll.getChoices().add(new PollChoice(task.getName()));
        }

        board.getPolls().add(poll);
    }

    @Test
    @Tag(name = "Create")
    public void testCreate_PollAddedToBoard() {
        assertEquals(1, board.getPolls().size());
        assertTrue(board.getPolls().contains(poll));
    }

    @Test
    @Tag(name = "Create")
    public void testCreate_PollCreator() {
        assertEquals(user, poll.getCreator());
    }

    @Test
    @Tag(name = "Create")
    public void testCreate_PollChoices() {
        assertEquals(2, poll.getChoices().size());
        assertEquals(board.getTodo().get(0).getName(), poll.getChoices().get(0).getDescription());
        assertEquals(board.getTodo().get(1).getName(), poll.getChoices().get(1).getDescription());
    }

    public HashMap<String, Object> getMock() {
        HashMap<String, Object> pollInfo = new HashMap<String, Object>();
        pollInfo.put("question", poll.getQuestion());
        pollInfo.put("choices", poll.getChoices());
        return pollInfo;
    }

    @Test
    @Tag(name = "Get")
    public void testGet() {
        HashMap<String, Object> info = getMock();
        assertEquals(info.get("question"), poll.getQuestion());
        assertEquals(info.get("choices"), poll.getChoices());
    }

    public void voteMock() {
        poll.getVoters().add(user);
        user.getPolls().add(poll);

        PollChoice pollChoice = poll.getChoices().get(0);
        pollChoice.addVotes(1);
    }

    @Test
    @Tag(name = "Vote")
    public void testVote() {
        voteMock();
        assertTrue(poll.getVoters().contains(user));
        assertTrue(user.getPolls().contains(poll));
        assertEquals(1, poll.getChoices().get(0).getVotes());
    }

}
