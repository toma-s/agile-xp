package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.PrivateTest;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PrivateTestRepository extends CrudRepository<PrivateTest, Long> {
    List<PrivateTest> findPrivateTestsByExerciseId(long exerciseId);
}
