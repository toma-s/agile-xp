package com.agilexp;

import com.agilexp.storage.StorageProperties;
import com.agilexp.storage.StorageService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class)
public class Application {

    private static Long idCounter = 0L;
//    public static final DateFormat formatDateFolder = new SimpleDateFormat("MM-dd-HH-mm-");
//    public static final String appFolder = "temp";

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    CommandLineRunner init(StorageService storageService) {
        return (args) -> {
            storageService.deleteAll();
            storageService.init();
        };
    }

    public static synchronized Long createId(){
        idCounter += 1;
        return idCounter;
    }
}