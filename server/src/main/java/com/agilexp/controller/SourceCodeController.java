package com.agilexp.controller;

import com.agilexp.model.SourceCode;
import com.agilexp.repository.SourceCodeRepository;
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

    @PostMapping(value = "/sourceCode/create")
    public SourceCode postCourse(@RequestBody SourceCode sourceCode) {

        // TODO: 08-Mar-19 create file

        System.out.println(sourceCode.getExerciseId());

        SourceCode _message = repository.save(new SourceCode(sourceCode.getFileName(), sourceCode.getExerciseId()));
        System.out.format("Created source code %s for exercise #%s", sourceCode.getFileName(), sourceCode.getExerciseId());
        return _message;
    }
}
