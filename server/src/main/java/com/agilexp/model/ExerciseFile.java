package com.agilexp.model;

import javax.persistence.*;

@Entity(name="exercise_file")
public class ExerciseFile extends ExerciseContent {

    public ExerciseFile() {
    }

    public ExerciseFile(long exerciseId, String fileName, String content) {
        super(exerciseId, fileName, content);
    }

    @Override
    public String toString() {
        return "ExerciseFile{} " + super.toString();
    }
}
