package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.ExerciseType;
import org.springframework.data.repository.CrudRepository;

public interface ExerciseTypeRepository extends CrudRepository<ExerciseType, Long> {
    ExerciseType findByValue(String type);
}
