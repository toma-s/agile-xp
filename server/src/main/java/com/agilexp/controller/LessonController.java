package com.agilexp.controller;

import com.agilexp.dbmodel.Lesson;
import com.agilexp.service.LessonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class LessonController {

    @Autowired
    LessonService lessonService;

    @PostMapping(value = "/lessons/create")
    public ResponseEntity<Lesson> createLesson(@RequestBody Lesson lesson) {
        lessonService.create(lesson);
        return new ResponseEntity<>(lesson, HttpStatus.CREATED);
    }

    @GetMapping(value="/lessons/{id}")
    public ResponseEntity<Lesson> getLessonById(@PathVariable("id") long id) {
        Lesson lesson = lessonService.getById(id);
        return new ResponseEntity<>(lesson, HttpStatus.OK);
    }

    @GetMapping(value="/lessons/course/{courseId}")
    public ResponseEntity<List<Lesson>> getLessonsByCourseId(@PathVariable("courseId") long courseId) {
        List<Lesson> courses = lessonService.getByCourseId(courseId);
        return new ResponseEntity<>(courses, HttpStatus.OK);
    }

    @PutMapping("/lessons/{id}")
    public ResponseEntity<Lesson> updateLesson(@PathVariable("id") long id, @RequestBody Lesson lesson) {
        if (lessonService.update(id, lesson)) {
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/lessons/{id}")
    public ResponseEntity<String> deleteLesson(@PathVariable("id") long id) {
        lessonService.delete(id);
        return new ResponseEntity<>(
                String.format("Lesson with id %s has been deleted", id),
                HttpStatus.OK);
    }
}
