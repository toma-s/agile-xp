package com.agilexp.dbmodel.exercise;

import javax.persistence.Entity;

@Entity(name="private_source")
public class PrivateSource extends ExerciseContent {

    public PrivateSource() {}

    public PrivateSource(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "PrivateSource{} " + super.toString();
    }
}
