package com.agilexp.repository.solution;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionEstimationRepository extends CrudRepository<SolutionEstimation, Long> {
    List<SolutionEstimation> findAllBySolutionId(long solutionId);
}
