package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.ShownSource;
import com.agilexp.repository.exercise.ShownSourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class ShownSourceController {
    @Autowired
    private ShownSourceRepository repository;

    @PostMapping(value = "/shown-source/create")
    public ShownSource postShownSource(@RequestBody ShownSource shownSource) {

        ShownSource _shownSource = repository.save(new ShownSource(
                shownSource.getExerciseId(),
                shownSource.getFilename(),
                shownSource.getContent()

        ));

        System.out.format("Created shown source %s for exercise #%s\n", shownSource.getFilename(), shownSource.getExerciseId());
        return _shownSource;
    }
}
