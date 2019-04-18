package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PrivateSource;
import com.agilexp.repository.exercise.PrivateSourceRepository;
import com.agilexp.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class PrivateSourceController {
    @Autowired
    PrivateSourceRepository repository;

    @PostMapping(value = "/private-sources/create")
    public PrivateSource postExerciseSource(@RequestBody PrivateSource sourceCode) {

        PrivateSource _sourceCode = repository.save(new PrivateSource(
                sourceCode.getExerciseId(),
                sourceCode.getFilename(),
                sourceCode.getContent()

        ));

        System.out.format("Created source code %s for exercise #%s\n", sourceCode.getFilename(), sourceCode.getExerciseId());
        return _sourceCode;
    }

    @GetMapping(value="/private-sources/exercise/{exerciseId}")
    public List<PrivateSource> getExerciseSourcesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get exercise sources with exercise id " + exerciseId + "...");

        List<PrivateSource> exerciseSources = new ArrayList<>(repository.findExerciseSourcesByExerciseId(exerciseId));
        return exerciseSources;
    }
}
