package com.agilexp.controller;

import com.agilexp.model.HiddenTest;
import com.agilexp.repository.HiddenTestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class HiddenTestController {
    @Autowired
    HiddenTestRepository repository;

    @PostMapping(value = "/sourceCode/create")
    public HiddenTest postCourse(@RequestBody HiddenTest hiddenTest) {

        // TODO: 08-Mar-19 create file

        HiddenTest _hidden_test = repository.save(new HiddenTest());
        System.out.format("Created source code %s for exercise #%s", hiddenTest.getFileName(), hiddenTest.getId());
        return _hidden_test;
    }
}
