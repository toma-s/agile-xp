package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PublicFile;
import com.agilexp.repository.exercise.PublicFileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class PublicFileController {
    @Autowired
    private PublicFileRepository repository;

    @PostMapping(value = "/public-file/create")
    public PublicFile postPublicFile(@RequestBody PublicFile publicFile) {

        PublicFile _publicFile = repository.save(new PublicFile(
                publicFile.getExerciseId(),
                publicFile.getFilename(),
                publicFile.getContent()

        ));

        System.out.format("Created public file %s for exercise #%s\n", publicFile.getFilename(), publicFile.getExerciseId());
        return _publicFile;
    }
    @GetMapping(value="/public-file/exercise/{exerciseId}")
    public List<PublicFile> getPublicFilesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get public files with exercise id " + exerciseId + "...");

        List<PublicFile> publicFiles = new ArrayList<>(repository.findPublicFilesByExerciseId(exerciseId));
        return publicFiles;
    }

}