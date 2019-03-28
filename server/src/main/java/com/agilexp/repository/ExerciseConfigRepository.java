package com.agilexp.repository;

import com.agilexp.model.ExerciseConfig;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseConfigRepository extends CrudRepository<ExerciseConfig, Long> {
    List<ExerciseConfig> findExerciseConfigBySolutionId(long solutionId);
}
