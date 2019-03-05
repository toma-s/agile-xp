package com.agilexp.controller;

import com.agilexp.model.Lesson;
import com.agilexp.repository.LessonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.Date;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class LessonController {
    @Autowired
    LessonRepository repository;

    @PostMapping(value = "/lessons/create")
    public Lesson postCourse(@RequestBody Lesson lesson) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());
        Lesson _message = repository.save(new Lesson(lesson.getName(), lesson.getCourseId(),
                created, lesson.getDescription()));
        System.out.format("Created lesson %s at %s from course #%s", lesson.getName(), created,
                lesson.getCourseId());
        return _message;
    }

    // TODO: 05-Mar-19 getById getAll deleteById deleteAll updateLesson
}
