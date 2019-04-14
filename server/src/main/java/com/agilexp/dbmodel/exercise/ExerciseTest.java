package com.agilexp.dbmodel.exercise;

import javax.persistence.*;

@Entity(name="exercise_test")
public class ExerciseTest extends ExerciseContent {

    public ExerciseTest() {}

    public ExerciseTest(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "ExerciseTest{} " + super.toString();
    }
}
