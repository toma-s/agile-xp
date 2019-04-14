package com.agilexp.repository.solution;

import com.agilexp.dbmodel.solution.Solution;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionRepository extends CrudRepository<Solution, Long> {
    Solution findById(long solutionId);
    List<Solution> findSolutionByExerciseIdOrderByCreatedDesc(long exerciseId);
}
