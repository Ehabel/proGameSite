package usyd.elec5619.demo.USER;

import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserImageRepository userImageRepository;

    @Autowired
    private ModelMapper modelMapper;

    public User createUser(SignupDTO data){
        User user = new User(data.getfName(), data.getlName(), data.getEmail(), data.getPassword());
        return this.userRepository.save(user);
    }

//    public User createUserEasy(SignupDTO data){
//        User user = new User(data.getfName(), data.getlName(), data.getEmail(), data.getPassword(), data.isPro(), data.getRating());
//        return this.userRepository.save(user);
//    }

    public List<User> findAll(){
        return userRepository.findAll();
    }

    public Optional<User> findById(long id){
        return userRepository.findById(id);
    }

    public User findByEmail(String email){
        for(User user: userRepository.findAll()){
            if(user.getEmail().equals(email))
                return user;
        }

        return null;
    }

    public Optional<User> findByEmailTwo(String email){
        return userRepository.findAll()
                .stream()
                .filter(user -> user.getEmail().equals(email))
                .findFirst();
    }

    @Transactional
    public void deleteImageById(short imageId) {
        userImageRepository.deleteById(imageId);
    }

    public Optional<UserImage> findImage(short imageId){
        return userImageRepository.findById(imageId);
    }

    public UserImage uploadImage(String fileName, User user) {
        UserImage userImage = new UserImage(fileName, user);
        return userImageRepository.save(userImage);
    }

    public Optional<User> setDescription(String email, UserDTO data) {
        Optional<User> maybeUser = this.findByEmailTwo(email);
        if(maybeUser.isPresent()){
            User existingUser = maybeUser.get();
            modelMapper.map(data, existingUser);
            return Optional.of(this.userRepository.save(existingUser));
        }
        return maybeUser;
    }

    public Optional<User> becomePro(String email, UserDTO data) {
        Optional<User> maybeUser = this.findByEmailTwo(email);
        data.setPro(true);
        if(maybeUser.isPresent()){
            User existingUser = maybeUser.get();
            modelMapper.map(data, existingUser);
            return Optional.of(this.userRepository.save(existingUser));
        }
        return maybeUser;
    }

    public Optional<User> setRating(String email, UserDTO data) {
        Optional<User> maybeUser = this.findByEmailTwo(email);
        BigDecimal rating = data.getRating();
        if(maybeUser.isPresent()){
            User existingUser = maybeUser.get();
            modelMapper.map(data, existingUser);
            existingUser.setRating(data.getRating());
            return Optional.of(this.userRepository.save(existingUser));
        }
        return maybeUser;
    }

    public Optional<User> addProfilePicture(String email, String filename, UserDTO data) {
        Optional<User> maybeUser = this.findByEmailTwo(email);
        data.setPicture(filename);
        if(maybeUser.isPresent()){
            User existingUser = maybeUser.get();
            modelMapper.map(data, existingUser);
            return Optional.of(this.userRepository.save(existingUser));
        }
        return maybeUser;
    }

    public UserImage findUserImage(User data){
        List<UserImage> userImages = userImageRepository.findByUser(data);
        if (!userImages.isEmpty()) {
            return userImages.get(userImages.size() - 1);
        } else {
            return null;
        }
    }

}
