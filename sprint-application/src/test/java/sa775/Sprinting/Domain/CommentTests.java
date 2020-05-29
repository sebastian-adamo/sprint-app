//package sa775.Sprinting.Domain;
//
//import org.junit.Before;
//import org.junit.Test;
//import sa775.Sprint.Domain.Board;
//import sa775.Sprint.Domain.Comment;
//
//import java.text.SimpleDateFormat;
//import java.util.Date;
//
//import static org.junit.Assert.assertEquals;
//
//public class CommentTests {
//
//    private Comment comment;
//    private Date date;
//
//    @Before
//    public void setup() {
//        comment = new Comment("admin", "Test");
//        date = new Date();
//    }
//
//    @Test
//    public void testCreation() {
//        assertEquals("admin", comment.getUsername());
//        assertEquals("Test", comment.getDescription());
//        assertEquals(date, comment.getDatetime());
//    }
//
//    @Test
//    public void testFormattedDate() {
//        String formatted = new SimpleDateFormat("d MMM 'at' HH:mm").format(date);
//        assertEquals(formatted, comment.getFormattedDate());
//    }
//
//}
