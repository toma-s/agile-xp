package com.agilexp.controller;

import com.agilexp.model.Course;
import com.agilexp.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class CourseController {
    @Autowired
    CourseRepository repository;

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
        Course _message = repository.save(new Course(course.getName(), created));
        System.out.format("Created course %s at %s", course.getName(), created);
        return _message;
    }

    @DeleteMapping("/courses/{id}")
    public ResponseEntity<String> deleteCourse(@PathVariable("id") long id) {
        System.out.println("Delete Course with ID = " + id + "...");

        repository.deleteById(id);

        return new ResponseEntity<>("Course has been deleted!", HttpStatus.OK);
    }

    @DeleteMapping("/courses/delete")
    public ResponseEntity<String> deleteAllMessages() {
        System.out.println("Delete All Courses...");

        repository.deleteAll();

        return new ResponseEntity<>("All Courses have been deleted!", HttpStatus.OK);
    }

    // TODO: 24-Feb-19 findByAuthor
    // TODO: 24-Feb-19 updateCourse

}
