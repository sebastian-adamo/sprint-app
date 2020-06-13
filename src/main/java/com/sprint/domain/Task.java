package com.sprint.domain;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.*;

@Entity
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    private String description;
    private int position;
    private boolean definitionOfDone = false;
    private int progress = 0;
    private Date due;

    @OneToMany(cascade = CascadeType.ALL)
    private List<Todo> todos = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<Comment>();

    @ManyToMany(mappedBy = "votedTasks")
    private Set<User> usersVoted = new HashSet<>();

    public Task() {}

    public Task(String name, int position) {
        this.name = name;
        this.position = position;
    }

    public Task(String name, String description, boolean definitionOfDone, int progress) {
        this.name = name;
        this.description = description;
        this.definitionOfDone = definitionOfDone;
        this.progress = progress;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public boolean isDefinitionOfDone() {
        return definitionOfDone;
    }

    public void setDefinitionOfDone(boolean definitionOfDone) {
        this.definitionOfDone = definitionOfDone;
    }

    public int getProgress() {
        this.progress = 0;

        for (Todo todo : this.getTodos()) {
            if (todo.isComplete()) {
                this.progress += (100 / this.getTodos().size());
            }
        }
        return progress;
    }

    public void setProgress(int progress) {
        this.progress = progress;
    }

    public Date getDue() {
        return due;
    }

    public void setDue(Date due) {
        this.due = due;
    }

    public String getFormattedDue() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd/yyyy");
        return simpleDateFormat.format(this.due);
    }

    public List<Todo> getTodos() {
        return todos;
    }

    public void setTodos(List<Todo> todos) {
        this.todos = todos;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public Set<User> getUsersVoted() {
        return usersVoted;
    }

    public void setUsersVoted(Set<User> usersVoted) {
        this.usersVoted = usersVoted;
    }
}
