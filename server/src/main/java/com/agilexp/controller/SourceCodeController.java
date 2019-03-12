package com.agilexp.controller;

import com.agilexp.model.SourceCode;
import com.agilexp.repository.SourceCodeRepository;
import com.agilexp.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SourceCodeController {
    @Autowired
    SourceCodeRepository repository;
    private final StorageService storageService;

    @Autowired
    public SourceCodeController(StorageService storageService) {
        this.storageService = storageService;
    }

    @PostMapping(value = "/sourceCode/create")
    public SourceCode postSourceCode(@RequestBody SourceCode sourceCode) {

        SourceCode _sourceCode = repository.save(new SourceCode(sourceCode.getFileName(), sourceCode.getCode(), sourceCode.getExerciseId()));

        storageService.store(_sourceCode);

        System.out.format("Created source code %s for exercise #%s\n", sourceCode.getFileName(), sourceCode.getExerciseId());
        return _sourceCode;
    }

    @GetMapping(value="/sourceCode/source-codes-exercise-{exerciseId}")
    public List<SourceCode> getSourceCodesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get source codes with exercise id " + exerciseId + "...");

        List<SourceCode> sourceCodes = new ArrayList<>(repository.findByExerciseId(exerciseId));
        return sourceCodes;
    }
}
