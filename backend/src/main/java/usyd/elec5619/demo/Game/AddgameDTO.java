package usyd.elec5619.demo.Game;

import java.util.List;

public class AddgameDTO {
    private String game_name;
    private List<String> userEmails;

    public AddgameDTO(String game_name, List<String> userEmails) {
        this.game_name = game_name;
        this.userEmails = userEmails;
    }


    public String getGameName() {
        return game_name;
    }

    public void setGameName(String gameName) {
        this.game_name = gameName;
    }

    public List<String> getUserEmails() {
        return userEmails;
    }

    public void setUserEmails(List<String> userEmails) {
        this.userEmails = userEmails;
    }
}
