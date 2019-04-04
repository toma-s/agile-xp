package com.agilexp.repository;

import com.agilexp.model.ExerciseSource;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseSourceRepository extends CrudRepository<ExerciseSource, Long> {
    List<ExerciseSource> findExerciseSourcesByExerciseId(long exerciseId);
}
