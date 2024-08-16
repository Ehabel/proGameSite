package usyd.elec5619.demo.Game;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import usyd.elec5619.demo.Game.gameDTO;
import usyd.elec5619.demo.USER.User;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class gameService {

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private gameRepository gameRepository;


    public game createGame(game game, List<User> users){
        if (users != null) {
            for (User user : users) {
                user.setGame(game);
            }
            game.setUsers(users);
        }
        return gameRepository.save(game);
    }

    public game saveGame(gameDTO gameDTO){
        game game = modelMapper.map(gameDTO, game.class);
        return gameRepository.save(game);
    }

    public List<usyd.elec5619.demo.Game.game> finAll(){
        return gameRepository.findAll();
    }

    public Optional<usyd.elec5619.demo.Game.game> findById(long id){
        return gameRepository.findById(id);
    }

    public usyd.elec5619.demo.Game.game findByname(String name){
        for(usyd.elec5619.demo.Game.game game: gameRepository.findAll()){
            if(game.getGame_name().equals(name))
                return game;
        }

        return null;
    }

    public List<User> findProList(String gameName){
        for(usyd.elec5619.demo.Game.game game: gameRepository.findAll()){
            if(game.getGame_name().equals(gameName))
                return game.getUsers();
        }

        return null;
    }

    public String findGame_details(String gameName){
        for(usyd.elec5619.demo.Game.game game: gameRepository.findAll()){
            if(game.getGame_name().equals(gameName))
                return game.getGame_details();
        }
        return null;
    }


}
