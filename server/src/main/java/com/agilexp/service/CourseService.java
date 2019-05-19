package com.agilexp.service;

import com.agilexp.dbmodel.Course;

import java.util.Collection;
import java.util.List;

public interface CourseService {

    public abstract Course createCourse(Course course);
    public abstract Course getCourseById(long id);
    public abstract List<Course> getCourses();
    public abstract boolean updateCourse(long id, Course course);
    public abstract void deleteCourse(long id);
    public abstract void deleteAllCourses();
}
