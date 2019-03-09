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

    @PostMapping(value = "/hiddenTest/create")
    public HiddenTest postHiddenTest(@RequestBody HiddenTest hiddenTest) {

        // TODO: 08-Mar-19 create file

        HiddenTest _hiddenTest = repository.save(new HiddenTest(hiddenTest.getFileName(), hiddenTest.getCode(), hiddenTest.getExerciseId()));
        System.out.format("Created hidden test %s for exercise #%s\n", hiddenTest.getFileName(), hiddenTest.getExerciseId());
        return _hiddenTest;
    }
}
