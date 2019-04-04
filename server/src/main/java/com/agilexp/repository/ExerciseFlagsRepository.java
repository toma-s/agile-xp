package com.agilexp.repository;

import com.agilexp.model.ExerciseFlags;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseFlagsRepository extends CrudRepository<ExerciseFlags, Long> {
    List<ExerciseFlags> findExerciseFlagsByExerciseId(long exerciseId);
}
