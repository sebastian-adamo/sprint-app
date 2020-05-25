package sa775.Sprint.Domain;

import javax.persistence.*;
import java.util.*;

@Entity
public class Board {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String description;
    private String definitionOfDone;

    @OneToMany(cascade = CascadeType.ALL)
    @OrderBy("position ASC")
    private List<Task> backlog = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL)
    @OrderBy("position ASC")
    private List<Task> todo = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL)
    @OrderBy("position ASC")
    private List<Task> inprogress = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL)
    @OrderBy("position ASC")
    private List<Task> complete = new ArrayList<>();

    @OneToOne(cascade = CascadeType.ALL)
    private User owner;

    @OneToMany(mappedBy = "board")
    private Set<BoardRole> boardRoles = new HashSet<>();

    @OneToMany(cascade = CascadeType.ALL)
    private List<Poll> polls = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<>();

    public Board() {}

    public Board(String name) {
        this.name = name;
    }

    public Board(String name, String description, String definitionOfDone) {
        this.name = name;
        this.description = description;
        this.definitionOfDone = definitionOfDone;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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

    public String getDefinitionOfDone() {
        return definitionOfDone;
    }

    public void setDefinitionOfDone(String definitionOfDone) {
        this.definitionOfDone = definitionOfDone;
    }

    public void addBacklog(Task task) {
        backlog.add(task);
    }

    public List<Task> getBacklog() {
        return backlog;
    }

    public void setBacklog(List<Task> backlog) {
        this.backlog = backlog;
    }

    public void addTodo(Task task) {
        todo.add(task);
    }

    public List<Task> getTodo() {
        return todo;
    }

    public void setTodo(List<Task> todo) {
        this.todo = todo;
    }

    public void addInprogress(Task task) {
        inprogress.add(task);
    }

    public List<Task> getInprogress() {
        return inprogress;
    }

    public void setInprogress(List<Task> inprogress) {
        this.inprogress = inprogress;
    }

    public void addComplete(Task task) {
        complete.add(task);
    }

    public List<Task> getComplete() {
        return complete;
    }

    public void setComplete(List<Task> todo) {
        this.complete = complete;
    }

    public List<Poll> getPolls() {
        return polls;
    }

    public void setPolls(List<Poll> polls) {
        this.polls = polls;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public void addComment(Comment comment) {
        comments.add(comment);
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public Set<BoardRole> getBoardRoles() {
        return boardRoles;
    }

    public void setBoardRoles(Set<BoardRole> boardRoles) {
        this.boardRoles = boardRoles;
    }
}
