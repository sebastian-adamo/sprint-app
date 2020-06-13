package com.sprint.domain;

import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class TeamRoleId implements Serializable {

    private static final long serialVersionUID = 1L;

    private int userId;
    private int teamId;

    public TeamRoleId() {

    }

    public TeamRoleId(int userId, int teamId) {
        super();
        this.userId = userId;
        this.teamId = teamId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }

}
