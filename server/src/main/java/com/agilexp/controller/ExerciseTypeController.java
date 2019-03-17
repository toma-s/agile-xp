package com.agilexp.controller;

import com.agilexp.model.ExerciseType;
import com.agilexp.repository.ExerciseTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class ExerciseTypeController {
    @Autowired
    ExerciseTypeRepository repository;

    @GetMapping("/exercise-types")
    public List<ExerciseType> getAllExerciseTypes() {
        System.out.println("Get all exercise types...");

        List<ExerciseType> exerciseTypes = new ArrayList<>();
        repository.findAll().forEach(exerciseTypes::add);

        return exerciseTypes;
    }

    @GetMapping(value = "/exercise-types/type/{type}")
    public ExerciseType findByType(@PathVariable String type) {

        ExerciseType _exerciseType = repository.findByValue(type);
        return _exerciseType;
    }
}
