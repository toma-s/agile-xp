package com.agilexp.model;

import javax.persistence.Entity;

@Entity(name="exercise_switcher")
public class ExerciseSwitcher extends ExerciseContent {

    public ExerciseSwitcher() {
    }

    public ExerciseSwitcher(long exerciseId, String fileName, String content) {
        super(exerciseId, fileName, content);
    }

    @Override
    public String toString() {
        return "ExerciseSwitcher{} " + super.toString();
    }
}
