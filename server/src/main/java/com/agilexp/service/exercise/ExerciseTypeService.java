package com.agilexp.service.exercise;

import com.agilexp.dbmodel.exercise.ExerciseType;

import java.util.List;

public interface ExerciseTypeService {

    public abstract ExerciseType getById(long id);
    public abstract ExerciseType getByValue(String value);
    public abstract List<ExerciseType> getAll();
}
