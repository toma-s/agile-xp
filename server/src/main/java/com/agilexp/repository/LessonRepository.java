package com.agilexp.repository;

import com.agilexp.dbmodel.Lesson;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface LessonRepository extends CrudRepository<Lesson, Long> {
    List<Lesson> findByCourseIdOrderByIndex(long courseId);
}
