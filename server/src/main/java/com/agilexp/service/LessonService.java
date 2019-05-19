package com.agilexp.service;

import com.agilexp.dbmodel.Lesson;

import java.util.List;

public interface LessonService {

    public abstract Lesson create(Lesson lesson);
    public abstract Lesson getById(long id);
    public abstract List<Lesson> getByCourseId(long courseId);
    public abstract boolean update(long id, Lesson lesson);
    public abstract void delete(long id);
}
