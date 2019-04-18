package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.PrivateSource;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PrivateSourceRepository extends CrudRepository<PrivateSource, Long> {
    List<PrivateSource> findPrivateSourcesByExerciseId(long exerciseId);
}
