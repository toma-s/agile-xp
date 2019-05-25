package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.BugsNumber;
import com.agilexp.service.exercise.BugsNumberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class BugsNumberController {

    @Autowired
    private BugsNumberService service;

    @GetMapping(value = "/bugs-number/{exerciseId}/{bugsNumber}")
    public ResponseEntity<BugsNumber> createBugsNumber(@PathVariable("exerciseId") long exerciseId, @PathVariable("bugsNumber") int bugsNumber) {
        BugsNumber newBugsNumber = service.create(exerciseId, bugsNumber);
        return new ResponseEntity<>(newBugsNumber, HttpStatus.OK);
    }

    @GetMapping(value = "/bugs-number/exercise/{exerciseId}")
    public ResponseEntity<BugsNumber> getBugsNumberByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        BugsNumber newBugsNumber = service.getByExerciseId(exerciseId);
        return new ResponseEntity<>(newBugsNumber, HttpStatus.OK);
    }
}
