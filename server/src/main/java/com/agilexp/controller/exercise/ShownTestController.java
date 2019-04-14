package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.ShownTest;
import com.agilexp.repository.exercise.ShownTestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class ShownTestController {
    @Autowired
    private ShownTestRepository repository;

    @PostMapping(value = "/shown-test/create")
    public ShownTest postShownTest(@RequestBody ShownTest shownTest) {

        ShownTest _sourceCode = repository.save(new ShownTest(
                shownTest.getExerciseId(),
                shownTest.getFilename(),
                shownTest.getContent()

        ));

        System.out.format("Created shown test %s for exercise #%s\n", shownTest.getFilename(), shownTest.getExerciseId());
        return _sourceCode;
    }
}
