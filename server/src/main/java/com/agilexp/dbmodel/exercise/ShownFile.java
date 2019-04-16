package com.agilexp.dbmodel.exercise;

import javax.persistence.Entity;

@Entity(name="shown_file")
public class ShownFile extends ExerciseContent {

    public ShownFile() {
    }

    public ShownFile(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "ShownFile{} " + super.toString();
    }
}
