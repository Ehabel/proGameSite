package usyd.elec5619.demo.ORDER;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import usyd.elec5619.demo.USER.User;

import java.math.BigDecimal;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;

class OrderDTOTest {

    private OrderDTO orderDTO;
    private User user, proUser;
    private Date date;

    @Test
    void getOrderId() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        orderDTO.setOrderId(1L);
        assertEquals(1L, orderDTO.getOrderId());
    }

    @Test
    void setOrderId() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        orderDTO.setOrderId(1L);
        assertEquals(1L, orderDTO.getOrderId());
    }

    @Test
    void getUser() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        orderDTO.setUser(user);
        assertEquals(user, orderDTO.getUser());
    }

    @Test
    void setUser() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        orderDTO.setUser(user);
        assertEquals(user, orderDTO.getUser());
    }

    @Test
    void getProUser() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        orderDTO.setProUser(proUser);
        assertEquals(proUser, orderDTO.getProUser());
    }

    @Test
    void setProUser() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        orderDTO.setProUser(proUser);
        assertEquals(proUser, orderDTO.getProUser());
    }

    @Test
    void getOrderDate() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        orderDTO.setOrderDate(date);
        assertEquals(date, orderDTO.getOrderDate());
    }

    @Test
    void setOrderDate() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        Date newDate = new Date();
        orderDTO.setOrderDate(newDate);
        assertEquals(newDate, orderDTO.getOrderDate());
    }

    @Test
    void getAmount() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        BigDecimal amount = BigDecimal.valueOf(10);
        orderDTO.setAmount(amount);
        assertEquals(amount, orderDTO.getAmount());
    }

    @Test
    void setAmount() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        BigDecimal amount = BigDecimal.valueOf(20);
        orderDTO.setAmount(amount);
        assertEquals(amount, orderDTO.getAmount());
    }

    @Test
    void getQuantity() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        Double quantity = 2.5;
        orderDTO.setQuantity(quantity);
        assertEquals(quantity, orderDTO.getQuantity());
    }

    @Test
    void setQuantity() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        Double quantity = 5.0;
        orderDTO.setQuantity(quantity);
        assertEquals(quantity, orderDTO.getQuantity());
    }

    @Test
    void setStatus() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        orderDTO.setStatus(Order.OrderStatus.PENDING);
        assertEquals(Order.OrderStatus.PENDING, orderDTO.getStatus());
    }

    @Test
    void getStatus() {
        orderDTO = new OrderDTO();
        date = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        proUser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        orderDTO.setStatus(Order.OrderStatus.PENDING);
        assertEquals(Order.OrderStatus.PENDING, orderDTO.getStatus());
    }
}
