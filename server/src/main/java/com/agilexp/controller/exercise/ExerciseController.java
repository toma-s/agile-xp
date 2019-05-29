package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.Exercise;
import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.service.exercise.ExerciseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class ExerciseController {

    @Autowired
    private ExerciseService service;

    @PostMapping(value = "/exercises/create")
    public ResponseEntity<Exercise> createExercise(@RequestBody Exercise exercise) {
        Exercise newExercise = service.create(exercise);
        return new ResponseEntity<>(newExercise, HttpStatus.CREATED);
    }

    @GetMapping(value = "/exercises/{id}")
    public ResponseEntity<Exercise> getExerciseById(@PathVariable("id") long id) {
        Exercise exercise = service.getById(id);
        return new ResponseEntity<>(exercise, HttpStatus.OK);
    }

    @GetMapping(value = "/exercises/lesson/{lessonId}")
    public ResponseEntity<List<Exercise>> getExercisesByLessonId(@PathVariable("lessonId") long lessonId) {
        List<Exercise> exercises = service.getByLessonId(lessonId);
        return new ResponseEntity<>(exercises, HttpStatus.OK);
    }

    @GetMapping("/exercises")
    public ResponseEntity<List<Exercise>> getAllExercises() {
        List<Exercise> exercises = service.getAll();
        return new ResponseEntity<>(exercises, HttpStatus.OK);
    }

    @PutMapping("/exercises/{id}")
    public ResponseEntity<Exercise> updateExercise(@PathVariable("id") long id, @RequestBody Exercise exercise) {
        if (service.update(id, exercise)) {
            Exercise updatedExercise = service.getById(id);
            return new ResponseEntity<>(updatedExercise, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/exercises/{id}")
    public ResponseEntity<String> deleteExercise(@PathVariable("id") long id) {
        service.delete(id);
        return new ResponseEntity<>(
                String.format("Exercise with id %s has been deleted", id),
                HttpStatus.OK);
    }
}
