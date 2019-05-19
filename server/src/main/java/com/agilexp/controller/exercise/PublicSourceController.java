package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PublicSource;
import com.agilexp.repository.exercise.PublicSourceRepository;
import com.agilexp.service.exercise.PublicSourceServiceImpl;
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
public class PublicSourceController {

    @Autowired
    private PublicSourceServiceImpl service;

    @PostMapping(value = "/public-sources/create")
    public ResponseEntity<PublicSource> postPublicSource(@RequestBody PublicSource publicSource) {
        PublicSource newPublicSource = service.create(publicSource);
        return new ResponseEntity<>(newPublicSource, HttpStatus.CREATED);
    }

    @GetMapping(value="/public-sources/exercise/{exerciseId}")
    public ResponseEntity<List<PublicSource>> getPublicSourcesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        List<PublicSource> publicSources = service.getByExerciseId(exerciseId);
        return new ResponseEntity<>(publicSources, HttpStatus.OK);
    }

    @PutMapping("/public-sources/{id}")
    public ResponseEntity<PublicSource> updatePublicSource(@PathVariable("id") long id, @RequestBody PublicSource publicSource) {
        if (service.update(id, publicSource)) {
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/public-sources/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        service.deleteByExerciseId(exerciseId);
        return new ResponseEntity<>(String.format("Public sorces from exercise id %s have been deleted", exerciseId), HttpStatus.OK);
    }
}
