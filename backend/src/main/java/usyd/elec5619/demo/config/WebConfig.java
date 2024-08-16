package usyd.elec5619.demo.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${flutter.assets}")
    private String flutterPath;

    @Override
    public void addCorsMappings(CorsRegistry registry){
        String[] allowedOrigins = {"http://127.0.0.1:5173", "http://localhost:5173", "http://localhost:5000"};
        registry.addMapping("/**")
                .allowedOrigins(allowedOrigins).allowCredentials(true)
                .allowedMethods("GET", "POST", "DELETE", "PATCH")
                .allowedHeaders("*").exposedHeaders("Authorization", "Set-Cookie");

    }
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/images/**")
                .addResourceLocations("file:"+ flutterPath)
                .setCachePeriod(0);
    }
}