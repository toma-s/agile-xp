package com.agilexp.controller;

import com.agilexp.model.SolutionTest;
import com.agilexp.repository.SolutionTestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionTestController {
    @Autowired
    SolutionTestRepository repository;

    @PostMapping(value = "/solutionTests/create")
    public SolutionTest postSolutionTest(@RequestBody SolutionTest solutionTest) {
        SolutionTest _solutionTest = repository.save(new SolutionTest(
                solutionTest.getSolutionId(),
                solutionTest.getFileName(),
                solutionTest.getCode()
        ));
        System.out.format("Created solution test %s", solutionTest);
        return _solutionTest;
    }
}
