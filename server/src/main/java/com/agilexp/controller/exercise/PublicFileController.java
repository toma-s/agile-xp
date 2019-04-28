package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PublicFile;
import com.agilexp.repository.exercise.PublicFileRepository;
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
public class PublicFileController {
    @Autowired
    private PublicFileRepository repository;

    @PostMapping(value = "/public-files/create")
    public PublicFile postPublicFile(@RequestBody PublicFile publicFile) {

        PublicFile _publicFile = repository.save(new PublicFile(
                publicFile.getExerciseId(),
                publicFile.getFilename(),
                publicFile.getContent()

        ));

        System.out.format("Created PublicFile %s for exercise #%s\n", publicFile.getFilename(), publicFile.getExerciseId());
        return _publicFile;
    }

    @GetMapping(value="/public-files/exercise/{exerciseId}")
    public List<PublicFile> getPublicFilesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get public files with exercise id " + exerciseId + "...");

        List<PublicFile> publicFiles = new ArrayList<>(repository.findPublicFilesByExerciseId(exerciseId));
        return publicFiles;
    }

    @PutMapping("/public-files/{id}")
    public ResponseEntity<PublicFile> updatePublicFile(@PathVariable("id") long id, @RequestBody PublicFile publicFile) {
        System.out.println("Update PublicFile with ID = " + id + "...");

        Optional<PublicFile> publicFileData = repository.findById(id);

        if (publicFileData.isPresent()) {
            PublicFile _publicFile = publicFileData.get();
            _publicFile.setFilename(publicFile.getFilename());
            _publicFile.setExerciseId(publicFile.getExerciseId());
            _publicFile.setContent(publicFile.getContent());
            return new ResponseEntity<>(repository.save(_publicFile), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/public-files/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Delete PublicFile with exercise ID = " + exerciseId + "...");

        List<PublicFile> publicFiles = repository.findPublicFilesByExerciseId(exerciseId);
        publicFiles.forEach(publicFile -> {
            repository.delete(publicFile);
        });


        return new ResponseEntity<>("Public files have been deleted!", HttpStatus.OK);
    }

}