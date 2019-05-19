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
    CourseService courseService;

    @PostMapping(value = "/courses/create")
    public ResponseEntity<Course> createCourse(@RequestBody Course course) {
        Course newCourse = courseService.create(course);
        return new ResponseEntity<>(newCourse, HttpStatus.CREATED);
    }

    @GetMapping(value="/courses/{id}")
    public ResponseEntity<Course> getCourseById(@PathVariable("id") long id) {
        Course course = courseService.getById(id);
        return new ResponseEntity<>(course, HttpStatus.OK);
    }

    @GetMapping("/courses")
    public ResponseEntity<List<Course>> getAllCourses() {
        List<Course> courses = courseService.getAll();
        return new ResponseEntity<>(courses, HttpStatus.OK);
    }

    @PutMapping("/courses/{id}")
    public ResponseEntity<Course> updateCourse(@PathVariable("id") long id, @RequestBody Course course) {
        if (courseService.update(id, course)) {
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/courses/{id}")
    public ResponseEntity<String> deleteCourse(@PathVariable("id") long id) {
        courseService.delete(id);
        return new ResponseEntity<>(
                String.format("Course with id %s has been deleted", id),
                HttpStatus.OK);
    }


}
