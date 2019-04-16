package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.Exercise;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseRepository extends CrudRepository<Exercise, Long> {
    List<Exercise> findByLessonId(long lessonId);
}
