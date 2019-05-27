package com.agilexp.service;

import com.agilexp.dbmodel.Course;
import com.agilexp.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.*;

@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    private CourseRepository repository;

    @Override
    public Course create(Course course) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());
        Course newCourse = repository.save(new Course(course.getName(), created, course.getDescription()));
        System.out.format("Created course %s%n", newCourse.getName());
        return newCourse;
    }

    @Override
    public Course getById(long id) {
        Optional<Course> optional = repository.findById(id);
        System.out.format("Got course with id %s%n", id);
        return optional.orElse(null);
    }

    @Override
    public List<Course> getAll() {
        List<Course> courses = new ArrayList<>();
        repository.findAll().forEach(courses::add);
        System.out.println("Got all courses");
        return courses;
    }

    @Override
    public boolean update(long id, Course course) {
        Optional<Course> optional = repository.findById(id);
        if (!optional.isPresent()) {
            System.out.format("Failed to update course with id %s%n", id);
            return false;
        }
        Course updatedCourse = optional.get();
        updatedCourse.setName(course.getName());
        updatedCourse.setCreated(course.getCreated());
        updatedCourse.setDescription(course.getDescription());
        repository.save(updatedCourse);
        System.out.format("Updates course with id %s%n", id);
        return true;
    }

    @Override
    public void delete(long id) {
        repository.deleteById(id);
        System.out.format("Deleted course with id %s%n", id);
    }

}
