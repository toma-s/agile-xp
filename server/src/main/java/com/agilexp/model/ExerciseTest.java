package com.agilexp.model;

import javax.persistence.*;

@Entity(name="exercise_test")
public class ExerciseTest extends ExerciseContent {

    public ExerciseTest() {}

    public ExerciseTest(long exerciseId, String fileName, String content) {
        super(exerciseId, fileName, content);
    }

    @Override
    public String toString() {
        return "ExerciseTest{" +
                "id=" + id +
                ", fileName='" + fileName + '\'' +
//                ", content='" + content.substring(0, 10) + '\'' +
                ", exerciseId=" + exerciseId +
                '}';
    }
}
