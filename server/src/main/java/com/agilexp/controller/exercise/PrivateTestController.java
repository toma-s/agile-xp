package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PrivateTest;
import com.agilexp.repository.exercise.PrivateTestRepository;
import com.agilexp.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class PrivateTestController {
    @Autowired
    PrivateTestRepository repository;

    @PostMapping(value = "/private-tests/create")
    public PrivateTest postExerciseTest(@RequestBody PrivateTest exerciseTest) {
        PrivateTest _exerciseTest = repository.save(new PrivateTest(
                exerciseTest.getExerciseId(),
                exerciseTest.getFilename(),
                exerciseTest.getContent()));

        System.out.format("Created exercise test %s for exercise #%s\n", exerciseTest.getFilename(), exerciseTest.getExerciseId());
        return _exerciseTest;
    }

    @GetMapping(value="/private-tests/exercise/{exerciseId}")
    public List<PrivateTest> getExerciseTestByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get exercise tests with exercise id " + exerciseId + "...");

        List<PrivateTest> exerciseTests = new ArrayList<>(repository.findPrivateTestsByExerciseId(exerciseId));
        return exerciseTests;
    }
}
