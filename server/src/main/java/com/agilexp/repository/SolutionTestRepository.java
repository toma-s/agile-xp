package com.agilexp.repository;

import com.agilexp.dbmodel.SolutionTest;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionTestRepository extends CrudRepository<SolutionTest, Long> {
    List<SolutionTest> findBySolutionId(long solutionId);
}
