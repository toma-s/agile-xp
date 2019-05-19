package com.agilexp.controller.solution;

import com.agilexp.dbmodel.solution.SolutionSource;
import com.agilexp.service.solution.SolutionSourceServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionSourceController {

    @Autowired
    SolutionSourceServiceImpl service;

    @PostMapping(value = "/solution-sources/create")
    public ResponseEntity<SolutionSource> postSolutionSource(@RequestBody SolutionSource solutionSource) {
        SolutionSource newSolutionSource = service.create(solutionSource);
        return new ResponseEntity<>(newSolutionSource, HttpStatus.CREATED);
    }

}
