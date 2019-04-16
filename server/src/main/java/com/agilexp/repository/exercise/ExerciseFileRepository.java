package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.ExerciseFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseFileRepository extends CrudRepository<ExerciseFile, Long> {
    List<ExerciseFile> findExerciseFilesByExerciseId(long exerciseId);
}
