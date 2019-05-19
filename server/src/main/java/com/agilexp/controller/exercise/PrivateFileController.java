package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.service.exercise.PrivateFileServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class PrivateFileController {

    @Autowired
    private PrivateFileServiceImpl service;

    @PostMapping(value = "/private-files/create")
    public ResponseEntity<PrivateFile> createPrivateFile(@RequestBody PrivateFile privateFile) {
        PrivateFile newPrivateFile = service.create(privateFile);
        return new ResponseEntity<>(newPrivateFile, HttpStatus.CREATED);
    }

    @GetMapping(value="/private-files/exercise/{exerciseId}")
    public ResponseEntity<List<PrivateFile>> getPrivateFilesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        List<PrivateFile> privateFiles = service.getByExerciseId(exerciseId);
        return new ResponseEntity<>(privateFiles, HttpStatus.OK);
    }

    @PutMapping("/private-files/{id}")
    public ResponseEntity<PrivateFile> updatePrivateFile(@PathVariable("id") long id, @RequestBody PrivateFile privateFile) {
        if (service.update(id, privateFile)) {
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/private-files/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        service.deleteByExerciseId(exerciseId);
        return new ResponseEntity<>(String.format("Private files from exercise id %s have been deleted", exerciseId), HttpStatus.OK);
    }
}
