package usyd.elec5619.demo.Game;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import usyd.elec5619.demo.ORDER.Order;
import usyd.elec5619.demo.USER.User;

@Entity
@Table(name = "games")
public class game {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long game_id;

    @Column
    private String game_name;

    @Column
    private String game_tag;

    @Column
    private String game_details;


    @Column
    private String game_icon_dark;

    @Column
    private String game_icon_light;


    @OneToMany(mappedBy = "game")
    private List<User> users;


    public game(String game_name, String game_details, String game_tag,String game_icon_dark, String game_icon_light,List<User> users){
        this.game_name=game_name;
        this.game_icon_dark=game_icon_dark;
        this.game_icon_light=game_icon_light;
        this.users=users;
        this.game_details=game_details;
        this.game_tag=game_tag;
    }

    public game() {
    }

    public void setGame_id(Long id){
        this.game_id=id;
    }
    public Long getGame_id(){
        return this.game_id;
    }

    public void setGame_details(String game_details){
        this.game_details=game_details;
    }
    public String getGame_details(){
        return this.game_details;
    }

    public void setGame_tag(String game_tag){
        this.game_tag=game_tag;
    }
    public String getGame_tag(){
        return this.game_tag;
    }

    public void setGame_name(String name){
        this.game_name=name;
    }
    public String getGame_name(){
        return this.game_name;
    }

    public void setGame_icon_dark(String icon){
        this.game_icon_dark=icon;
    }
    public String getGame_icon_dark(){
        return this.game_icon_dark;
    }

    public void setGame_icon_light(String icon){
        this.game_icon_light=icon;
    }
    public String getGame_icon_light(){
        return this.game_icon_light;
    }

    public void addUser(User user) {
        users.add(user);
        user.setGame(this);
    }
    public List<User> getUsers(){
        return this.users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }
}
