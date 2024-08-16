package usyd.elec5619.demo.Game;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import usyd.elec5619.demo.USER.User;

import java.util.ArrayList;
import java.util.List;

public class gameDTO {
    @NotBlank
    private String game_name;

    @NotBlank
    private String game_details;

    @NotBlank
    private String game_tag;


    @NotBlank
    private String game_icon_dark;

    @NotBlank
    private String game_icon_light;

    private List<User> users;

    private List<Long> userIds;

    public gameDTO(String game_name, String game_details, String game_tag, String game_icon_dark, String game_icon_light,List<User> users, List<Long> userIds){
        this.game_name=game_name;
        this.game_icon_dark=game_icon_dark;
        this.game_icon_light=game_icon_light;
        this.users=users;
        this.game_details=game_details;
        this.game_tag=game_tag;
        this.userIds=userIds;
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

    public void setUsers(List<User> users){this.users=users;}
    public List<User> getUsers(){
        return this.users;
    }

    public List<Long> getUserIds() {
        return userIds;
    }

    public void setUserIds(List<Long> userIds) {
        this.userIds = userIds;
    }
}
