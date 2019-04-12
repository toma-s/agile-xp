package com.agilexp.repository;

import com.agilexp.dbmodel.Solution;
import org.springframework.data.repository.CrudRepository;

public interface SolutionRepository extends CrudRepository<Solution, Long> {
    Solution findById(long solutionId);
}
