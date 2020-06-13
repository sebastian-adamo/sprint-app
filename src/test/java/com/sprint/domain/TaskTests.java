//package sa775.Sprinting.Domain;
//
//import org.junit.Before;
//import org.junit.Test;
//import sa775.Sprint.Domain.Task;
//
//import static org.junit.Assert.*;
//
//public class TaskTests {
//
//    private Task task;
//
//    @Before
//    public void setup() {
//        task = new Task();
//        task.setName("Task");
//        task.setDescription("Task");
//        task.setDefinitionOfDone(true);
//        task.setComplete(false);
//    }
//
//    @Test
//    public void testCreation() {
//        assertEquals("Task", task.getName());
//        assertEquals("Task", task.getDescription());
//    }
//
//    @Test
//    public void testGetProgress_DefinitionOfDone() {
//        assertTrue(task.isDefinitionOfDone());
//        assertFalse(task.isComplete());
//        assertEquals(50, task.getProgress());
//    }
//
//    @Test
//    public void testGetProgress_Complete() {
//        task.setComplete(true);
//        task.setDefinitionOfDone(false);
//        assertTrue(task.isComplete());
//        assertFalse(task.isDefinitionOfDone());
//        assertEquals(50, task.getProgress());
//    }
//
//    @Test
//    public void testGetProgress_DefinitionOfDoneAndComplete() {
//        task.setComplete(true);
//        assertTrue(task.isComplete());
//        assertTrue(task.isDefinitionOfDone());
//        assertEquals(100, task.getProgress());
//    }
//
//    @Test
//    public void testGetProgress_None() {
//        task.setDefinitionOfDone(false);
//        assertFalse(task.isComplete());
//        assertFalse(task.isDefinitionOfDone());
//        assertEquals(0, task.getProgress());
//    }
//}
