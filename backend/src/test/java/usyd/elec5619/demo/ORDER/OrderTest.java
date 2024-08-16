package usyd.elec5619.demo.ORDER;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.security.core.parameters.P;
import usyd.elec5619.demo.USER.User;

import java.math.BigDecimal;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;

class OrderTest {
    User user;
    User Prouser;
    Order order;
    Date date = new Date();



    @Test
    void getUser() {
        user = new User("Fname","Lname","123@gmail.com","abc123");
        Prouser = new User("P_fname","P_lname","1234@gmail.com","abc123",true,BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123),user,Prouser,date,BigDecimal.valueOf(10),2.5, Order.OrderStatus.PENDING);
        assertEquals(order.getUser().getfName(),"Fname");
    }

    @Test
    void setUser() {
        user = new User("Fname","Lname","123@gmail.com","abc123");
        User user1 = new User("Fname1","Lname1","12311@gmail.com","abc123");
        Prouser = new User("P_fname","P_lname","1234@gmail.com","abc123",true,BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123),user,Prouser,date,BigDecimal.valueOf(10),2.5, Order.OrderStatus.PENDING);
        assertEquals(order.getUser().getfName(),"Fname");
        order.setUser(user1);
        assertEquals(order.getUser().getfName(),"Fname1");

    }

    @Test
    void getOrder_id() {
        user = new User("Fname","Lname","123@gmail.com","abc123");
        Prouser = new User("P_fname","P_lname","1234@gmail.com","abc123",true,BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123),user,Prouser,date,BigDecimal.valueOf(10),2.5, Order.OrderStatus.PENDING);
        assertEquals(order.getOrder_id(),123);
    }

    @Test
    void setOrder_id() {
        user = new User("Fname","Lname","123@gmail.com","abc123");
        Prouser = new User("P_fname","P_lname","1234@gmail.com","abc123",true,BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123),user,Prouser,date,BigDecimal.valueOf(10),2.5, Order.OrderStatus.PENDING);
        assertEquals(order.getOrder_id(),123);
        order.setOrder_id(Long.valueOf(1234));
        assertEquals(order.getOrder_id(),1234);
    }

    @Test
    void getProUser() {
        user = new User("Fname","Lname","123@gmail.com","abc123");
        Prouser = new User("P_fname","P_lname","1234@gmail.com","abc123",true,BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123),user,Prouser,date,BigDecimal.valueOf(10),2.5, Order.OrderStatus.PENDING);
        assertEquals(order.getProUser().getfName(),"P_fname");
    }

    @Test
    void setProUser() {
        user = new User("Fname","Lname","123@gmail.com","abc123");
        Prouser = new User("P_fname","P_lname","1234@gmail.com","abc123",true,BigDecimal.valueOf(4.1));
        User Prouser1 = new User("Fname1","Lname1","12311@gmail.com","abc123",true,BigDecimal.valueOf(4.0));
        order = new Order(Long.valueOf(123),user,Prouser,date,BigDecimal.valueOf(10),2.5, Order.OrderStatus.PENDING);
        assertEquals(order.getProUser().getfName(),"P_fname");
        order.setProUser(Prouser1);
        assertEquals(order.getProUser().getfName(),"Fname1");

    }

    @Test
    void getOrderDate() {
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        Prouser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123), user, Prouser, date, BigDecimal.valueOf(10), 2.5, Order.OrderStatus.PENDING);
        assertEquals(order.getOrderDate(), date);
    }

    @Test
    void setOrderDate() {
        Date newDate = new Date();
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        Prouser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123), user, Prouser, date, BigDecimal.valueOf(10), 2.5, Order.OrderStatus.PENDING);
        order.setOrderDate(newDate);
        assertEquals(order.getOrderDate(), newDate);
    }

    @Test
    void getAmount() {
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        Prouser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123), user, Prouser, date, BigDecimal.valueOf(10), 2.5, Order.OrderStatus.PENDING);
        assertEquals(order.getAmount(), BigDecimal.valueOf(10));
    }

    @Test
    void setAmount() {
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        Prouser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123), user, Prouser, date, BigDecimal.valueOf(10), 2.5, Order.OrderStatus.PENDING);
        order.setAmount(BigDecimal.valueOf(20));
        assertEquals(order.getAmount(), BigDecimal.valueOf(20));
    }

    @Test
    void getQuantity() {
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        Prouser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123), user, Prouser, date, BigDecimal.valueOf(10), 2.5, Order.OrderStatus.PENDING);
        assertEquals(order.getQuantity(), 2.5);
    }

    @Test
    void setQuantity() {
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        Prouser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123), user, Prouser, date, BigDecimal.valueOf(10), 2.5, Order.OrderStatus.PENDING);
        order.setQuantity(5.0);
        assertEquals(order.getQuantity(), 5.0);
    }

    @Test
    void setStatus() {
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        Prouser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123), user, Prouser, date, BigDecimal.valueOf(10), 2.5, Order.OrderStatus.PENDING);
        order.setStatus(Order.OrderStatus.ACCEPTED);
        assertEquals(order.getStatus(), Order.OrderStatus.ACCEPTED);
    }

    @Test
    void getStatus() {
        user = new User("Fname", "Lname", "123@gmail.com", "abc123");
        Prouser = new User("P_fname", "P_lname", "1234@gmail.com", "abc123", true, BigDecimal.valueOf(4.1));
        order = new Order(Long.valueOf(123), user, Prouser, date, BigDecimal.valueOf(10), 2.5, Order.OrderStatus.PENDING);
        assertEquals(order.getStatus(), Order.OrderStatus.PENDING);
    }
}