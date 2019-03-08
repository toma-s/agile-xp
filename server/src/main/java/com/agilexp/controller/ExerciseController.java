package com.agilexp.controller;

import com.agilexp.model.Exercise;
import com.agilexp.repository.ExerciseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.Date;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class ExerciseController {
    @Autowired
    ExerciseRepository repository;

    @PostMapping(value = "/exercises/create")
    public Exercise postExercise(@RequestBody Exercise exercise) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());
        Exercise _message = repository.save(new Exercise(
                exercise.getName(),
                exercise.getLessonId(),
                exercise.getType(),
                created,
                exercise.getDescription()));
        System.out.format("Created exercise %s at %s for lesson #%s", exercise.getName(), created, exercise.getLessonId());
        return _message;
    }
}
