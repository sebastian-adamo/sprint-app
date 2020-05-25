package sa775.Sprinting.Controller;

import org.junit.Before;
import org.junit.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.testng.xml.dom.Tag;
import sa775.Sprint.Domain.Notification;
import sa775.Sprint.Domain.User;

import static org.junit.Assert.*;

public class AccountControllerTests {

    private User user;
    private User copy;

    @Before
    public void setup() {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        user = new User("admin", "admin@sprint.com", encoder.encode("admin"));
        copy = new User("admin", "admin@sprint.com", encoder.encode("admin"));
    }

    public void saveAccountDetailsMock() {
        user.setFullname("Test User");
        user.setCompany("Testing Company");
        user.setBio("Testing Bio");

        Notification notification = new Notification("Account details have been updated");
        notification.getUsers().add(user);
        user.getNotifications().add(notification);
    }

    @Test
    @Tag(name = "Details")
    public void testSaveAccountDetails() {

        saveAccountDetailsMock();

        assertNotEquals(copy.getFullname(), user.getFullname());
        assertNotEquals(copy.getCompany(), user.getCompany());
        assertNotEquals(copy.getBio(), user.getBio());

        assertEquals("Test User", user.getFullname());
        assertEquals("Testing Company", user.getCompany());
        assertEquals("Testing Bio", user.getBio());
    }

    @Test
    @Tag(name = "Details")
    public void testSaveAccountDetails_Notification() {
        saveAccountDetailsMock();
        assertEquals(1, user.getNotifications().size());
        for (Notification notification:
             user.getNotifications()) {
            assertEquals("Account details have been updated", notification.getDescription());
        }
    }

    public void savePasswordMock() {
        String encodedNew = new BCryptPasswordEncoder().encode("password123%%%");
        user.setPassword(encodedNew);

        Notification notification = new Notification("Password has been updated");
        notification.getUsers().add(user);
        user.getNotifications().add(notification);
    }

    @Test
    @Tag(name = "Password")
    public void testSavePassword() {
        savePasswordMock();
        assertNotEquals(copy.getPassword(), user.getPassword());
    }

    @Test
    @Tag(name = "Password")
    public void testSavePassword_Notification() {
        savePasswordMock();
        assertEquals(1, user.getNotifications().size());
        for (Notification notification:
                user.getNotifications()) {
            assertEquals("Password has been updated", notification.getDescription());
        }
    }

}
