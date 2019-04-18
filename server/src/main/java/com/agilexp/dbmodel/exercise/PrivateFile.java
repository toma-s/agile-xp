package com.agilexp.dbmodel.exercise;

import javax.persistence.Entity;

@Entity(name="private_file")
public class PrivateFile extends ExerciseContent {

    public PrivateFile() {
    }

    public PrivateFile(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "PrivateFile{} " + super.toString();
    }
}
