package com.agilexp.controller;

import com.agilexp.model.ExerciseTest;
import com.agilexp.repository.ExerciseTestRepository;
import com.agilexp.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping(value = "/hiddenTest/create")
    public ExerciseTest postHiddenTest(@RequestBody ExerciseTest hiddenTest) {
        ExerciseTest _hiddenTest = repository.save(new ExerciseTest(hiddenTest.getFileName(), hiddenTest.getCode(), hiddenTest.getExerciseId()));

        storageService.store(_hiddenTest);

        System.out.format("Created hidden test %s for exercise #%s\n", hiddenTest.getFileName(), hiddenTest.getExerciseId());
        return _hiddenTest;
    }
}
