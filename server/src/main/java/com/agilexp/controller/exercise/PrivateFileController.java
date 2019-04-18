package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.repository.exercise.PrivateFileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class PrivateFileController {
    @Autowired
    PrivateFileRepository repository;

    @PostMapping(value = "/private-files/create")
    public PrivateFile postExerciseFile(@RequestBody PrivateFile exerciseFile) {
        PrivateFile _exerciseFile = repository.save(new PrivateFile(
                exerciseFile.getExerciseId(),
                exerciseFile.getFilename(),
                exerciseFile.getContent()
        ));
        System.out.format("Created exercise file %s\n", _exerciseFile);
        return _exerciseFile;
    }

    @GetMapping(value="/private-files/exercise/{exerciseId}")
    public List<PrivateFile> getExerciseFilesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get exercise files with exercise id " + exerciseId + "...");

        List<PrivateFile> _exerciseFiles = new ArrayList<>(repository.findPrivateFilesByExerciseId(exerciseId));
        System.out.format("Found exercise files from exercise %s: %s\n", exerciseId, _exerciseFiles);
        return _exerciseFiles;
    }
}
