package sa775.Sprint.Domain;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;

@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true, nullable = false)
    private String username;
    @Column(unique = true, nullable = false)
    private String email;
    @Column(nullable = false)
    private String password;
    private String fullname;
    private String company;
    private String bio;
    private Long currentBoardId;
    private boolean profileImage = false;

    @Lob
    private byte[] image;

    @OneToMany(mappedBy = "user")
    private Set<BoardRole> boardRoles = new HashSet<>();

    @ManyToMany(mappedBy = "users")
    private Set<Notification> notifications = new HashSet<>();

    @ManyToMany(mappedBy = "voters")
    private Set<Poll> polls = new HashSet<>();

    @ManyToMany(mappedBy = "users")
    private Set<Team> teams = new HashSet<>();

    public User() {}

    public User(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
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

    public Long getCurrentBoardId() {
        return currentBoardId;
    }

    public void setCurrentBoardId(Long currentBoardId) {
        this.currentBoardId = currentBoardId;
    }

    public boolean isProfileImage() {
        return profileImage;
    }

    public void setProfileImage(boolean profileImage) {
        this.profileImage = profileImage;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public Set<BoardRole> getBoardRoles() {
        return boardRoles;
    }

    public void setBoardRoles(Set<BoardRole> boardRoles) {
        this.boardRoles = boardRoles;
    }

    public Set<Notification> getNotifications() {
        return notifications;
    }

    public void setNotifications(Set<Notification> notifications) {
        this.notifications = notifications;
    }

    public Set<Poll> getPolls() {
        return polls;
    }

    public void setPolls(Set<Poll> polls) {
        this.polls = polls;
    }

    public Set<Team> getTeams() {
        return teams;
    }

    public void setTeams(Set<Team> teams) {
        this.teams = teams;
    }
}
