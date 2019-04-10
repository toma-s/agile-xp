package com.agilexp.repository;

import com.agilexp.model.ExerciseSwitcher;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseSwitcherRepository extends CrudRepository<ExerciseSwitcher, Long> {
    List<ExerciseSwitcher> findExerciseSwitcherByExerciseId(long exerciseId);
}
