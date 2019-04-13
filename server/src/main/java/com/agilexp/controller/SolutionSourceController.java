package com.agilexp.controller;

import com.agilexp.dbmodel.SolutionSource;
import com.agilexp.repository.SolutionSourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionSourceController {
    @Autowired
    SolutionSourceRepository repository;

    @PostMapping(value = "/solution-sources/create")
    public SolutionSource postSolutionSource(@RequestBody SolutionSource solutionSource) {
        SolutionSource _solutionSource = repository.save(new SolutionSource(
                solutionSource.getSolutionId(),
                solutionSource.getFilename(),
                solutionSource.getContent()
        ));
        System.out.format("Created solution source %s\n", solutionSource);
        return _solutionSource;
    }
}
