package com.agilexp.dbmodel.exercise;

import javax.persistence.Entity;

@Entity(name="shown_source")
public class ShownSource extends ExerciseContent {

    public ShownSource() {
    }

    public ShownSource(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "ShownSource{} " + super.toString();
    }
}
