package com.agilexp.controller;

import com.agilexp.model.ExerciseFile;
import com.agilexp.repository.ExerciseFileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class ExerciseFileController {
    @Autowired
    ExerciseFileRepository repository;

    @PostMapping(value = "/exercise-files/create")
    public ExerciseFile postExerciseFile(@RequestBody ExerciseFile exerciseFile) {
        ExerciseFile _exerciseFile = repository.save(new ExerciseFile(
                exerciseFile.getExerciseId(),
                exerciseFile.getFileName(),
                exerciseFile.getContent()
        ));
        System.out.format("Created exercise file %s\n", _exerciseFile);
        return _exerciseFile;
    }

    @GetMapping(value="/exercise-files/exercise/{exerciseId}")
    public List<ExerciseFile> getExerciseFilesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get exercise files with exercise id " + exerciseId + "...");

        List<ExerciseFile> _exerciseFiles = new ArrayList<>(repository.findExerciseFilesByExerciseId(exerciseId));
        System.out.format("Found exercise files from exercise %s: %s\n", exerciseId, _exerciseFiles);
        return _exerciseFiles;
    }
}
