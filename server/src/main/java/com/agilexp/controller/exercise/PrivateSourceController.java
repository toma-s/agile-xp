package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PrivateSource;
import com.agilexp.repository.exercise.PrivateSourceRepository;
import com.agilexp.storage.StorageService;
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
    PrivateSourceRepository repository;

    @PostMapping(value = "/private-sources/create")
    public PrivateSource postPrivateSource(@RequestBody PrivateSource sourceCode) {

        PrivateSource _sourceCode = repository.save(new PrivateSource(
                sourceCode.getExerciseId(),
                sourceCode.getFilename(),
                sourceCode.getContent()

        ));

        System.out.format("Created PrivateSource %s for exercise #%s\n", sourceCode.getFilename(), sourceCode.getExerciseId());
        return _sourceCode;
    }

    @GetMapping(value="/private-sources/exercise/{exerciseId}")
    public List<PrivateSource> getPrivateSourcesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get exercise sources with exercise id " + exerciseId + "...");

        List<PrivateSource> exerciseSources = new ArrayList<>(repository.findPrivateSourcesByExerciseId(exerciseId));
        return exerciseSources;
    }

    @PutMapping("/private-sources/{id}")
    public ResponseEntity<PrivateSource> updatePrivateSource(@PathVariable("id") long id, @RequestBody PrivateSource privateSource) {
        System.out.println("Update PublicSource with ID = " + id + "...");

        Optional<PrivateSource> privateSourceData = repository.findById(id);

        if (privateSourceData.isPresent()) {
            PrivateSource _privateSource = privateSourceData.get();
            _privateSource.setFilename(privateSource.getFilename());
            _privateSource.setExerciseId(privateSource.getExerciseId());
            _privateSource.setContent(privateSource.getContent());
            return new ResponseEntity<>(repository.save(_privateSource), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/private-sources/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Delete PrivateSource with exercise ID = " + exerciseId + "...");

        List<PrivateSource> privateSources = repository.findPrivateSourcesByExerciseId(exerciseId);
        privateSources.forEach(privateSource -> {
            repository.delete(privateSource);
        });


        return new ResponseEntity<>("Private sources have been deleted!", HttpStatus.OK);
    }
}
