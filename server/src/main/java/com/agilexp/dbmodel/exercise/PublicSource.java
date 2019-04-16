package com.agilexp.dbmodel.exercise;

import javax.persistence.Entity;

@Entity(name="public_source")
public class PublicSource extends ExerciseContent {

    public PublicSource() {
    }

    public PublicSource(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "PublicSource{} " + super.toString();
    }
}
