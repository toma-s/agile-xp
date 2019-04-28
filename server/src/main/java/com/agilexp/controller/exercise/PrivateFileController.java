package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.repository.exercise.PrivateFileRepository;
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
public class PrivateFileController {
    @Autowired
    PrivateFileRepository repository;

    @PostMapping(value = "/private-files/create")
    public PrivateFile postPrivateFile(@RequestBody PrivateFile exerciseFile) {
        PrivateFile _exerciseFile = repository.save(new PrivateFile(
                exerciseFile.getExerciseId(),
                exerciseFile.getFilename(),
                exerciseFile.getContent()
        ));
        System.out.format("Created PrivateFile %s\n", _exerciseFile);
        return _exerciseFile;
    }

    @GetMapping(value="/private-files/exercise/{exerciseId}")
    public List<PrivateFile> getPrivateFilesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get exercise files with exercise id " + exerciseId + "...");

        List<PrivateFile> _exerciseFiles = new ArrayList<>(repository.findPrivateFilesByExerciseId(exerciseId));
        System.out.format("Found exercise files from exercise %s: %s\n", exerciseId, _exerciseFiles);
        return _exerciseFiles;
    }

    @PutMapping("/private-files/{id}")
    public ResponseEntity<PrivateFile> updatePrivateFile(@PathVariable("id") long id, @RequestBody PrivateFile privateFile) {
        System.out.println("Update PublicFile with ID = " + id + "...");

        Optional<PrivateFile> privateFileData = repository.findById(id);

        if (privateFileData.isPresent()) {
            PrivateFile _privateFile = privateFileData.get();
            _privateFile.setFilename(privateFile.getFilename());
            _privateFile.setExerciseId(privateFile.getExerciseId());
            _privateFile.setContent(privateFile.getContent());
            return new ResponseEntity<>(repository.save(_privateFile), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/private-files/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Delete PrivateFile with exercise ID = " + exerciseId + "...");

        List<PrivateFile> privateFiles = repository.findPrivateFilesByExerciseId(exerciseId);
        privateFiles.forEach(privateFile -> {
            repository.delete(privateFile);
        });


        return new ResponseEntity<>("Private files have been deleted!", HttpStatus.OK);
    }
}
