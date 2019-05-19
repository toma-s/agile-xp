package com.agilexp.controller.solution;

import com.agilexp.dbmodel.solution.Solution;
import com.agilexp.service.solution.SolutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionController {

    @Autowired
    SolutionService service;

    @PostMapping(value = "/solutions/create")
    public ResponseEntity<Solution> postSolution(@RequestBody Solution solution) {
        Solution newSolution = service.create(solution);
        return new ResponseEntity<>(newSolution, HttpStatus.CREATED);
    }
}
