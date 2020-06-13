package com.sprint.domain;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;

@Entity
public class TeamRole {

    @EmbeddedId
    private TeamRoleId id = new TeamRoleId();

    @ManyToOne
    @MapsId("userId")
    private User user;

    @ManyToOne
    @MapsId("teamId")
    private Team team;

    private String role; // Product Owner, Scrum Master, Developer

    public TeamRole() {}

    public TeamRole(User user, Team team, String role) {
        this.user = user;
        this.team = team;
        this.role = role;
    }

    public TeamRoleId getId() {
        return id;
    }

    public void setId(TeamRoleId id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Team getTeam() {
        return team;
    }

    public void setTeam(Team team) {
        this.team = team;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
