package com.agilexp.dbmodel.exercise;

import javax.persistence.Entity;

@Entity(name="shown_test")
public class ShownTest extends ExerciseContent {

    public ShownTest() {
    }

    public ShownTest(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "ShownTest{} " + super.toString();
    }
}
