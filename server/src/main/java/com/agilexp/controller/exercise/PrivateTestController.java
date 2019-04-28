package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.PrivateTest;
import com.agilexp.repository.exercise.PrivateTestRepository;
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
public class PrivateTestController {
    @Autowired
    PrivateTestRepository repository;

    @PostMapping(value = "/private-tests/create")
    public PrivateTest postPrivateTest(@RequestBody PrivateTest exerciseTest) {
        PrivateTest _exerciseTest = repository.save(new PrivateTest(
                exerciseTest.getExerciseId(),
                exerciseTest.getFilename(),
                exerciseTest.getContent()));

        System.out.format("Created PrivateTest %s for exercise #%s\n", exerciseTest.getFilename(), exerciseTest.getExerciseId());
        return _exerciseTest;
    }

    @GetMapping(value="/private-tests/exercise/{exerciseId}")
    public List<PrivateTest> getPrivateTestsByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get exercise tests with exercise id " + exerciseId + "...");

        List<PrivateTest> exerciseTests = new ArrayList<>(repository.findPrivateTestsByExerciseId(exerciseId));
        return exerciseTests;
    }

    @PutMapping("/private-tests/{id}")
    public ResponseEntity<PrivateTest> updatePrivateTest(@PathVariable("id") long id, @RequestBody PrivateTest privateTest) {
        System.out.println("Update PublicTest with ID = " + id + "...");

        Optional<PrivateTest> privateTestData = repository.findById(id);

        if (privateTestData.isPresent()) {
            PrivateTest _privateTest = privateTestData.get();
            _privateTest.setFilename(privateTest.getFilename());
            _privateTest.setExerciseId(privateTest.getExerciseId());
            _privateTest.setContent(privateTest.getContent());
            return new ResponseEntity<>(repository.save(_privateTest), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/private-tests/{exerciseId}")
    public ResponseEntity<String> deleteByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Delete PrivateTest with exercise ID = " + exerciseId + "...");

        List<PrivateTest> privateTests = repository.findPrivateTestsByExerciseId(exerciseId);
        privateTests.forEach(privateTest -> {
            repository.delete(privateTest);
        });


        return new ResponseEntity<>("Private tests have been deleted!", HttpStatus.OK);
    }
}
