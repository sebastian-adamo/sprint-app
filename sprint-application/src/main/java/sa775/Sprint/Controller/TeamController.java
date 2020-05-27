package sa775.Sprint.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import sa775.Sprint.Domain.Board;
import sa775.Sprint.Domain.Team;
import sa775.Sprint.Domain.TeamRole;
import sa775.Sprint.Domain.User;
import sa775.Sprint.Repository.BoardRepository;
import sa775.Sprint.Repository.TeamRepository;
import sa775.Sprint.Repository.TeamRoleRepository;
import sa775.Sprint.Repository.UserRepository;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("/team")
public class TeamController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private TeamRepository teamRepository;
    @Autowired
    private BoardRepository boardRepository;
    @Autowired
    private TeamRoleRepository teamRoleRepository;

    @GetMapping("/create")
    public void create(@RequestParam("name") String name, @RequestParam("description") String description) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Team team = new Team(name, description);
        team.setCreator(user);
        teamRepository.save(team);

        TeamRole teamRole = new TeamRole(user, team, "Product Owner");
        team.getTeamRoles().add(teamRole);
        user.getTeamRoles().add(teamRole);
        teamRoleRepository.save(teamRole);
    }

    @Transactional
    @GetMapping("/delete")
    public void delete(@RequestParam("id") int id) {
        teamRoleRepository.deleteAllByTeamId(id);
    }

    @GetMapping("/getBoards")
    public List<Board> getBoards(@RequestParam("id") int id) {
        Team team = teamRepository.findById(id).orElse(null);
        assert team != null;
        return team.getBoards();
    }

    @GetMapping("/createBoard")
    public void createBoard(@RequestParam("id") int id, @RequestParam("name") String name, @RequestParam("description") String description, @RequestParam("dod") String dod) {
        User user = userRepository.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName());
        Team team = teamRepository.findById(id).orElse(null);
        Board board = new Board(name, description, dod);
        boardRepository.save(board);
        assert team != null;
        team.getBoards().add(board);
        teamRepository.save(team);
    }

    @GetMapping("/deleteBoard")
    public void deleteBoard(@RequestParam("id") Long id) {
        boardRepository.deleteById(id);
    }

    @GetMapping("/getDetails")
    public HashMap<String, Object> getDetails(@RequestParam("id") int id) {
        Team team = teamRepository.findById(id).orElse(null);
        HashMap<String, Object> returnMap = new HashMap<>();
        assert team != null;
        returnMap.put("name", team.getName());
        returnMap.put("description", team.getDescription());

        return returnMap;
    }

    @GetMapping("/saveDetails")
    public void saveDetails(@RequestParam("id") int id, @RequestParam("name") String name, @RequestParam("description") String description) {
        Team team = teamRepository.findById(id).orElse(null);
        assert team != null;
        team.setName(name);
        team.setDescription(description);
        teamRepository.save(team);
    }

    @GetMapping("/getMembers")
    public List<HashMap<String,Object>> getMembers(@RequestParam("id") int id) {
        List<HashMap<String,Object>> returnList = new ArrayList<>();

        for (TeamRole teamRole : teamRoleRepository.findAllByTeamId(id)) {
            HashMap<String, Object> map = new HashMap<String, Object>();
            if(teamRole.getUser().getFullname() == null) {
                map.put("name", "");
            }
            else {
                map.put("name", teamRole.getUser().getFullname());
            }
            map.put("username", teamRole.getUser().getUsername());
            map.put("role", teamRole.getRole());
            returnList.add(map);
        }

        return returnList;
    }
}
