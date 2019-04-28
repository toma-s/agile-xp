package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PublicSource;
import com.agilexp.repository.exercise.PublicSourceRepository;
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
    private PublicSourceRepository repository;

    @PostMapping(value = "/public-sources/create")
    public PublicSource postPublicSource(@RequestBody PublicSource publicSource) {

        PublicSource _publicSource = repository.save(new PublicSource(
                publicSource.getExerciseId(),
                publicSource.getFilename(),
                publicSource.getContent()

        ));

        System.out.format("Created PublicSource %s for exercise #%s\n", publicSource.getFilename(), publicSource.getExerciseId());
        return _publicSource;
    }

    @GetMapping(value="/public-sources/exercise/{exerciseId}")
    public List<PublicSource> getPublicSourcesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get public sources with exercise id " + exerciseId + "...");

        List<PublicSource> publicSources = new ArrayList<>(repository.findPublicSourcesByExerciseId(exerciseId));
        return publicSources;
    }

    @PutMapping("/public-sources/{id}")
    public ResponseEntity<PublicSource> updatePublicSource(@PathVariable("id") long id, @RequestBody PublicSource publicSource) {
        System.out.println("Update PublicSource with ID = " + id + "...");

        Optional<PublicSource> publicSourceData = repository.findById(id);

        if (publicSourceData.isPresent()) {
            PublicSource _publicSource = publicSourceData.get();
            _publicSource.setFilename(publicSource.getFilename());
            _publicSource.setExerciseId(publicSource.getExerciseId());
            _publicSource.setContent(publicSource.getContent());
            return new ResponseEntity<>(repository.save(_publicSource), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/public-sources/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Delete PublicSource with exercise ID = " + exerciseId + "...");

        List<PublicSource> publicSources = repository.findPublicSourcesByExerciseId(exerciseId);
        publicSources.forEach(publicSource -> {
            repository.delete(publicSource);
        });


        return new ResponseEntity<>("Public sources have been deleted!", HttpStatus.OK);
    }
}
