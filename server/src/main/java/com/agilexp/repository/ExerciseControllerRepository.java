package com.agilexp.repository;

import com.agilexp.model.ExerciseController;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseControllerRepository extends CrudRepository<ExerciseController, Long> {
    List<ExerciseController> findExerciseControllerByExerciseId(long exerciseId);
}
