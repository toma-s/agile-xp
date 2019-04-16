package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.ExerciseSource;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseSourceRepository extends CrudRepository<ExerciseSource, Long> {
    List<ExerciseSource> findExerciseSourcesByExerciseId(long exerciseId);
}
