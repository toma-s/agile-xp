package com.agilexp.controller;

import com.agilexp.model.HiddenTest;
import com.agilexp.repository.HiddenTestRepository;
import com.agilexp.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class HiddenTestController {
    @Autowired
    HiddenTestRepository repository;
    private final StorageService storageService;

    @Autowired
    public HiddenTestController(StorageService storageService) {
        this.storageService = storageService;
    }

    @PostMapping(value = "/hiddenTest/create")
    public HiddenTest postHiddenTest(@RequestBody HiddenTest hiddenTest) {
        HiddenTest _hiddenTest = repository.save(new HiddenTest(hiddenTest.getFileName(), hiddenTest.getCode(), hiddenTest.getExerciseId()));

        storageService.store(_hiddenTest);

        System.out.format("Created hidden test %s for exercise #%s\n", hiddenTest.getFileName(), hiddenTest.getExerciseId());
        return _hiddenTest;
    }
}
