package com.agilexp.controller;

import com.agilexp.model.Exercise;
import com.agilexp.model.Lesson;
import com.agilexp.repository.ExerciseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
                exercise.getIndex(),
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

    @GetMapping(value="/exercises/lesson/{lessonId}")
    public List<Exercise> getExercisesByLessonId(@PathVariable("lessonId") long lessonId) {
        System.out.println("Get exercises with lesson id " + lessonId + "...");

        List<Exercise> exercises = new ArrayList<>(repository.findByLessonId(lessonId));
        return exercises;
    }

    @GetMapping(value="/exercises/{id}")
    public Exercise getExerciseById(@PathVariable("id") long id) {
        System.out.println("Get exercise with id " + id + "...");

        Optional<Exercise> taskDataOptional = repository.findById(id);
        return taskDataOptional.orElse(null);
    }

    @PutMapping("/exercises/{id}")
    public ResponseEntity<Exercise> updateExercise(@PathVariable("id") long id, @RequestBody Exercise exercise) {
        System.out.println("Update Exercise with ID = " + id + "...");

        Optional<Exercise> exerciseData = repository.findById(id);

        if (exerciseData.isPresent()) {
            Exercise _exercise = exerciseData.get();
            _exercise.setName(exercise.getName());
            _exercise.setIndex(exercise.getIndex());
            _exercise.setLessonId(exercise.getLessonId());
            _exercise.setDescription(exercise.getDescription());
            _exercise.setCreated(exercise.getCreated());
            _exercise.setType(exercise.getType());
            return new ResponseEntity<>(repository.save(_exercise), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
