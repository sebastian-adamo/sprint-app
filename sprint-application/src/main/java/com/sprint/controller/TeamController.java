package com.sprint.controller;

import com.sprint.domain.Board;
import com.sprint.domain.Team;
import com.sprint.domain.TeamRole;
import com.sprint.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.sprint.repository.BoardRepository;
import com.sprint.repository.TeamRepository;
import com.sprint.repository.TeamRoleRepository;
import com.sprint.repository.UserRepository;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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

    @GetMapping("/add")
    public void add(@RequestParam String name, @RequestParam String description) {
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
    public void delete(@RequestParam int id) {
        teamRoleRepository.deleteAllByTeamId(id);
    }

    @GetMapping("/get")
    public HashMap<String, Object> get(@RequestParam int id) {
        Team team = teamRepository.findById(id);
        HashMap<String, Object> returnMap = new HashMap<>();
        returnMap.put("name", team.getName());
        returnMap.put("description", team.getDescription());

        return returnMap;
    }

    @GetMapping("/update")
    public void update(@RequestParam int id, @RequestParam String name, @RequestParam String description) {
        Team team = teamRepository.findById(id);
        team.setName(name);
        team.setDescription(description);
        teamRepository.save(team);
    }

    @GetMapping("/members")
    public List<HashMap<String,Object>> members(@RequestParam int id) {
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


    @GetMapping("/search")
    public String search(@RequestParam String email) {
        List<User> users = userRepository.findAll();

        for (User user : users) {
            if (user.getEmail().equals(email)) {
                return user.getEmail();
            }
        }

        return "";
    }

    @GetMapping("/invite")
    public void invite(@RequestParam int id, @RequestParam String email) {
        // Currently just adds the user instead of inviting them
        Team team = teamRepository.findById(id);
        User user = userRepository.findByEmail(email);

        TeamRole teamRole = new TeamRole(user, team, "Developer");
        user.getTeamRoles().add(teamRole);
        team.getTeamRoles().add(teamRole);
        teamRoleRepository.save(teamRole);

    }

    // Boards
    @GetMapping("/board/add")
    public void boardAdd(@RequestParam int id, @RequestParam String name, @RequestParam String description, @RequestParam String dod) {
        Team team = teamRepository.findById(id);
        Board board = new Board(name, description, dod);
        boardRepository.save(board);
        team.getBoards().add(board);
        teamRepository.save(team);
    }
    // !Boards
}
