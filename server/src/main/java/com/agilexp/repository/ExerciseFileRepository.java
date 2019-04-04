package com.agilexp.repository;

import com.agilexp.model.ExerciseFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseFileRepository extends CrudRepository<ExerciseFile, Long> {
    List<ExerciseFile> findExerciseFilesByExerciseId(long exerciseId);
}
