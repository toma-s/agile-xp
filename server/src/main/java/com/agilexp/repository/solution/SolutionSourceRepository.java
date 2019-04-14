package com.agilexp.repository.solution;

import com.agilexp.dbmodel.solution.SolutionSource;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionSourceRepository extends CrudRepository<SolutionSource, Long> {
    List<SolutionSource> findBySolutionId(long solutionId);
}