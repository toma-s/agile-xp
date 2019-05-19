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
    CourseRepository repository;

    @Override
    public Course createCourse(Course course) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());
        Course _course = repository.save(new Course(course.getName(), created, course.getDescription()));
        System.out.format("Created course %s at %s", course.getName(), created);
        return _course;
    }

    @Override
    public Course getCourseById(long id) {
        System.out.println("Get course with id " + id + "...");
        Optional<Course> taskDataOptional = repository.findById(id);
        return taskDataOptional.orElse(null);
    }

    @Override
    public List<Course> getCourses() {
        System.out.println("Get all courses...");
        List<Course> courses = new ArrayList<>();
        repository.findAll().forEach(courses::add);
        return courses;
    }

    @Override
    public boolean updateCourse(long id, Course course) {
        System.out.println("Update Course with ID = " + id + "...");
        Optional<Course> courseData = repository.findById(id);
        if (courseData.isPresent()) {
            Course _course = courseData.get();
            _course.setName(course.getName());
            _course.setCreated(course.getCreated());
            _course.setDescription(course.getDescription());
            repository.save(_course);
            return true;
        }
        return false;
    }

    @Override
    public void deleteCourse(long id) {
        System.out.println("Delete Course with ID = " + id + "...");
        repository.deleteById(id);
    }

    @Override
    public void deleteAllCourses() {
        System.out.println("Delete All Courses...");
        repository.deleteAll();
    }

}
