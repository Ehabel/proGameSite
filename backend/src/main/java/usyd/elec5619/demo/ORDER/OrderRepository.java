package usyd.elec5619.demo.ORDER;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUserId(Long userId);
    List<Order> findByProUserId(Long proUserId);
    List<Order> findByUserEmail(String userEmail);
    List<Order> findByProUserEmail(String proUserEmail);
}