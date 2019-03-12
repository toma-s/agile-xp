package com.agilexp.controller;

import com.agilexp.model.SolutionSource;
import com.agilexp.repository.SolutionSourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionSourceController {
    @Autowired
    SolutionSourceRepository repository;

    @PostMapping(value = "/solutionSourceCodes/create")
    public SolutionSource postSolutionSourceCode(@RequestBody SolutionSource solutionSourceCode) {
        SolutionSource _solutionSourceCode = repository.save(new SolutionSource(
                solutionSourceCode.getSolutionId(),
                solutionSourceCode.getFileName(),
                solutionSourceCode.getCode()
        ));
        System.out.format("Created solution source code %s", solutionSourceCode);
        return _solutionSourceCode;
    }
}
