package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.ExerciseType;
import com.agilexp.repository.exercise.ExerciseTypeRepository;
import com.agilexp.service.exercise.ExerciseTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class ExerciseTypeController {
    @Autowired
    ExerciseTypeService exerciseTypeService;

    @GetMapping(value="/exercise-types/{id}")
    public ResponseEntity<ExerciseType> getExerciseTypeById(@PathVariable("id") long id) {
        ExerciseType exerciseType = exerciseTypeService.getById(id);
        return new ResponseEntity<>(exerciseType, HttpStatus.OK);
    }

    @GetMapping(value = "/exercise-types/value/{value}")
    public ResponseEntity<ExerciseType> findByValue(@PathVariable String value) {
        ExerciseType exerciseType = exerciseTypeService.getByValue(value);
        return new ResponseEntity<>(exerciseType, HttpStatus.OK);
    }

    @GetMapping("/exercise-types")
    public ResponseEntity<List<ExerciseType>> getAllExerciseTypes() {
        List<ExerciseType> exerciseTypes = exerciseTypeService.getAll();
        return new ResponseEntity<>(exerciseTypes, HttpStatus.OK);
    }
}
