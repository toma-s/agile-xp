package com.agilexp.repository.solution;

import com.agilexp.dbmodel.solution.Solution;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionRepository extends CrudRepository<Solution, Long> {
    List<Solution> findSolutionsByExerciseIdOrderByCreatedDesc(Pageable pageable, long exerciseId);
}
