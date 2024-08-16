package usyd.elec5619.demo.USER;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.util.List;

public class UserDTO {

    private String fName;

    private String lName;

    @NotBlank
    private String email;

    private String password;

    private String description;

    private BigDecimal rating;

    private List<UserImageDTO> images;

    private String picture;

    private boolean isPro;

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

    public String getDescription(){
        return description;
    }

    public List<UserImageDTO> getImages(){
        return images;
    }

    public boolean isPro(){
        return isPro;
    }

    // For Pro users
    public void setPro(boolean isPro){
        this.isPro = isPro;
    }

    public BigDecimal getRating() {
        return rating;
    }

    public void setfName(String fName) {
        this.fName = fName;
    }

    public void setlName(String lName) {
        this.lName = lName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }

    public void setImages(List<UserImageDTO> images) {
        this.images = images;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }
}
