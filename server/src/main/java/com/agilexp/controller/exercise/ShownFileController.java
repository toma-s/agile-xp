package com.agilexp.controller.exercise;

import com.agilexp.dbmodel.exercise.ShownFile;
import com.agilexp.repository.exercise.ShownFileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class ShownFileController {
    @Autowired
    private ShownFileRepository repository;

    @PostMapping(value = "/shown-file/create")
    public ShownFile postShownFile(@RequestBody ShownFile shownFile) {

        ShownFile _shownFile = repository.save(new ShownFile(
                shownFile.getExerciseId(),
                shownFile.getFilename(),
                shownFile.getContent()

        ));

        System.out.format("Created shown file %s for exercise #%s\n", shownFile.getFilename(), shownFile.getExerciseId());
        return _shownFile;
    }
}