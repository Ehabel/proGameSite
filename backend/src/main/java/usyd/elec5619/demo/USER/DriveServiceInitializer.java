package usyd.elec5619.demo.USER;

import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.DriveScopes;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import jakarta.persistence.Entity;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import java.io.FileInputStream;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

@Component
public class DriveServiceInitializer {

    private static final String APPLICATION_NAME = "ELEC5622"; // 替换为您的应用程序名称
    private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance(); // 使用JacksonFactory
    private static final String CREDENTIALS_FILE_PATH = "credentials.json"; // 替换为您的凭据文件路径

    public static Drive initializeDriveService() throws GeneralSecurityException, IOException {
        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        GoogleCredential credentials = GoogleCredential.fromStream(new FileInputStream(CREDENTIALS_FILE_PATH))
                .createScoped(Collections.singletonList(DriveScopes.DRIVE));
        return new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, credentials)
                .setApplicationName(APPLICATION_NAME)
                .build();
    }

}