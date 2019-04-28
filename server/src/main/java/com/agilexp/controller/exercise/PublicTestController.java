package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PublicTest;
import com.agilexp.repository.exercise.PublicTestRepository;
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
public class PublicTestController {
    @Autowired
    private PublicTestRepository repository;

    @PostMapping(value = "/public-tests/create")
    public PublicTest postPublicTest(@RequestBody PublicTest publicTest) {

        PublicTest _publicCode = repository.save(new PublicTest(
                publicTest.getExerciseId(),
                publicTest.getFilename(),
                publicTest.getContent()

        ));

        System.out.format("Created PublicTest %s for exercise #%s\n", publicTest.getFilename(), publicTest.getExerciseId());
        return _publicCode;
    }

    @GetMapping(value="/public-tests/exercise/{exerciseId}")
    public List<PublicTest> getPublicTestsByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get public tests with exercise id " + exerciseId + "...");

        List<PublicTest> publicTests = new ArrayList<>(repository.findPublicTestsByExerciseId(exerciseId));
        return publicTests;
    }

    @PutMapping("/public-tests/{id}")
    public ResponseEntity<PublicTest> updatePublicTest(@PathVariable("id") long id, @RequestBody PublicTest publicTest) {
        System.out.println("Update PublicTest with ID = " + id + "...");

        Optional<PublicTest> publicTestData = repository.findById(id);

        if (publicTestData.isPresent()) {
            PublicTest _publicTest = publicTestData.get();
            System.out.println(_publicTest);
            _publicTest.setFilename(publicTest.getFilename());
            _publicTest.setExerciseId(publicTest.getExerciseId());
            _publicTest.setContent(publicTest.getContent());
            PublicTest newPublicTest = repository.save(_publicTest);
            System.out.println(newPublicTest);
            return new ResponseEntity<>(newPublicTest, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/public-tests/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Delete PublicTest with exercise ID = " + exerciseId + "...");

        List<PublicTest> publicTests = repository.findPublicTestsByExerciseId(exerciseId);
        publicTests.forEach(publicTest -> {
            repository.delete(publicTest);
        });


        return new ResponseEntity<>("Public tests have been deleted!", HttpStatus.OK);
    }
}
