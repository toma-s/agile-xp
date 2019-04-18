package com.agilexp.dbmodel.exercise;

import javax.persistence.Entity;

@Entity(name="private_test")
public class PrivateTest extends ExerciseContent {

    public PrivateTest() {}

    public PrivateTest(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "PrivateTest{} " + super.toString();
    }
}
