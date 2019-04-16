package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PublicSource;
import com.agilexp.repository.exercise.PublicSourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class PublicSourceController {
    @Autowired
    private PublicSourceRepository repository;

    @PostMapping(value = "/public-source/create")
    public PublicSource postPublicSource(@RequestBody PublicSource publicSource) {

        PublicSource _publicSource = repository.save(new PublicSource(
                publicSource.getExerciseId(),
                publicSource.getFilename(),
                publicSource.getContent()

        ));

        System.out.format("Created public source %s for exercise #%s\n", publicSource.getFilename(), publicSource.getExerciseId());
        return _publicSource;
    }

    @GetMapping(value="/public-source/exercise/{exerciseId}")
    public List<PublicSource> getPublicSourcesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get public sources with exercise id " + exerciseId + "...");

        List<PublicSource> publicSources = new ArrayList<>(repository.findPublicSourcesByExerciseId(exerciseId));
        return publicSources;
    }
}
