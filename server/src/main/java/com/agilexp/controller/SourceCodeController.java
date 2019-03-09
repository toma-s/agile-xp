package com.agilexp.controller;

import com.agilexp.model.SourceCode;
import com.agilexp.repository.SourceCodeRepository;
import com.agilexp.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.Date;

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
        System.out.format("Created source code %s for exercise #%s\n", sourceCode.getFileName(), sourceCode.getExerciseId());
        return _sourceCode;
    }
}
