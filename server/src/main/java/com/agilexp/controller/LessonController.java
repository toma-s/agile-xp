package com.agilexp.controller;

import com.agilexp.model.Lesson;
import com.agilexp.repository.LessonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

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
        Lesson _lesson = repository.save(new Lesson(lesson.getName(), lesson.getCourseId(),
                created, lesson.getDescription()));
        System.out.format("Created lesson %s at %s from course #%s", lesson.getName(), created,
                lesson.getCourseId());
        return _lesson;
    }

    @GetMapping(value="/lessons/{id}")
    public Lesson getLessonById(@PathVariable("id") long id) {
        System.out.println("Get lesson with id " + id + "...");

        Optional<Lesson> taskDataOptional = repository.findById(id);
        return taskDataOptional.orElse(null);
    }

    @GetMapping(value="/lessons/course/{courseId}")
    public List<Lesson> getLessonsByCourseId(@PathVariable("courseId") long courseId) {
        System.out.println("Get lessons with course id " + courseId + "...");

        List<Lesson> lessons = new ArrayList<>(repository.findByCourseId(courseId));
        return lessons;
    }

    // TODO: 05-Mar-19 getById getAll deleteById deleteAll updateLesson
}
