package usyd.elec5619.demo.USER;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.junit.jupiter.api.Test;

import static org.mockito.Mockito.*;
import org.springframework.http.MediaType;
import usyd.elec5619.demo.USER.UserService;
import usyd.elec5619.demo.USER.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import usyd.elec5619.demo.config.JwtUtil;

import org.springframework.boot.test.mock.mockito.MockBean;
import org.junit.jupiter.api.BeforeEach;

@SpringBootTest
@AutoConfigureMockMvc
public class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserService userService;

    @MockBean
    private PasswordEncoder passwordEncoder;

    @MockBean
    private JwtUtil jwtUtil;


    @Test
    public void testLogin() throws Exception {

        User testUser = new User();
        testUser.setEmail("han@han.com");
        testUser.setPassword("123");

        when(userService.findByEmail("han@han.com")).thenReturn(testUser);
        when(passwordEncoder.matches(anyString(), anyString())).thenReturn(true);
        when(jwtUtil.generateToken(anyString())).thenReturn("testToken");

        mockMvc.perform(MockMvcRequestBuilders.post("/pwf/login")
                        .param("email", "han@han.com")
                        .param("password", "123"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.header().string("Authorization", "testToken"));

        verify(userService).findByEmail("han@han.com");
        verify(passwordEncoder).matches("123", testUser.getPassword());
    }
}
