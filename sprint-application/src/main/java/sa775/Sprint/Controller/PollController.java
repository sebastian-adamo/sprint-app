package sa775.Sprint.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import sa775.Sprint.Domain.*;
import sa775.Sprint.Repository.BoardRepository;
import sa775.Sprint.Repository.PollChoiceRepository;
import sa775.Sprint.Repository.PollRepository;
import sa775.Sprint.Repository.UserRepository;

import java.util.HashMap;

@RestController
@RequestMapping("/poll")
public class PollController {

    // For debugging
    public static final String ANSI_RED = "\u001B[31m";
    public static final String ANSI_RESET = "\u001B[0m";

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BoardRepository boardRepository;
    @Autowired
    private PollRepository pollRepository;
    @Autowired
    private PollChoiceRepository pollChoiceRepository;

    @GetMapping("/create")
    public String create(@RequestParam("question") String question, @RequestParam("list") String list) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId()).orElse(null);
        assert board != null;
        Poll poll = new Poll(question);
        poll.setCreator(user);
        pollRepository.save(poll);

        switch (list) {
            case "Backlog":
                for(Task task: board.getBacklog()) {
                    PollChoice pollChoice = new PollChoice(task.getName());
                    poll.getChoices().add(pollChoice);
                    pollRepository.save(poll);
                }
                break;
            case "TODO":
                for(Task task: board.getTodo()) {
                    PollChoice pollChoice = new PollChoice(task.getName());
                    poll.getChoices().add(pollChoice);
                    pollRepository.save(poll);
                }
                break;
            case "In Progress":
                for(Task task: board.getInprogress()) {
                    PollChoice pollChoice = new PollChoice(task.getName());
                    poll.getChoices().add(pollChoice);
                    pollRepository.save(poll);
                }
                break;
        }

        board.getPolls().add(poll);
        boardRepository.save(board);

        return "success";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id) {
        Poll poll = pollRepository.findById(id).orElse(null);
        assert poll != null;
        pollRepository.delete(poll);
        return "success";
    }

    @GetMapping("/get")
    public HashMap<String, Object> get(@RequestParam("id") Long id) {
        HashMap<String, Object> pollInfo = new HashMap();
        Poll poll = pollRepository.findById(id).orElse(null);
        pollInfo.put("question", poll.getQuestion());
        pollInfo.put("choices", poll.getChoices());
        return pollInfo;
    }

    @GetMapping("/vote")
    public String vote(@RequestParam("poll") Long poll, @RequestParam("id") Long id) {
        // Adding user to voters to prevent multiple votes
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Poll p = pollRepository.findById(poll).orElse(null);
        p.getVoters().add(user);
        user.getPolls().add(p);
        pollRepository.save(p);

        PollChoice pollChoice = pollChoiceRepository.findById(id).orElse(null);
        pollChoice.addVotes(1);
        pollChoiceRepository.save(pollChoice);
        return "success";
    }
}
