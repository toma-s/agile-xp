package com.agilexp.controller;

import com.agilexp.model.ExerciseTest;
import com.agilexp.repository.ExerciseTestRepository;
import com.agilexp.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class ExerciseTestController {
    @Autowired
    ExerciseTestRepository repository;
    private final StorageService storageService;

    @Autowired
    public ExerciseTestController(StorageService storageService) {
        this.storageService = storageService;
    }

    @PostMapping(value = "/exercise-tests/create")
    public ExerciseTest postExerciseTest(@RequestBody ExerciseTest exerciseTest) {
        ExerciseTest _exerciseTest = repository.save(new ExerciseTest(
                exerciseTest.getExerciseId(),
                exerciseTest.getFileName(),
                exerciseTest.getContent()));

//        storageService.store(_exerciseTest);

        System.out.format("Created exercise test %s for exercise #%s\n", exerciseTest.getFileName(), exerciseTest.getExerciseId());
        return _exerciseTest;
    }

    @GetMapping(value="/exercise-tests/exercise/{exerciseId}")
    public List<ExerciseTest> getExerciseTestByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get exercise tests with exercise id " + exerciseId + "...");

        List<ExerciseTest> exerciseTests = new ArrayList<>(repository.findExerciseTestsByExerciseId(exerciseId));
        return exerciseTests;
    }
}
