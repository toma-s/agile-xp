package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PublicFile;
import com.agilexp.service.exercise.PublicFileServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class PublicFileController {

    @Autowired
    private PublicFileServiceImpl service;

    @PostMapping(value = "/public-files/create")
    public ResponseEntity<PublicFile> postPublicFile(@RequestBody PublicFile publicFile) {
        PublicFile newPublicFile = service.create(publicFile);
        return new ResponseEntity<>(newPublicFile, HttpStatus.CREATED);
    }

    @GetMapping(value="/public-files/exercise/{exerciseId}")
    public ResponseEntity<List<PublicFile>> getPublicFilesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        List<PublicFile> publicFiles = service.getByExerciseId(exerciseId);
        return new ResponseEntity<>(publicFiles, HttpStatus.OK);
    }

    @PutMapping("/public-files/{id}")
    public ResponseEntity<PublicFile> updatePublicFile(@PathVariable("id") long id, @RequestBody PublicFile publicFile) {
        if (service.update(id, publicFile)) {
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/public-files/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        service.deleteByExerciseId(exerciseId);
        return new ResponseEntity<>(String.format("Public files from exercise id %s have been deleted", exerciseId), HttpStatus.OK);
    }

}