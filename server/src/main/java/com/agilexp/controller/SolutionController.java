package com.agilexp.controller;

import com.agilexp.dbmodel.Solution;
import com.agilexp.repository.SolutionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.Date;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionController {
    @Autowired
    SolutionRepository repository;

    @PostMapping(value = "/solutions/create")
    public Solution postSolution(@RequestBody Solution solution) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());
        Solution _solution = repository.save(new Solution(
                solution.getExerciseId(),
                created
        ));
        System.out.format("Created solution %s\n", _solution);
        return _solution;
    }
}
