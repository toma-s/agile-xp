package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PublicTest;
import com.agilexp.repository.exercise.PublicTestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

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

    @GetMapping(value="/public-test/exercise/{exerciseId}")
    public List<PublicTest> getPublicTestsByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get public tests with exercise id " + exerciseId + "...");

        List<PublicTest> publicTests = new ArrayList<>(repository.findPublicTestsByExerciseId(exerciseId));
        return publicTests;
    }
}
