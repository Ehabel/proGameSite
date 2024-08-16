package usyd.elec5619.demo.USER;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;

@Entity
public class  UserImage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private short id;

    private String filename;

    @ManyToOne( cascade = {
            CascadeType.PERSIST,
            CascadeType.MERGE
    })
    @JoinColumn(name = "user_id")
    @JsonIgnoreProperties("images")
    private User user;

    public UserImage(String filename, User user) {
        this.filename = filename;
        this.user = user;
    }

    public UserImage() {

    }

    public short getId() {
        return id;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
