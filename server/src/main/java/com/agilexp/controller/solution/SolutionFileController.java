package com.agilexp.controller.solution;

import com.agilexp.dbmodel.solution.Solution;
import com.agilexp.dbmodel.solution.SolutionFile;
import com.agilexp.repository.solution.SolutionFileRepository;
import com.agilexp.repository.solution.SolutionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionFileController {
    @Autowired
    SolutionFileRepository repository;

    @Autowired
    SolutionRepository solutionRepository;

    @PostMapping(value = "/solution-files/create")
    public SolutionFile postSolutionFile(@RequestBody SolutionFile solutionFile) {
        SolutionFile _solutionFile = repository.save(new SolutionFile(
                solutionFile.getSolutionId(),
                solutionFile.getFilename(),
                solutionFile.getContent()
        ));
        System.out.format("Created solution file %s\n", _solutionFile);
        return _solutionFile;
    }

    @GetMapping(value="/solution-files/exercise/{exerciseId}")
    public List<SolutionFile> getSolutionFilesByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get solution files with exercise id " + exerciseId + "...");

        List<Solution> solutions = solutionRepository.findSolutionByExerciseIdOrderByCreatedDesc(exerciseId);

        List<SolutionFile> solutionTests = new ArrayList<>(repository.findBySolutionId(solutions.get(0).getId()));

        System.out.format("Found solution files %s\n", solutionTests);
        return solutionTests;
    }
}
