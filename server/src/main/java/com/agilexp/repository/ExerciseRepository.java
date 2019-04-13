package com.agilexp.repository;

import com.agilexp.dbmodel.Exercise;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseRepository extends CrudRepository<Exercise, Long> {
    List<Exercise> findByLessonId(long lessonId);
}
