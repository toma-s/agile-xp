package com.agilexp.service.exercise;

import com.agilexp.dbmodel.exercise.ExerciseContent;

import java.util.List;

public interface ExerciseContentService {

    public abstract ExerciseContent create(ExerciseContent exerciseContent);

    public abstract List<? extends ExerciseContent> getByExerciseId(long exerciseId);

    public abstract boolean update(long id, ExerciseContent exerciseContent);

    public abstract void deleteByExerciseId(long exerciseId);
}
