package com.agilexp.controller;

import com.agilexp.dbmodel.Course;
import com.agilexp.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class CourseController {
    @Autowired
    CourseRepository repository;

    @GetMapping(value="/courses/{id}")
    public Course getCourseById(@PathVariable("id") long id) {
        System.out.println("Get course with id " + id + "...");

        Optional<Course> taskDataOptional = repository.findById(id);
        return taskDataOptional.orElse(null);
    }

    @GetMapping("/courses")
    public List<Course> getAllCourses() {
        System.out.println("Get all courses...");

        List<Course> courses = new ArrayList<>();
        repository.findAll().forEach(courses::add);

        return courses;
    }

    @PostMapping(value = "/courses/create")
    public Course postCourse(@RequestBody Course course) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());
        Course _course = repository.save(new Course(course.getName(), created, course.getDescription()));
        System.out.format("Created course %s at %s", course.getName(), created);
        return _course;
    }

    @DeleteMapping("/courses/{id}")
    public ResponseEntity<String> deleteCourse(@PathVariable("id") long id) {
        System.out.println("Delete Course with ID = " + id + "...");

        repository.deleteById(id);

        return new ResponseEntity<>("Course has been deleted!", HttpStatus.OK);
    }

    @DeleteMapping("/courses/delete")
    public ResponseEntity<String> deleteAllCourses() {
        System.out.println("Delete All Courses...");

        repository.deleteAll();

        return new ResponseEntity<>("All Courses have been deleted!", HttpStatus.OK);
    }

}
