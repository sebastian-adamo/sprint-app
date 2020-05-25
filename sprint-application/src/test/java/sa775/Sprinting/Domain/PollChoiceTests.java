package sa775.Sprinting.Domain;

import org.junit.Before;
import org.junit.Test;
import sa775.Sprint.Domain.PollChoice;

import static org.junit.Assert.assertEquals;

public class PollChoiceTests {

    private PollChoice pollChoice;

    @Before
    public void setupPollChoice() {
        pollChoice = new PollChoice("Test Poll Choice");
    }

    @Test
    public void testCreation() {
        assertEquals("Test Poll Choice", pollChoice.getDescription());
        assertEquals(0, pollChoice.getVotes());
    }

    @Test
    public void testVotesSingleIncrement() {
        pollChoice.addVotes(1);
        assertEquals(1, pollChoice.getVotes());
    }

    @Test
    public void testVotesMultipleIncrement() {
        pollChoice.addVotes(5);
        assertEquals(5, pollChoice.getVotes());
    }
}
