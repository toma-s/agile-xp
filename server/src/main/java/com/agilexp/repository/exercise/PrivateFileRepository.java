package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.PrivateFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PrivateFileRepository extends CrudRepository<PrivateFile, Long> {
    List<PrivateFile> findExerciseFilesByExerciseId(long exerciseId);
}
