package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.PublicSource;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PublicSourceRepository extends CrudRepository<PublicSource, Long> {
    List<PublicSource> findPublicSourcesByExerciseId(long exerciseId);
}
