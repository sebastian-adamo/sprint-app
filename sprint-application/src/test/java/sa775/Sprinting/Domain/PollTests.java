package sa775.Sprinting.Domain;

import org.junit.Before;
import org.junit.Test;
import sa775.Sprint.Domain.Poll;
import sa775.Sprint.Domain.PollChoice;

import static org.junit.Assert.assertEquals;

public class PollTests {

    private Poll poll;

    @Before
    public void setup() {
        poll = new Poll("Is this test poll OK?");
        poll.getChoices().add(new PollChoice("Choice 1"));
        poll.getChoices().add(new PollChoice("Choice 2"));
    }

    @Test
    public void testCreation() {
        assertEquals("Is this test poll OK?", poll.getQuestion());
        assertEquals(2, poll.getChoices().size());
    }
}
