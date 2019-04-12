package com.agilexp.repository;

import com.agilexp.dbmodel.ExerciseType;
import org.springframework.data.repository.CrudRepository;

public interface ExerciseTypeRepository extends CrudRepository<ExerciseType, Long> {
    ExerciseType findByValue(String type);
}
