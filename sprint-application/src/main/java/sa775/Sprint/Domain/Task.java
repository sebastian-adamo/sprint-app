package sa775.Sprint.Domain;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    private String description;
    private int position;
    private boolean definitionOfDone = false;
    private boolean complete = false;
    private int progress = 0;
    private Date due;

    @OneToMany(cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<Comment>();

    public Task() {}

    public Task(String name, String description, boolean definitionOfDone, boolean complete, int progress) {
        this.name = name;
        this.description = description;
        this.definitionOfDone = definitionOfDone;
        this.complete = complete;
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

    public boolean isComplete() {
        return complete;
    }

    public void setComplete(boolean complete) {
        this.complete = complete;
    }

    public int getProgress() {
        this.progress = 0;
        if (this.definitionOfDone) {
            this.progress += 50;
        }
        if (this.complete) {
            this.progress += 50;
        }
        return this.progress;
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

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }
}
