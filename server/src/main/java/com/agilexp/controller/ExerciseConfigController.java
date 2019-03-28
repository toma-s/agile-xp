package com.agilexp.controller;

import com.agilexp.model.ExerciseConfig;
import com.agilexp.repository.ExerciseConfigRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class ExerciseConfigController {
    @Autowired
    ExerciseConfigRepository repository;

    @PostMapping(value = "/exercise-configs/create")
    public ExerciseConfig postExerciseConfig(@RequestBody ExerciseConfig exerciseConfig) {
        ExerciseConfig _exerciseConfig = repository.save(new ExerciseConfig(
                exerciseConfig.getExerciseId(),
                exerciseConfig.getFileName(),
                exerciseConfig.getText()
        ));
        System.out.format("Created exercise config %s\n", _exerciseConfig);
        return _exerciseConfig;
    }

    @GetMapping(value="/exercise-configs/exercise/{exerciseId}")
    public List<ExerciseConfig> getExerciseConfigsByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get exercise configs with exercise id " + exerciseId + "...");

        List<ExerciseConfig> exerciseConfigs = new ArrayList<>(repository.findByExerciseId(exerciseId));
        return exerciseConfigs;
    }
}
