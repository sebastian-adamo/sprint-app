package sa775.Sprinting.Domain;

import org.junit.Before;
import org.junit.Test;
import org.testng.xml.dom.Tag;
import sa775.Sprint.Domain.Board;
import sa775.Sprint.Domain.Notification;
import sa775.Sprint.Domain.User;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import static org.junit.Assert.*;

public class NotificationTests {

    private Notification notification;
    private Date date;
    private Board board;

    @Before
    public void setupNotification() {
        notification = new Notification("Test");
        date = new Date();
        board = new Board("Test Board");
    }

    @Test
    public void testNotification() {
        assertEquals("Test", notification.getDescription());
        assertFalse(notification.isSeen());
        assertFalse(notification.isPending());
        assertEquals(date, notification.getDatetime());
        assertNull(notification.getBoard());
        assertEquals(0, notification.getUsers().size());
    }

    @Test
    public void testFormattedDate() {
        String formatted = new SimpleDateFormat("d MMM 'at' HH:mm").format(date);
        assertEquals(formatted, notification.getFormattedDate());
    }


    @Test
    @Tag(name = "Board")
    public void testAddBoard() {
        notification.setBoard(board);
        assertEquals(board, notification.getBoard());
    }

    @Test
    @Tag(name = "Board")
    public void testUpdateBoard() {
        notification.setBoard(board);
        board.setName("New Name");
        assertEquals("New Name", notification.getBoard().getName());
    }

    @Test
    @Tag(name = "Board")
    public void testRemoveBoard() {
        notification.setBoard(board);
        notification.setBoard(null);
        assertNotEquals(board, notification.getBoard());
    }

    @Test
    @Tag(name = "Users")
    public void testAddSingleUser() {
        User user = new User("admin", "admin@test.123", "admin");
        notification.getUsers().add(user);
        assertEquals(1, notification.getUsers().size());
        assertTrue(notification.getUsers().contains(user));
    }

    @Test
    @Tag(name = "Users")
    public void testAddMultipleUsers() {
        User user = new User("first", "first@test.123", "admin");
        User user1 = new User("second", "second@test.123", "admin");
        User user2 = new User("third", "third@test.123", "admin");
        notification.getUsers().addAll(Arrays.asList(user, user1, user2));
        assertEquals(3, notification.getUsers().size());
        assertTrue(notification.getUsers().contains(user));
        assertTrue(notification.getUsers().contains(user1));
        assertTrue(notification.getUsers().contains(user2));
    }
}
