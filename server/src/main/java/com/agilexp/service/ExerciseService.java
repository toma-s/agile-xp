package com.agilexp.service;

import com.agilexp.dbmodel.exercise.Exercise;

import java.util.List;

public interface ExerciseService {

    public abstract Exercise create(Exercise exercise);
    public abstract Exercise getById(long id);
    public abstract List<Exercise> getByLessonId(long lessonId);
    public abstract List<Exercise> getAll();
    public abstract boolean update(long id, Exercise exercise);
    public abstract void delete(long id);
}
