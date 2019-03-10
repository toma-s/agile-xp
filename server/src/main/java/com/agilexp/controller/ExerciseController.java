package com.agilexp.controller;

import com.agilexp.model.Exercise;
import com.agilexp.model.Lesson;
import com.agilexp.repository.ExerciseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

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
        Exercise _exercise = repository.save(new Exercise(
                exercise.getName(),
                exercise.getLessonId(),
                exercise.getType(),
                created,
                exercise.getDescription()));
        System.out.format("Created exercise with id %s named %s at %s for lesson #%s", _exercise.getId(), exercise.getName(), created, exercise.getLessonId());
        return _exercise;
    }

    @GetMapping("/exercises")
    public List<Exercise> getAllExercises() {
        System.out.println("Get all exercises...");

        List<Exercise> exercises = new ArrayList<>();
        repository.findAll().forEach(exercises::add);

        System.out.println(exercises);
        return exercises;
    }

    @GetMapping(value="/exercises/exercise-lesson-{lessonId}")
    public List<Exercise> getLessonsByExerciseId(@PathVariable("lessonId") long lessonId) {
        System.out.println("Get exercises with lesson id " + lessonId + "...");

        List<Exercise> exercises = new ArrayList<>(repository.findByLessonId(lessonId));
        return exercises;
    }

    @GetMapping(value="/exercises/exercise-{id}")
    public Exercise getExerciseById(@PathVariable("id") long id) {
        System.out.println("Get exercise with id " + id + "...");

        Optional<Exercise> taskDataOptional = repository.findById(id);
        return taskDataOptional.orElse(null);
    }
}
