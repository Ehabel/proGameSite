package usyd.elec5619.demo.USER;

import jakarta.validation.constraints.NotBlank;

public class SignupDTO {

    @NotBlank
    private String fName;

    @NotBlank
    private String lName;

    @NotBlank
    private String email;

    @NotBlank
    private String password;

    @NotBlank
    private String match_password;

    public SignupDTO(String fName, String lName, String email, String password, String match_password){
        this.fName = fName;
        this.lName = lName;
        this.email = email;
        this.password = password;
        this.match_password = match_password;
    }

    public String getfName() {
        return fName;
    }

    public String getlName() {
        return lName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public String getMatchPassword() {
        return match_password;
    }

}
