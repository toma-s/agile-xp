package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PrivateTest;
import com.agilexp.service.exercise.PrivateTestServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class PrivateTestController {

    @Autowired
    private PrivateTestServiceImpl service;

    @PostMapping(value = "/private-tests/create")
    public ResponseEntity<PrivateTest> postPrivateTest(@RequestBody PrivateTest privateTest) {
        PrivateTest newPrivateTest = service.create(privateTest);
        return new ResponseEntity<>(newPrivateTest, HttpStatus.CREATED);
    }

    @GetMapping(value="/private-tests/exercise/{exerciseId}")
    public ResponseEntity<List<PrivateTest>> getPrivateTestsByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        List<PrivateTest> privateTests = service.getByExerciseId(exerciseId);
        return new ResponseEntity<>(privateTests, HttpStatus.OK);
    }

    @PutMapping("/private-tests/{id}")
    public ResponseEntity<PrivateTest> updatePrivateTest(@PathVariable("id") long id, @RequestBody PrivateTest privateTest) {
        if (service.update(id, privateTest)) {
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/private-tests/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        service.deleteByExerciseId(exerciseId);
        return new ResponseEntity<>(String.format("Private tests from exercise id %s have been deleted", exerciseId), HttpStatus.OK);
    }
}
