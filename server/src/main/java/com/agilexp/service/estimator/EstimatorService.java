package com.agilexp.service.estimator;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import com.agilexp.model.solution.SolutionItems;

public interface EstimatorService {

    public abstract SolutionEstimation getEstimation(SolutionItems solutionItems);
}
