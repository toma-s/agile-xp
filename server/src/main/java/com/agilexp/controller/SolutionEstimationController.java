package com.agilexp.controller;

import com.agilexp.compiler.CompilerTester;
import com.agilexp.model.Solution;
import com.agilexp.model.SolutionEstimation;
import com.agilexp.model.SolutionSource;
import com.agilexp.model.SolutionTest;
import com.agilexp.repository.SolutionEstimationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionEstimationController {
    @Autowired
    SolutionEstimationRepository repository;

    @PostMapping(value = "/solution-estimations/create")
    public SolutionEstimation postSolutionEstimation(@RequestBody SolutionSource solutionSource,
                                                     @RequestBody SolutionTest solutionTest) {
        SolutionEstimation solutionEstimation = new SolutionEstimation();
        solutionEstimation.setSolutionId(solutionSource.getSolutionId());
        solutionEstimation.setEstimation(getEstimation(solutionSource, solutionTest));
        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s", solutionEstimation);
        return _solutionEstimation;
    }

    private String getEstimation(SolutionSource solutionSource, SolutionTest solutionTest) {
        CompilerTester compilerTester = new CompilerTester();
    }
}
