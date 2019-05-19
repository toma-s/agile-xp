package com.agilexp.service.solution;

import com.agilexp.model.solution.SolutionItems;

import java.util.List;

public interface SolutionEstimationService {

    public abstract List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeSource(long exerciseId, int pageNumber, int pageSize);

    public abstract List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeTest(long exerciseId, int pageNumber, int pageSize);

    public abstract List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeFile(long exerciseId, int pageNumber, int pageSize);
}
