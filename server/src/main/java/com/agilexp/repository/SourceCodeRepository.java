package com.agilexp.repository;

import com.agilexp.model.SourceCode;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SourceCodeRepository extends CrudRepository<SourceCode, Long> {
    List<SourceCode> findByExerciseId(long exerciseId);
}
