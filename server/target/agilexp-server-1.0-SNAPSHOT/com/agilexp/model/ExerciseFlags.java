package com.agilexp.model;

import javax.persistence.*;

@Entity(name="exercise_flags")
public class ExerciseFlags extends ExerciseContent {

    public ExerciseFlags() {
    }

    public ExerciseFlags(long exerciseId, String fileName, String content) {
        super(exerciseId, fileName, content);
    }

    @Override
    public String toString() {
        return "ExerciseFlags{} " + super.toString();
    }
}
