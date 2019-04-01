package com.agilexp.model;

import javax.persistence.*;

@Entity(name="source")
public class ExerciseSource extends ExerciseContent {

    public ExerciseSource() {}

    public ExerciseSource(long exerciseId, String fileName, String content) {
        super(exerciseId, fileName, content);
    }

    @Override
    public String toString() {
        return "ExerciseSource{" +
                "id=" + id +
                ", fileName='" + fileName + '\'' +
//                ", content='" + content.substring(0, 10) + '\'' +
                ", exerciseId=" + exerciseId +
                '}';
    }
}
