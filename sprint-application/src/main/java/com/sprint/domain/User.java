package com.sprint.domain;

import javax.persistence.*;
import java.util.*;

@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(unique = true, nullable = false)
    private String username;
    @Column(unique = true, nullable = false)
    private String email;
    @Column(nullable = false)
    private String password;
    private String name;
    private String company;
    private String bio;
    private int currentBoardId;

    @OneToMany(cascade = CascadeType.ALL)
    private List<Board> myBoards = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL)
    private List<Board> recentBoards = new ArrayList<>();

    @OneToMany(mappedBy = "user")
    private Set<TeamRole> teamRoles = new HashSet<>();

    @ManyToMany(cascade = {CascadeType.MERGE, CascadeType.PERSIST})
    private Set<Task> votedTasks = new HashSet<>();

    public User() {}

    public User(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String fullname) {
        this.name = fullname;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public int getCurrentBoardId() {
        return currentBoardId;
    }

    public void setCurrentBoardId(int currentBoardId) {
        this.currentBoardId = currentBoardId;
    }

    public List<Board> getMyBoards() {
        return myBoards;
    }

    public void setMyBoards(List<Board> myBoards) {
        this.myBoards = myBoards;
    }

    public List<Board> getRecentBoards() {
        return recentBoards;
    }

    public void setRecentBoards(List<Board> recentBoards) {
        this.recentBoards = recentBoards;
    }

    public void addRecentBoard(Board board) {
        if (recentBoards.size() > 4) {
            recentBoards.remove(4);
        }
        recentBoards.add(0, board);
    }

    public Set<TeamRole> getTeamRoles() {
        return teamRoles;
    }

    public void setTeamRoles(Set<TeamRole> teamRoles) {
        this.teamRoles = teamRoles;
    }

    public Set<Task> getVotedTasks() {
        return votedTasks;
    }

    public void setVotedTasks(Set<Task> votedTasks) {
        this.votedTasks = votedTasks;
    }

}