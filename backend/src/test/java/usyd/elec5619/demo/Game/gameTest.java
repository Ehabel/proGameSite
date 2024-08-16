package usyd.elec5619.demo.Game;

import org.junit.jupiter.api.Test;
import usyd.elec5619.demo.USER.User;

import java.util.List;
import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class gameTest {
    List<User> users;

    @Test
    void setGame_details() {

        User user1=new User("Fname","Lname","123@gmail.com","abc123");
        User user2=new User("Fname","Lname","1234@gmail.com","abc123");
        User user3=new User("Fname","Lname","12356@gmail.com","abc123");
        List<User> users = new ArrayList<>();
        users.add(user1);
        users.add(user2);
        users.add(user3);

        game game=new game("gamename","gamedetails","gametag","gamedark_icon","gamelightIcon",users);
        game.setGame_details("hi");
        assertEquals(game.getGame_details(),"hi");
    }


    @Test
    void setGame_tag() {
        User user1=new User("Fname","Lname","123@gmail.com","abc123");
        User user2=new User("Fname","Lname","1234@gmail.com","abc123");
        User user3=new User("Fname","Lname","12356@gmail.com","abc123");
        List<User> users = new ArrayList<>();
        users.add(user1);
        users.add(user2);
        users.add(user3);

        game game=new game("gamename","gamedetails","gametag","gamedark_icon","gamelightIcon",users);
        game.setGame_tag("lol");
        assertEquals(game.getGame_tag(),"lol");
    }


    @Test
    void setGame_name() {
        User user1=new User("Fname","Lname","123@gmail.com","abc123");
        User user2=new User("Fname","Lname","1234@gmail.com","abc123");
        User user3=new User("Fname","Lname","12356@gmail.com","abc123");
        List<User> users = new ArrayList<>();
        users.add(user1);
        users.add(user2);
        users.add(user3);

        game game=new game("gamename","gamedetails","gametag","gamedark_icon","gamelightIcon",users);
        game.setGame_name("lol");
        assertEquals(game.getGame_name(),"lol");
    }


    @Test
    void setGame_icon_dark() {
        User user1=new User("Fname","Lname","123@gmail.com","abc123");
        User user2=new User("Fname","Lname","1234@gmail.com","abc123");
        User user3=new User("Fname","Lname","12356@gmail.com","abc123");
        List<User> users = new ArrayList<>();
        users.add(user1);
        users.add(user2);
        users.add(user3);

        game game=new game("gamename","gamedetails","gametag","gamedark_icon","gamelightIcon",users);
        game.setGame_icon_dark("dark");
        assertEquals(game.getGame_icon_dark(),"dark");
    }


    @Test
    void setGame_icon_light() {
        User user1=new User("Fname","Lname","123@gmail.com","abc123");
        User user2=new User("Fname","Lname","1234@gmail.com","abc123");
        User user3=new User("Fname","Lname","12356@gmail.com","abc123");
        List<User> users = new ArrayList<>();
        users.add(user1);
        users.add(user2);
        users.add(user3);

        game game=new game("gamename","gamedetails","gametag","gamedark_icon","gamelightIcon",users);
        game.setGame_icon_light("light");
        assertEquals(game.getGame_icon_light(),"light");
    }


    @Test
    void setUsers() {
        User user1=new User("Fname","Lname","123@gmail.com","abc123");
        User user2=new User("Fname","Lname","1234@gmail.com","abc123");
        User user3=new User("Fname","Lname","12356@gmail.com","abc123");
        List<User> users = new ArrayList<>();
        users.add(user1);
        users.add(user2);
        users.add(user3);

        game game=new game("gamename","gamedetails","gametag","gamedark_icon","gamelightIcon",users);
        users.add(user1);
        game.setUsers(users);
        assertEquals(game.getUsers(),users);
    }
}