package usyd.elec5619.demo.USER;


import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.security.core.parameters.P;
import usyd.elec5619.demo.ORDER.Order;
import usyd.elec5619.demo.USER.User;

import java.math.BigDecimal;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;



class UserTest {

    private LoginDTO loginDTO;

    private User user;


    @BeforeEach
    void setUp() {
        loginDTO = new LoginDTO("kevin@123.com", "123");
        user = new User("kevin", "han", "kevin@google.com", "123");
    }

    @Test
    public void testConstructorAndGetterMethods() {
        assertEquals("kevin@123.com", loginDTO.getEmail());
        assertEquals("123", loginDTO.getPassword());
    }

    @Test
    void testInit() {
        assertEquals("kevin", user.getfName());
        assertEquals("han", user.getlName());
        assertEquals("kevin@google.com", user.getEmail());
        assertEquals("123", user.getPassword());
    }

    @Test
    void testProStatus() {
        assertFalse(user.isPro());
        user.setPro(true);
        assertTrue(user.isPro());
    }

    @Test
    void testRating() {
        assertNull(user.getRating());
        user.setRating(BigDecimal.valueOf(4.5));
        assertEquals(BigDecimal.valueOf(4.5), user.getRating());
    }

}
