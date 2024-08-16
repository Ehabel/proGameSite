package usyd.elec5619.demo.USER;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.util.List;

import usyd.elec5619.demo.Game.game;
import usyd.elec5619.demo.ORDER.Order;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    @NotNull
    private String fName;

    @Column
    @NotNull
    private String lName;

    @Column
    @NotNull
    private String password;

    @Column
    @NotNull
    private String email;

    @Column
    private boolean isPro;

    @Column
    private String picture;


    @OneToMany(mappedBy = "user",
            cascade = CascadeType.ALL)
    private List<UserImage> images;

    @Column
    private String description;

    @Column(precision = 3, scale = 2)
    @DecimalMin("0.00")
    @DecimalMax("5.00")
    private BigDecimal rating;

    @OneToMany
    @JoinColumn(name = "Order_id")
    private List<Order> orders;

    @ManyToOne
    @JoinColumn(name = "game_id")
    private game game;

    public User(String fName, String lName, String email, String password) {
        this.fName = fName;
        this.lName = lName;
        this.password = password;
        this.email = email;
    }

    public User(String fName, String lName, String email, String password, boolean isPro, BigDecimal rating){
        this.fName = fName;
        this.lName = lName;
        this.email = email;
        this.password = password;
        this.isPro = isPro;
        this.rating = rating;
    }

    public User() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getfName() {
        return fName;
    }

    public String getlName() {
        return lName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setPro(boolean isPro){
        this.isPro = isPro;
    }

    public void setDescription(String description) {this.description = description;}

    public void setfName(String fName) {
        this.fName = fName;
    }

    public void setlName(String lName) {
        this.lName = lName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isPro() {
        return isPro;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public List<UserImage> getImages() {
        return images;
    }

    public void setImages(List<UserImage> images) {
        this.images = images;
    }

    public String getDescription() {
        return description;
    }

    public BigDecimal getRating() {
        return rating;
    }

    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }

    public void setGame(game game) {
        this.game = game;
        game.getUsers().add(this);
    }
}
