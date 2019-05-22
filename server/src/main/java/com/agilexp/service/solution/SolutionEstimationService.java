package com.agilexp.service.solution;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import com.agilexp.model.solution.SolutionItems;

import java.util.List;

public interface SolutionEstimationService {

    public abstract SolutionEstimation markSolved(long solutionId);

    public abstract SolutionEstimation markNotSolved(long solutionId);

    public abstract List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeSource(long exerciseId, int pageNumber, int pageSize);

    public abstract List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeTest(long exerciseId, int pageNumber, int pageSize);

    public abstract List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeFile(long exerciseId, int pageNumber, int pageSize);

    SolutionEstimation getSolutionEstimationByExerciseId(long exerciseId);

}
