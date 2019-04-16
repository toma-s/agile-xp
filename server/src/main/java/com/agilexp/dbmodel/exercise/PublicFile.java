package com.agilexp.dbmodel.exercise;

import javax.persistence.Entity;

@Entity(name="public_file")
public class PublicFile extends ExerciseContent {

    public PublicFile() {
    }

    public PublicFile(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "PublicFile{} " + super.toString();
    }
}
