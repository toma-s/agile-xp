package com.agilexp.controller;

import com.agilexp.model.SolutionConfig;
import com.agilexp.repository.SolutionConfigRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionConfigController {
    @Autowired
    SolutionConfigRepository repository;

    @PostMapping(value = "/solution-configs/create")
    public SolutionConfig postSolutionConfig(@RequestBody SolutionConfig solutionConfig) {
        SolutionConfig _solutionConfig = repository.save(new SolutionConfig(
                solutionConfig.getSolutionId(),
                solutionConfig.getFileName(),
                solutionConfig.getText()
        ));
        System.out.format("Created solution config %s\n", _solutionConfig);
        return _solutionConfig;
    }
}
