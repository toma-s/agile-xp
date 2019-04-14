package com.agilexp.repository.solution;

import com.agilexp.dbmodel.solution.SolutionTest;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionTestRepository extends CrudRepository<SolutionTest, Long> {
    List<SolutionTest> findBySolutionId(long solutionId);
}
