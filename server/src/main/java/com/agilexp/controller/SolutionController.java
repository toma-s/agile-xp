package com.agilexp.controller;

import com.agilexp.model.Solution;
import com.agilexp.repository.SolutionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionController {
    @Autowired
    SolutionRepository repository;

    @PostMapping(value = "/solutions/create")
    public Solution postCourse(@RequestBody Solution solution) {
        Solution _solution = repository.save(new Solution());
        System.out.format("Created solution %s", solution);
        return _solution;
    }
}
