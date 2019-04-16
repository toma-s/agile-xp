package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.ExerciseTest;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseTestRepository extends CrudRepository<ExerciseTest, Long> {
    List<ExerciseTest> findExerciseTestsByExerciseId(long exerciseId);
}
