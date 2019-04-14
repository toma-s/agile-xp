package com.agilexp.dbmodel.exercise;

import javax.persistence.*;

@Entity(name="exercise_file")
public class ExerciseFile extends ExerciseContent {

    public ExerciseFile() {
    }

    public ExerciseFile(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "ExerciseFile{} " + super.toString();
    }
}
