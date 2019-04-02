package com.agilexp.model;

import javax.persistence.Entity;

@Entity(name="exercise_controller")
public class ExerciseController extends ExerciseContent {

    public ExerciseController() {
    }

    public ExerciseController(long exerciseId, String fileName, String content) {
        super(exerciseId, fileName, content);
    }

    @Override
    public String toString() {
        return "ExerciseController{} " + super.toString();
    }
}
