package com.agilexp.controller.solution;

import com.agilexp.dbmodel.solution.Solution;
import com.agilexp.dbmodel.solution.SolutionSource;
import com.agilexp.repository.solution.SolutionRepository;
import com.agilexp.repository.solution.SolutionSourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionSourceController {
    @Autowired
    SolutionSourceRepository repository;

    @Autowired
    SolutionRepository solutionRepository;

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

    @GetMapping(value="/solution-sources/exercise/{exerciseId}")
    public List<SolutionSource> getSolutionSourceByExerciseId(@PathVariable("exerciseId") long exerciseId) {
        System.out.println("Get solution sources with exercise id " + exerciseId + "...");

        List<Solution> solutions = solutionRepository.findSolutionByExerciseIdOrderByCreatedDesc(exerciseId);
        List<SolutionSource> solutionSources = new ArrayList<>();
        solutions.forEach(solution -> {
            solutionSources.addAll(repository.findBySolutionId(solution.getId()));
        });

        System.out.format("Found solution sources %s\n", solutionSources);
        return solutionSources;
    }
}
