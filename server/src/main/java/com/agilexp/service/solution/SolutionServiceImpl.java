package com.agilexp.service.solution;

import com.agilexp.dbmodel.solution.Solution;
import com.agilexp.repository.solution.SolutionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Date;

@Service
public class SolutionServiceImpl implements SolutionService {

    @Autowired
    private SolutionRepository repository;

    @Override
    public Solution create(Solution solution) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());
        Solution newSolution = repository.save(new Solution(
                solution.getExerciseId(),
                created
        ));
        System.out.format("Created solution %s of exercise %s%n", newSolution.getId(), newSolution.getExerciseId());
        return newSolution;
    }
}
