package com.agilexp.dbmodel.exercise;

import javax.persistence.Entity;

@Entity(name="public_test")
public class PublicTest extends ExerciseContent {

    public PublicTest() {
    }

    public PublicTest(long exerciseId, String filename, String content) {
        super(exerciseId, filename, content);
    }

    @Override
    public String toString() {
        return "PublicTest{} " + super.toString();
    }
}
