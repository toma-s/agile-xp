package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PublicTest;
import com.agilexp.repository.exercise.PublicTestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class PublicTestController {
    @Autowired
    private PublicTestRepository repository;

    @PostMapping(value = "/public-test/create")
    public PublicTest postPublicTest(@RequestBody PublicTest publicTest) {

        PublicTest _publicCode = repository.save(new PublicTest(
                publicTest.getExerciseId(),
                publicTest.getFilename(),
                publicTest.getContent()

        ));

        System.out.format("Created shown test %s for exercise #%s\n", publicTest.getFilename(), publicTest.getExerciseId());
        return _publicCode;
    }
}
