package com.agilexp.controller.estimation;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import com.agilexp.dbmodel.solution.Solution;
import com.agilexp.dbmodel.solution.SolutionFile;
import com.agilexp.dbmodel.solution.SolutionSource;
import com.agilexp.dbmodel.solution.SolutionTest;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.repository.solution.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionEstimationController {

    private final SolutionRepository solutionRepository;
    private final SolutionEstimationRepository solutionEstimationRepository;
    private final SolutionSourceRepository solutionSourceRepository;
    private final SolutionTestRepository solutionTestRepository;
    private final SolutionFileRepository solutionFileRepository;

    @Autowired
    public SolutionEstimationController(SolutionRepository repository, SolutionEstimationRepository solutionEstimationRepository, SolutionSourceRepository solutionSourceRepository, SolutionTestRepository solutionTestRepository, SolutionFileRepository solutionFileRepository) {
        this.solutionRepository = repository;
        this.solutionEstimationRepository = solutionEstimationRepository;
        this.solutionSourceRepository = solutionSourceRepository;
        this.solutionTestRepository = solutionTestRepository;
        this.solutionFileRepository = solutionFileRepository;
    }

    @GetMapping(value="/solution-estimation/exercise/{exerciseId}/source/{pageNumber}/{pageSize}")
    public List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeSource(
            @PathVariable("exerciseId") long exerciseId,
            @PathVariable("pageNumber") int pageNumber,
            @PathVariable("pageSize") int pageSize) {
        System.out.println("Get solution estimations with exercise id " + exerciseId + "...");

        Pageable pageable = PageRequest.of(pageNumber, pageSize);
        List<Solution> solutions = solutionRepository.findSolutionsByExerciseIdOrderByCreatedDesc(pageable, exerciseId);
        List<SolutionItems> solutionItems = new ArrayList<>();
        for (Solution solution : solutions) {
            SolutionItems newSolutionItems = new SolutionItems();
            List<SolutionSource> solutionSources = new ArrayList<>(solutionSourceRepository.findBySolutionId(solution.getId()));
            SolutionEstimation solutionEstimation = solutionEstimationRepository.findAllBySolutionId(solution.getId()).get(0);
            newSolutionItems.setSolutionId(solution.getId());
            newSolutionItems.setExerciseId(exerciseId);
            newSolutionItems.setSolutionSources(solutionSources);
            newSolutionItems.setCreated(solutionEstimation.getCreated());
            newSolutionItems.setEstimation(solutionEstimation.getEstimation());
            newSolutionItems.setSolved(solutionEstimation.isSolved());
            solutionItems.add(newSolutionItems);
        }

        System.out.format("Found solution items\n");
        return solutionItems;
    }

    @GetMapping(value="/solution-estimation/exercise/{exerciseId}/test/{pageNumber}/{pageSize}")
    public List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeTest(
            @PathVariable("exerciseId") long exerciseId,
            @PathVariable("pageNumber") int pageNumber,
            @PathVariable("pageSize") int pageSize) {
        System.out.println("Get solution estimations with exercise id " + exerciseId + "...");

        Pageable pageable = PageRequest.of(pageNumber, pageSize);
        List<Solution> solutions = solutionRepository.findSolutionsByExerciseIdOrderByCreatedDesc(pageable, exerciseId);
        List<SolutionItems> solutionItems = new ArrayList<>();
        for (Solution solution : solutions) {
            SolutionItems newSolutionItems = new SolutionItems();
            List<SolutionTest> solutionTests = new ArrayList<>(solutionTestRepository.findBySolutionId(solution.getId()));
            SolutionEstimation solutionEstimation = solutionEstimationRepository.findAllBySolutionId(solution.getId()).get(0);
            newSolutionItems.setSolutionId(solution.getId());
            newSolutionItems.setExerciseId(exerciseId);
            newSolutionItems.setSolutionTests(solutionTests);
            newSolutionItems.setCreated(solutionEstimation.getCreated());
            newSolutionItems.setEstimation(solutionEstimation.getEstimation());
            newSolutionItems.setSolved(solutionEstimation.isSolved());
            solutionItems.add(newSolutionItems);
        }

        System.out.format("Found solution items\n");
        return solutionItems;
    }

    @GetMapping(value="/solution-estimation/exercise/{exerciseId}/file/{pageNumber}/{pageSize}")
    public List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeFile(
            @PathVariable("exerciseId") long exerciseId,
            @PathVariable("pageNumber") int pageNumber,
            @PathVariable("pageSize") int pageSize) {
        System.out.println("Get solution estimations with exercise id " + exerciseId + "...");

        Pageable pageable = PageRequest.of(pageNumber, pageSize);
        List<Solution> solutions = solutionRepository.findSolutionsByExerciseIdOrderByCreatedDesc(pageable, exerciseId);
        List<SolutionItems> solutionItems = new ArrayList<>();
        for (Solution solution : solutions) {
            SolutionItems newSolutionItems = new SolutionItems();
            List<SolutionFile> solutionFiles = new ArrayList<>(solutionFileRepository.findBySolutionId(solution.getId()));
            SolutionEstimation solutionEstimation = solutionEstimationRepository.findAllBySolutionId(solution.getId()).get(0);
            newSolutionItems.setSolutionId(solution.getId());
            newSolutionItems.setExerciseId(exerciseId);
            newSolutionItems.setSolutionFiles(solutionFiles);
            newSolutionItems.setCreated(solutionEstimation.getCreated());
            newSolutionItems.setEstimation(solutionEstimation.getEstimation());
            newSolutionItems.setSolved(solutionEstimation.isSolved());
            solutionItems.add(newSolutionItems);
        }

        System.out.format("Found solution items\n");
        return solutionItems;
    }
}
