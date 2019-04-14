package com.agilexp.repository.solution;

import com.agilexp.dbmodel.solution.Solution;
import org.springframework.data.repository.CrudRepository;

public interface SolutionRepository extends CrudRepository<Solution, Long> {
    Solution findById(long solutionId);
}
