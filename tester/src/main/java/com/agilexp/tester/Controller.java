package com.agilexp.tester;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@CrossOrigin(origins = "http://localhost:8080/")
@RestController
@RequestMapping("/tester")
public class Controller {

    private RestTemplate restTemplate;

    @Autowired
    public Controller(RestTemplateBuilder builder) {
        this.restTemplate = builder.build();
    }

    @RequestMapping(value = "/sup")
    public String baz(@RequestBody String string) {
        System.out.println("sup!" + string);
        return "Sup" + string;
    }

}
