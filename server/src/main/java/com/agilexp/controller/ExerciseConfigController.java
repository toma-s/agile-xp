package com.agilexp.controller;

import com.agilexp.model.ExerciseConfig;
import com.agilexp.model.SolutionConfig;
import com.agilexp.repository.ExerciseConfigRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class ExerciseConfigController {
    @Autowired
    ExerciseConfigRepository repository;

    @PostMapping(value = "/exercise-configs/create")
    public ExerciseConfig postExerciseConfig(@RequestBody ExerciseConfig exerciseConfig) {
        ExerciseConfig _exerciseConfig = repository.save(new ExerciseConfig(
                exerciseConfig.getSolutionId(),
                exerciseConfig.getFileName(),
                exerciseConfig.getText()
        ));
        System.out.format("Created exercise config %s\n", _exerciseConfig);
        return _exerciseConfig;
    }
}
