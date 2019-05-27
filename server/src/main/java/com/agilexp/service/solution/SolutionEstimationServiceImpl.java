package com.agilexp.service.solution;

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
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class SolutionEstimationServiceImpl implements SolutionEstimationService {

    @Autowired
    SolutionRepository solutionRepository;

    @Autowired
    SolutionSourceRepository solutionSourceRepository;

    @Autowired
    SolutionTestRepository solutionTestRepository;

    @Autowired
    SolutionFileRepository solutionFileRepository;

    @Autowired
    SolutionEstimationRepository solutionEstimationRepository;


    @Override
    public SolutionEstimation markSolved(long solutionId) {
        Date date = new Date();
        SolutionEstimation estimation = new SolutionEstimation();
        estimation.setSolutionId(solutionId);
        estimation.setEstimation("Marked as solved");
        estimation.setSolved(true);
        estimation.setCreated(new Timestamp(date.getTime()));
        estimation.setValue(100);
        System.out.format("Marked solution %s as solved\n", solutionId);
        return solutionEstimationRepository.save(estimation);
    }

    @Override
    public SolutionEstimation markNotSolved(long solutionId) {
        Date date = new Date();
        SolutionEstimation estimation = new SolutionEstimation();
        estimation.setSolutionId(solutionId);
        estimation.setEstimation("Marked as not solved");
        estimation.setSolved(false);
        estimation.setCreated(new Timestamp(date.getTime()));
        estimation.setValue(0);
        System.out.format("Marked solution %s as solved\n", solutionId);
        return solutionEstimationRepository.save(estimation);
    }

    @Override
    public List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeSource(long exerciseId, int pageNumber, int pageSize) {
        List<Solution> solutions = getSolutions(exerciseId, pageNumber, pageSize);
        List<SolutionItems> solutionItems = new ArrayList<>();
        for (Solution solution : solutions) {
            List<SolutionSource> solutionSources = new ArrayList<>(solutionSourceRepository.findBySolutionId(solution.getId()));
            SolutionItems newSolutionItems = setSolutionItems(exerciseId, solution);
            newSolutionItems.setSolutionSources(solutionSources);
            solutionItems.add(newSolutionItems);
        }

        System.out.format("Found solution items\n");
        return solutionItems;
    }

    @Override
    public List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeTest(long exerciseId, int pageNumber, int pageSize) {
        List<Solution> solutions = getSolutions(exerciseId, pageNumber, pageSize);
        List<SolutionItems> solutionItems = new ArrayList<>();
        for (Solution solution : solutions) {
            SolutionItems newSolutionItems = setSolutionItems(exerciseId, solution);
            List<SolutionTest> solutionTests = new ArrayList<>(solutionTestRepository.findBySolutionId(solution.getId()));
            newSolutionItems.setSolutionTests(solutionTests);
            solutionItems.add(newSolutionItems);
        }

        System.out.format("Found solution items\n");
        return solutionItems;
    }

    @Override
    public List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeFile(long exerciseId, int pageNumber, int pageSize) {
        List<Solution> solutions = getSolutions(exerciseId, pageNumber, pageSize);
        List<SolutionItems> solutionItems = new ArrayList<>();
        for (Solution solution : solutions) {
            SolutionItems newSolutionItems = setSolutionItems(exerciseId, solution);
            List<SolutionFile> solutionFiles = new ArrayList<>(solutionFileRepository.findBySolutionId(solution.getId()));
            newSolutionItems.setSolutionFiles(solutionFiles);
            solutionItems.add(newSolutionItems);
        }

        System.out.format("Found solution items\n");
        return solutionItems;
    }

    @Override
    public SolutionEstimation getSolutionEstimationByExerciseId(long exerciseId) {
        Solution lastSolution = solutionRepository.findFirstByExerciseIdOrderByCreatedDesc(exerciseId);
        if (lastSolution == null) {
            return new SolutionEstimation();
        }
        SolutionEstimation estimation = solutionEstimationRepository.findFirstBySolutionId(lastSolution.getId());
        if (estimation == null) {
            return new SolutionEstimation();
        }
        System.out.format("Found last estimation of exercise %s\n", exerciseId);
        return estimation;
    }


    private List<Solution> getSolutions(long exerciseId, int pageNumber, int pageSize) {
        Pageable pageable = PageRequest.of(pageNumber, pageSize);
        return solutionRepository.findSolutionsByExerciseIdOrderByCreatedDesc(pageable, exerciseId);
    }


    private SolutionItems setSolutionItems(long exerciseId, Solution solution) {
        SolutionItems newSolutionItems = new SolutionItems();
        SolutionEstimation solutionEstimation = solutionEstimationRepository.findFirstBySolutionId(solution.getId());
        if (solutionEstimation == null) {
            return notEstimatedItems(exerciseId, solution);
        }
        newSolutionItems.setSolutionId(solution.getId());
        newSolutionItems.setExerciseId(exerciseId);
        newSolutionItems.setCreated(solutionEstimation.getCreated());
        newSolutionItems.setEstimation(solutionEstimation.getEstimation());
        newSolutionItems.setSolved(solutionEstimation.isSolved());
        return newSolutionItems;
    }

    private SolutionItems notEstimatedItems(long exerciseId, Solution solution) {
        SolutionItems solutionItems = new SolutionItems();
        solutionItems.setSolutionId(solution.getId());
        solutionItems.setExerciseId(exerciseId);
        solutionItems.setCreated(new Timestamp(new Date().getTime()));
        solutionItems.setEstimation("Was not estimated");
        solutionItems.setSolved(false);
        return solutionItems;
    }
}
