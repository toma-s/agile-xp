package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PrivateSource;
import com.agilexp.service.exercise.PrivateSourceServiceImpl;
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
public class PrivateSourceController {

    @Autowired
    private PrivateSourceServiceImpl service;

    @PostMapping(value = "/private-sources/create")
    public ResponseEntity<PrivateSource> postPrivateSource(@RequestBody PrivateSource privateSource) {
        PrivateSource newPrivateSource = service.create(privateSource);
        return new ResponseEntity<>(newPrivateSource, HttpStatus.CREATED);
    }

    @GetMapping(value="/private-sources/exercise/{exerciseId}")
    public ResponseEntity<List<PrivateSource>> getPrivateSourcesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        List<PrivateSource> privateSources = service.getByExerciseId(exerciseId);
        return new ResponseEntity<>(privateSources, HttpStatus.OK);
    }

    @PutMapping("/private-sources/{id}")
    public ResponseEntity<PrivateSource> updatePrivateSource(@PathVariable("id") long id, @RequestBody PrivateSource privateSource) {
        if (service.update(id, privateSource)) {
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/private-sources/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        service.deleteByExerciseId(exerciseId);
        return new ResponseEntity<>(String.format("Private sources from exercise id %s have been deleted", exerciseId), HttpStatus.OK);
    }
}
