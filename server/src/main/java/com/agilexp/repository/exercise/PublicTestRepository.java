package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.PublicTest;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PublicTestRepository extends CrudRepository<PublicTest, Long> {
    List<PublicTest> findPublicTestsByExerciseId(long exerciseId);
}
