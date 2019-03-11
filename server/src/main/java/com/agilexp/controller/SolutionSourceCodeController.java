package com.agilexp.controller;

import com.agilexp.model.SolutionSourceCode;
import com.agilexp.repository.SolutionSourceCodeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionSourceCodeController {
    @Autowired
    SolutionSourceCodeRepository repository;

    @PostMapping(value = "/solutionSourceCodes/create")
    public SolutionSourceCode postSolutionSourceCode(@RequestBody SolutionSourceCode solutionSourceCode) {
        SolutionSourceCode _solutionSourceCode = repository.save(new SolutionSourceCode(
                solutionSourceCode.getSolutionId(),
                solutionSourceCode.getFileName(),
                solutionSourceCode.getCode()
        ));
        System.out.format("Created solution source code %s", solutionSourceCode);
        return _solutionSourceCode;
    }
}
