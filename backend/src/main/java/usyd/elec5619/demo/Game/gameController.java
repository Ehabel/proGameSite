package usyd.elec5619.demo.Game;


import jakarta.validation.Valid;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import usyd.elec5619.demo.Game.gameDTO;
import usyd.elec5619.demo.Game.gameService;
import usyd.elec5619.demo.USER.SignupDTO;
import usyd.elec5619.demo.USER.User;
import usyd.elec5619.demo.USER.UserDTO;
import usyd.elec5619.demo.USER.UserService;

import java.net.URI;
import java.security.SecureRandom;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/pwf")
public class gameController {

    private final SecureRandom randomNumberGenerator = new SecureRandom();

    private final HexFormat hexFormatter = HexFormat.of();

    private final Map<String, Long> sessions = new HashMap<>();

    @Autowired
    private gameService service;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private UserService userService;


//    @GetMapping("{gameName}/List_Pro_users")
//    public ResponseEntity<?> return_pro_users(@Valid @ModelAttribute gameDTO data, @PathVariable String gameName) {
//        if (service.findProList(gameName) == null)
//            return new ResponseEntity<>("no pro_user exist!", HttpStatus.BAD_REQUEST);
//
//        ArrayList users = service.findProList(gameName);
//
//        return new ResponseEntity<>(users, HttpStatus.OK);
//    }

    @GetMapping("{gameName}/List_Pro_users")
    public ResponseEntity<?> return_Pro_users(@PathVariable String gameName) {

        if (service.findProList(gameName) == null)
            return new ResponseEntity<>("no pro_user exist!", HttpStatus.BAD_REQUEST);

        List<User> users = service.findProList(gameName);

        List<ProUserDTO> usersNames = new ArrayList<>();
        for (User user : users) {
            usersNames.add(new ProUserDTO(user.getfName(), user.getlName()));
        }

        return new ResponseEntity<>(usersNames, HttpStatus.OK);
    }


    @GetMapping("{gameName}/Details")
    public ResponseEntity<?> getGameDetails(@PathVariable String gameName) {
        if (service.findGame_details(gameName) == null) {
            return new ResponseEntity<>("Game not found", HttpStatus.NOT_FOUND);
        }

        String gameDetails = service.findGame_details(gameName);
        game game = service.findByname(gameName);

        return new ResponseEntity<>(game, HttpStatus.OK);
    }


    @PostMapping("AddGame")
    public ResponseEntity<?> AddGame(@Valid @ModelAttribute gameDTO gameDTO) {
        if (gameDTO.getGame_name() == null) {
            return new ResponseEntity<>("Game Name does not exist!", HttpStatus.BAD_REQUEST);
        }

        if (service.findByname(gameDTO.getGame_name()) != null) {
            return new ResponseEntity<>("Game Name exists in the database!", HttpStatus.BAD_REQUEST);
        }

        game game = service.saveGame(gameDTO);
        return new ResponseEntity<>(game, HttpStatus.CREATED);
    }

    @PostMapping("AddUsersForGame")
    public ResponseEntity<?> AddUsersForGame(@RequestBody AddgameDTO addgameDTO) {
        String gameName = addgameDTO.getGameName();
        List<String> userEmails = addgameDTO.getUserEmails();
        game game = service.findByname(gameName);
        if (game == null) {
            return new ResponseEntity<>("Game with name " + gameName + " not found!", HttpStatus.NOT_FOUND);
        }

        List<User> users = new ArrayList<>();
        for (String userEmail : userEmails) {
            Optional<User> user = userService.findByEmailTwo(userEmail);
            if (user.isPresent()) {
                users.add(user.get());
            } else {
                return new ResponseEntity<>("User with email " + userEmail + " not found!", HttpStatus.NOT_FOUND);
            }
        }
        service.createGame(game, users);
        return new ResponseEntity<>("Users added for the game successfully!", HttpStatus.OK);
    }

    @GetMapping("game/images/{imageName}")
    public ResponseEntity<?> getImage(@PathVariable String imageName) {

        try {
            // Load the image resource from the directory
            Resource resource = new FileSystemResource("images/" + imageName);

            if (resource.exists()) {
                // Return the image data with appropriate headers
                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(MediaType.IMAGE_JPEG); // Change to the appropriate media type
                return new ResponseEntity<>(resource, headers, HttpStatus.OK);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("getAllGames")
    public ResponseEntity<?> getAllGames() {
        List<game> allGames = service.finAll();
        return new ResponseEntity<>(allGames, HttpStatus.OK);
    }

    @GetMapping("getAllPros")
    public ResponseEntity<?> getAllPros() {
        List<User> allGames = userService.findAll().stream().filter(user -> user.isPro()).collect(Collectors.toList());
        return new ResponseEntity<>(allGames, HttpStatus.OK);
    }




}
