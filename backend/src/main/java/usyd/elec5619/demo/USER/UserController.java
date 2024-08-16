package usyd.elec5619.demo.USER;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.google.api.services.drive.DriveScopes;
import jakarta.validation.Valid;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import usyd.elec5619.demo.config.JwtUtil;
import usyd.elec5619.demo.exceptions.NotFoundException;

import java.awt.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Optional;
import java.util.UUID;

import com.google.api.client.http.FileContent;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;

import static usyd.elec5619.demo.USER.DriveServiceInitializer.initializeDriveService;

@RestController
@RequestMapping("/pwf")
public class UserController {

    @Autowired
    private UserService service;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private ModelMapper modelMapper;

    private Drive drive;// = initializeDriveService();

    @Value("${flutter.assets}")
    private String flutterPath;

    public UserController(){
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(@Valid @ModelAttribute LoginDTO data) {
        User user = service.findByEmail(data.getEmail());
        if(user == null)
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body("Entered email is incorrect.\n");

        if (passwordEncoder.matches(data.getPassword(), user.getPassword())) {
            String token = jwtUtil.generateToken(user.getEmail());

            return ResponseEntity.status(HttpStatus.OK).header("Authorization", token).body("User logged in successfully.\n");
        } else {
            return ResponseEntity.status(HttpStatus.EXPECTATION_FAILED).body("Entered password is incorrect.");
        }
    }

    @GetMapping("/logout")
    public ResponseEntity<String> logout(@RequestHeader("Authorization") String jwtToken,
                                         @Valid @ModelAttribute UserDTO data){
        User userMapped = modelMapper.map(data, User.class);
        if (jwtUtil.validateToken(jwtToken, userMapped))
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Token is already expired.");

        // Invalidate the token
        jwtUtil.invalidateToken(jwtToken);

        return ResponseEntity.status(HttpStatus.OK).body("User logged out successfully.\n");
    }

    @PostMapping("/signup")
    public ResponseEntity<?> SignUp(@Valid @ModelAttribute SignupDTO data) {
        if (service.findByEmail(data.getEmail()) != null)
            return new ResponseEntity<>("Username is already exist!", HttpStatus.BAD_REQUEST);

        if (!data.getPassword().equals(data.getMatchPassword()))
            return new ResponseEntity<>("Passwords does not match!", HttpStatus.BAD_REQUEST);
        data.setPassword(passwordEncoder.encode(data.getPassword()));
        User createdUser = service.createUser(data);

        return new ResponseEntity<>(createdUser, HttpStatus.CREATED);
    }

    @GetMapping("/account")
    public ResponseEntity<?> ViewAccount(@RequestHeader("Authorization") String jwtToken){
        String email = jwtUtil.extractEmail(jwtToken);
        User user = service.findByEmail(email);
        if(user == null)
            return new ResponseEntity<>("User does not exist!", HttpStatus.BAD_REQUEST);

        if (!jwtUtil.validateToken(jwtToken, user)) {
            return new ResponseEntity<>("Unauthorized!", HttpStatus.UNAUTHORIZED);
        }

        return new ResponseEntity<>(user, HttpStatus.OK);
    }

    @PatchMapping("/become_a_pro")
    public ResponseEntity<?> Become_A_Pro(@RequestHeader(name = "Authorization") String sessionToken,
                                          @Valid @ModelAttribute UserDTO data){
        User userMapped = modelMapper.map(data, User.class);
        if(!jwtUtil.validateToken(sessionToken, userMapped)){
            return new ResponseEntity<>("Unauthorized!", HttpStatus.UNAUTHORIZED);
        }

        Optional<User> optionalUser = service.becomePro(data.getEmail(), data);
        if(optionalUser.isPresent()){
            return new ResponseEntity<User>(optionalUser.get(), HttpStatus.OK);
        }
        throw new NotFoundException("Could not find user");
    }

    @DeleteMapping("edit_profile/delete_image/{id}")
    public ResponseEntity<?> deleteImage(@RequestHeader(name = "Authorization") String sessionToken,
                                         @Valid @ModelAttribute UserDTO data,
                                         @PathVariable Short id){
        User userMapped = modelMapper.map(data, User.class);
        if(!jwtUtil.validateToken(sessionToken, userMapped)){
            return new ResponseEntity<>("Unauthorized!", HttpStatus.UNAUTHORIZED);
        }

        Optional<UserImage> optionalUserImage = service.findImage(id);
        if(optionalUserImage.isEmpty())
            return new ResponseEntity<>("Image does not exist!", HttpStatus.BAD_REQUEST);

        User user = optionalUserImage.get().getUser();

        service.deleteImageById(id);
        return new ResponseEntity<>(user, HttpStatus.OK);
    }

    @PatchMapping("edit_profile/add_image")
    public ResponseEntity<?> addImage(@RequestHeader(name = "Authorization") String sessionToken,
                                      @Valid @ModelAttribute UserDTO data,
                                      @RequestParam MultipartFile file){
        User userMapped = modelMapper.map(data, User.class);
        User userTwo = service.findByEmail(data.getEmail());

        if(!jwtUtil.validateToken(sessionToken, userMapped)){
            return new ResponseEntity<>("Unauthorized!", HttpStatus.UNAUTHORIZED);
        }

        try{
            byte[] bytes = file.getBytes();

            String uploadDir = flutterPath;
            Path path = Paths.get(uploadDir + file.getOriginalFilename());
            // Save the file
            Files.write(path, bytes);
            service.uploadImage("http://localhost:8080/images/" +file.getOriginalFilename(), userTwo);
            return new ResponseEntity<>("Successfully upload image!", HttpStatus.OK);
        }catch (IOException e){
            return new ResponseEntity<>("Failed to upload image!", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("userProfile/images/{imageName}")
    public ResponseEntity<?> getImage(@RequestHeader(name = "Authorization") String sessionToken,
                                             @Valid @ModelAttribute UserDTO data,
                                             @PathVariable String imageName) {
        User userMapped = modelMapper.map(data, User.class);
        if(!jwtUtil.validateToken(sessionToken, userMapped)){
            return new ResponseEntity<>("Unauthorized!", HttpStatus.UNAUTHORIZED);
        }

        try {
            // Load the image resource from the directory
            Resource resource = new FileSystemResource(flutterPath + imageName);

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

    @PatchMapping("edit_profile/edit_description")
    public ResponseEntity<?> editDescription(@RequestHeader(name = "Authorization") String sessionToken,
                                             @Valid @ModelAttribute UserDTO data){
        User userMapped = modelMapper.map(data, User.class);
        if(!jwtUtil.validateToken(sessionToken, userMapped)){
            return new ResponseEntity<>("Unauthorized!", HttpStatus.UNAUTHORIZED);
        }
        Optional<User> user = service.setDescription(data.getEmail(), data);
        if(user.isPresent()){
            return new ResponseEntity<User>(user.get(), HttpStatus.OK);
        }
        throw new NotFoundException("Could not find user");
    }

    @GetMapping("userProfile/images/")
    public ResponseEntity<?> getUserImages(@RequestHeader(name = "Authorization") String sessionToken) {
        String email = jwtUtil.extractEmail(sessionToken);
        User user = service.findByEmail(email);
        if (!jwtUtil.validateToken(sessionToken, user)) {
            return new ResponseEntity<>("Unauthorized!", HttpStatus.UNAUTHORIZED);
        }

        try {
            ArrayList<String> imageUrls = new ArrayList<>();
            for (UserImage image : user.getImages()) {
                imageUrls.add(image.getFilename());
            }

            if (!imageUrls.isEmpty()) {
                HttpHeaders headers = new HttpHeaders();
                return new ResponseEntity<>(imageUrls, headers, HttpStatus.OK);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PatchMapping("profile/add_image")
    public ResponseEntity<?> addProfileImage(@RequestHeader(name = "Authorization") String sessionToken,
                                      @Valid @ModelAttribute UserDTO data,
                                      @RequestParam MultipartFile file){
        User userMapped = modelMapper.map(data, User.class);
        User userTwo = service.findByEmail(data.getEmail());

        if(!jwtUtil.validateToken(sessionToken, userMapped)){
            return new ResponseEntity<>("Unauthorized!", HttpStatus.UNAUTHORIZED);
        }

        try{
            byte[] bytes = file.getBytes();

            String uploadDir = flutterPath;
            Path path = Paths.get(uploadDir + file.getOriginalFilename());
            // Save the file
            Files.write(path, bytes);
            service.addProfilePicture(userTwo.getEmail(), path.toString(), data);
            return new ResponseEntity<>("Successfully upload image!", HttpStatus.OK);
        }catch (IOException e){
            return new ResponseEntity<>("Failed to upload image!", HttpStatus.BAD_REQUEST);
        }
    }

    @PatchMapping("edit_profile/rating")
    public ResponseEntity<?> editRating(@RequestHeader(name = "Authorization") String sessionToken,
                                             @Valid @ModelAttribute UserDTO data){
        User userMapped = modelMapper.map(data, User.class);
        if(!jwtUtil.validateToken(sessionToken, userMapped)){
            return new ResponseEntity<>("Unauthorized!", HttpStatus.UNAUTHORIZED);
        }
        Optional<User> user = service.setRating(data.getEmail(), data);
        if(user.isPresent()){
            return new ResponseEntity<User>(user.get(), HttpStatus.OK);
        }
        throw new NotFoundException("Could not find user");
    }

    @GetMapping("/pro/account")
    public ResponseEntity<?> ViewProAccount(@RequestParam int pk){
        Optional<User> user = service.findById(pk);
        if(!user.isPresent())
            return new ResponseEntity<>("User does not exist!", HttpStatus.BAD_REQUEST);
        return new ResponseEntity<>(user, HttpStatus.OK);
    }

//    @PostMapping("/signupeasy")
//    public ResponseEntity<?> SignUpEasy(@Valid @ModelAttribute SignupDTO data) {
//        if (service.findByEmail(data.getEmail()) != null)
//            return new ResponseEntity<>("Username is already exist!", HttpStatus.BAD_REQUEST);
//
//        if (!data.getPassword().equals(data.getMatchPassword()))
//            return new ResponseEntity<>("Passwords does not match!", HttpStatus.BAD_REQUEST);
//        data.setPassword(passwordEncoder.encode(data.getPassword()));
//        User createdUser = service.createUserEasy(data);
//
//        return new ResponseEntity<>(createdUser, HttpStatus.CREATED);
//    }

}
