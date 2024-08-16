package usyd.elec5619.demo.USER;

import jakarta.validation.constraints.NotBlank;

public class LoginDTO {


    @NotBlank
    private String email;

    @NotBlank
    private String password;


    public LoginDTO(String email, String password){
        this.email = email;
        this.password = password;
    }


    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

}
