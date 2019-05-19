package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PublicTest;
import com.agilexp.service.exercise.PublicTestServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class PublicTestController {

    @Autowired
    private PublicTestServiceImpl service;

    @PostMapping(value = "/public-tests/create")
    public ResponseEntity<PublicTest> postPublicTest(@RequestBody PublicTest publicTest) {
        PublicTest newPrivateTest = service.create(publicTest);
        return new ResponseEntity<>(newPrivateTest, HttpStatus.CREATED);
    }

    @GetMapping(value="/public-tests/exercise/{exerciseId}")
    public ResponseEntity<List<PublicTest>> getPublicTestsByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        List<PublicTest> privateTest = service.getByExerciseId(exerciseId);
        return new ResponseEntity<>(privateTest, HttpStatus.OK);
    }

    @PutMapping("/public-tests/{id}")
    public ResponseEntity<PublicTest> updatePublicTest(@PathVariable("id") long id, @RequestBody PublicTest publicTest) {
        if (service.update(id, publicTest)) {
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/public-tests/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        service.deleteByExerciseId(exerciseId);
        return new ResponseEntity<>(String.format("Public tests from exercise id %s have been deleted", exerciseId), HttpStatus.OK);
    }
}
