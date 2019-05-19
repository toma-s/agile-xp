package com.agilexp.controller.solution;

import com.agilexp.dbmodel.solution.SolutionFile;
import com.agilexp.service.solution.SolutionFileServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionFileController {

    @Autowired
    SolutionFileServiceImpl service;

    @PostMapping(value = "/solution-files/create")
    public ResponseEntity<SolutionFile> postSolutionFile(@RequestBody SolutionFile solutionFile) {
        SolutionFile newSolutionFile = service.create(solutionFile);
        return new ResponseEntity<>(newSolutionFile, HttpStatus.CREATED);
    }


}
