package com.agilexp.repository;

import com.agilexp.model.ExerciseFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseConfigRepository extends CrudRepository<ExerciseFile, Long> {
    List<ExerciseFile> findByExerciseId(long exerciseId);
}
