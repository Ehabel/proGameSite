package usyd.elec5619.demo.USER;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserImageRepository extends JpaRepository<UserImage, Short>{
    List<UserImage> findByUser(User user);
}
