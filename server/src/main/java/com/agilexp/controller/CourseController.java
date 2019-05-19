package com.agilexp.controller;

import com.agilexp.dbmodel.Course;
import com.agilexp.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class CourseController {

    @Autowired
    private CourseService service;

    @PostMapping(value = "/courses/create")
    public ResponseEntity<Course> createCourse(@RequestBody Course course) {
        Course newCourse = service.create(course);
        return new ResponseEntity<>(newCourse, HttpStatus.CREATED);
    }

    @GetMapping(value="/courses/{id}")
    public ResponseEntity<Course> getCourseById(@PathVariable("id") long id) {
        Course course = service.getById(id);
        return new ResponseEntity<>(course, HttpStatus.OK);
    }

    @GetMapping("/courses")
    public ResponseEntity<List<Course>> getAllCourses() {
        List<Course> courses = service.getAll();
        return new ResponseEntity<>(courses, HttpStatus.OK);
    }

    @PutMapping("/courses/{id}")
    public ResponseEntity updateCourse(@PathVariable("id") long id, @RequestBody Course course) {
        if (service.update(id, course)) {
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/courses/{id}")
    public ResponseEntity<String> deleteCourse(@PathVariable("id") long id) {
        service.delete(id);
        return new ResponseEntity<>(
                String.format("Course with id %s has been deleted", id),
                HttpStatus.OK);
    }


}
