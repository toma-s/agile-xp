package com.agilexp.controller.solution;

import com.agilexp.dbmodel.solution.SolutionTest;
import com.agilexp.service.solution.SolutionTestServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionTestController {

    @Autowired
    SolutionTestServiceImpl service;

    @PostMapping(value = "/solution-tests/create")
    public ResponseEntity<SolutionTest> postSolutionTest(@RequestBody SolutionTest solutionTest) {
        SolutionTest newSolutionTest = service.create(solutionTest);
        return new ResponseEntity<>(newSolutionTest, HttpStatus.CREATED);
    }

}
