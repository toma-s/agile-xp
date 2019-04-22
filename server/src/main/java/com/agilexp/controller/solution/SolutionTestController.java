package com.agilexp.controller.solution;

import com.agilexp.dbmodel.solution.Solution;
import com.agilexp.dbmodel.solution.SolutionTest;
import com.agilexp.repository.solution.SolutionRepository;
import com.agilexp.repository.solution.SolutionTestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionTestController {
    @Autowired
    SolutionTestRepository repository;

    @Autowired
    SolutionRepository solutionRepository;

    @PostMapping(value = "/solution-tests/create")
    public SolutionTest postSolutionTest(@RequestBody SolutionTest solutionTest) {
        SolutionTest _solutionTest = repository.save(new SolutionTest(
                solutionTest.getSolutionId(),
                solutionTest.getFilename(),
                solutionTest.getContent(),
                solutionTest.getSolutionEstimationId()
        ));
        System.out.format("Created solution test %s\n", solutionTest);
        return _solutionTest;
    }

}
