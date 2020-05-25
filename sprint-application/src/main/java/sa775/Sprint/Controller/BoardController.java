package sa775.Sprint.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import sa775.Sprint.Domain.*;
import sa775.Sprint.Repository.*;
import sa775.Sprint.Service.NotificationService;

import java.util.*;

@RestController
@RequestMapping("/boards")
public class BoardController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BoardRepository boardRepository;
    @Autowired
    private BoardRoleRepository boardRoleRepository;
    @Autowired
    private NotificationRepository notificationRepository;
    @Autowired
    private NotificationService notificationService;

    @GetMapping("/add")
    public String add(@RequestParam(value = "name") String name) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board b = new Board(name);
        b.setOwner(user);
        boardRepository.save(b);
        BoardRole boardRole = new BoardRole(user, b, "Product Owner");
        user.getBoardRoles().add(boardRole);
        b.getBoardRoles().add(boardRole);
        boardRoleRepository.save(boardRole);
        return "success";
    }

    @GetMapping("/addMyBoard")
    public String addMyBoard(@RequestParam(value = "name") String name, @RequestParam(value = "description") String description, @RequestParam(value = "dod") String dod) {
        User user =  userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board b = new Board(name, description, dod);
        b.setOwner(user);
        boardRepository.save(b);
        BoardRole boardRole = new BoardRole(user, b, "Product Owner");
        user.getBoardRoles().add(boardRole);
        b.getBoardRoles().add(boardRole);
        boardRoleRepository.save(boardRole);
        return "success";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam(value = "id") Long id) {
        boardRoleRepository.deleteAll(boardRoleRepository.findAllByBoardId(id));
        return "success";
    }
    
    @GetMapping("/get")
    public HashMap<String, Object> get(@RequestParam(value = "id") Long id) {
        Board board = boardRepository.findById(id);
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
        for(BoardRole boardRole : boardRoleRepository.findAllByBoardId(id)) {
            User user = boardRole.getUser();
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
        }
        Collections.reverse(userDetails);
        returnMap.put("users", userDetails);

        return returnMap;
    }

    @GetMapping("/save")
    public String save(@RequestParam(value = "id") Long id, @RequestParam(value = "name") String name, @RequestParam(value = "description") String description, @RequestParam(value = "dod") String dod) {
        Board b = boardRepository.findById(id);
        b.setName(name);
        b.setDescription(description);
        b.setDefinitionOfDone(dod);
        boardRepository.save(b);

        return "success";
    }


    @GetMapping("/users/search")
    public String searchUser(@RequestParam(value = "email") String email) {
        if (userRepository.existsByEmail(email)) {
            return email;
        }
        else {
            return "fail";
        }
    }

    @GetMapping("/users/invite")
    public String inviteUser(@RequestParam(value = "id") Long id, @RequestParam("email") String email) {
        User user = userRepository.findByEmail(email);
        Board board = boardRepository.findById(id);
        notificationService.boardInvitation(user, board);
        return "success";
    }

    @GetMapping("/accept")
    public String acceptInvitation(@RequestParam(value = "id") Long id) {
        Notification notification = notificationRepository.findById(id).orElse(null);
        assert notification != null;
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = notification.getBoard();
        BoardRole boardRole = new BoardRole(user, board, "Developer"); // Defaults to non-admin role
        user.getBoardRoles().add(boardRole);
        board.getBoardRoles().add(boardRole);
        boardRoleRepository.save(boardRole);
        notificationService.delete(id);
        return "success";
    }

    @GetMapping("/decline")
    public String declineInvitation(@RequestParam("id") Long id) {
        notificationService.delete(id);
        return "success";
    }

    @GetMapping("/users/role")
    public String changeRole(@RequestParam("email") String email, @RequestParam("role") String role) {
        BoardRole boardRole = boardRoleRepository.findByUserEmail(email);
        if (role.equals("Product Owner")) {
            boardRole.setRole("Product Owner");
        }
        else if(role.equals("Scrum Master")) {
            boardRole.setRole("Scrum Master");
        }
        else {
            boardRole.setRole("Developer");
        }
        boardRoleRepository.save(boardRole);
        return "success";
    }

    @GetMapping("/users/remove")
    public String removeUser(@RequestParam("email") String email) {
        BoardRole boardRole = boardRoleRepository.findByUserEmail(email);
        boardRoleRepository.delete(boardRole);
        return "success";
    }

    @GetMapping("/comment")
    public String comment(@RequestParam(value = "comment") String comment) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Board board = boardRepository.findById(user.getCurrentBoardId());
        Comment c = new Comment(user.getUsername(), comment);
        board.addComment(c);
        boardRepository.save(board);

        // Notification
        List<BoardRole> boardRoles = boardRoleRepository.findAllByBoard(board);
        for (BoardRole boardRole : boardRoles) {
            if (comment.contains("@" + boardRole.getUser().getUsername())) {
                notificationService.notification("You were mentioned in a comment in board: '" + board.getName() + "'", boardRole.getUser());
            }
        }

        return "success";
    }
}
