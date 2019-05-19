package com.agilexp.service;

import com.agilexp.dbmodel.Course;
import com.agilexp.dbmodel.Lesson;
import com.agilexp.repository.LessonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class LessonServiceImpl implements LessonService {

    @Autowired
    LessonRepository repository;

    @Override
    public Lesson create(Lesson lesson) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());
        Lesson newLesson = repository.save(new Lesson(lesson.getName(),
                lesson.getIndex(),
                lesson.getCourseId(),
                created,
                lesson.getDescription()));
        System.out.format("Created lesson %s from course %s\n", newLesson.getName(), newLesson.getCourseId());
        return newLesson;
    }

    @Override
    public Lesson getById(long id) {
        Optional<Lesson> optional = repository.findById(id);
        System.out.format("Got lesson with id %s\n", id);
        return optional.orElse(null);
    }

    @Override
    public List<Lesson> getByCourseId(long courseId) {
        List<Lesson> lessons = repository.findByCourseId(courseId);
        System.out.format("Got lessons with course id %s\n", courseId);
        return lessons;
    }

    @Override
    public boolean update(long id, Lesson lesson) {
        Optional<Lesson> lessonData = repository.findById(id);
        if (!lessonData.isPresent()) {
            System.out.format("Failed to update lesson with id %s\n", id);
            return false;
        }
        Lesson updatedLesson = lessonData.get();
        updatedLesson.setName(lesson.getName());
        updatedLesson.setCreated(lesson.getCreated());
        updatedLesson.setDescription(lesson.getDescription());
        repository.save(updatedLesson);
        System.out.format("Updates lesson with id %s\n", id);
        return true;
    }

    @Override
    public void delete(long id) {
        repository.deleteById(id);
        System.out.format("Deleted lesson with id %s\n", id);
    }

}
