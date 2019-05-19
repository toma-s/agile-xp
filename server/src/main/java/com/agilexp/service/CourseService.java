package com.agilexp.service;

import com.agilexp.dbmodel.Course;

import java.util.List;

public interface CourseService {

    public abstract Course create(Course course);
    public abstract Course getById(long id);
    public abstract List<Course> getAll();
    public abstract boolean update(long id, Course course);
    public abstract void delete(long id);
}
