package com.agilexp.controller;

import com.agilexp.model.SolutionFile;
import com.agilexp.repository.SolutionFileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionFileController {
    @Autowired
    SolutionFileRepository repository;

    @PostMapping(value = "/solution-files/create")
    public SolutionFile postSolutionFile(@RequestBody SolutionFile solutionFile) {
        SolutionFile _solutionFile = repository.save(new SolutionFile(
                solutionFile.getSolutionId(),
                solutionFile.getFileName(),
                solutionFile.getContent()
        ));
        System.out.format("Created solution file %s\n", _solutionFile);
        return _solutionFile;
    }
}
