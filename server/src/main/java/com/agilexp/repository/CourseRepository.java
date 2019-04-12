package com.agilexp.repository;

import com.agilexp.dbmodel.Course;
import org.springframework.data.repository.CrudRepository;

public interface CourseRepository extends CrudRepository<Course, Long> {
}
