package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.PublicFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PublicFileRepository extends CrudRepository<PublicFile, Long> {
    List<PublicFile> findPublicFilesByExerciseId(long exerciseId);
}
