package com.agilexp.model;

import javax.persistence.*;

@Entity(name="exercise_source")
public class ExerciseSource extends ExerciseContent {

    public ExerciseSource() {}

    public ExerciseSource(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "ExerciseSource{} " + super.toString();
    }
}
