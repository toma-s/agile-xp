package com.agilexp.controller;

import com.agilexp.dbmodel.Lesson;
import com.agilexp.service.LessonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class LessonController {

    @Autowired
    private LessonService service;

    @PostMapping(value = "/lessons/create")
    public ResponseEntity<Lesson> createLesson(@RequestBody Lesson lesson) {
        service.create(lesson);
        return new ResponseEntity<>(lesson, HttpStatus.CREATED);
    }

    @GetMapping(value="/lessons/{id}")
    public ResponseEntity<Lesson> getLessonById(@PathVariable("id") long id) {
        Lesson lesson = service.getById(id);
        return new ResponseEntity<>(lesson, HttpStatus.OK);
    }

    @GetMapping(value="/lessons/course/{courseId}")
    public ResponseEntity<List<Lesson>> getLessonsByCourseId(@PathVariable("courseId") long courseId) {
        List<Lesson> courses = service.getByCourseId(courseId);
        return new ResponseEntity<>(courses, HttpStatus.OK);
    }

    @PutMapping("/lessons/{id}")
    public ResponseEntity<Lesson> updateLesson(@PathVariable("id") long id, @RequestBody Lesson lesson) {
        if (service.update(id, lesson)) {
            Lesson updatedLesson = service.getById(id);
            return new ResponseEntity<>(updatedLesson, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/lessons/{id}")
    public ResponseEntity<String> deleteLesson(@PathVariable("id") long id) {
        service.delete(id);
        return new ResponseEntity<>(
                String.format("Lesson with id %s has been deleted", id),
                HttpStatus.OK);
    }
}
