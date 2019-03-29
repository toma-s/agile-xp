package com.agilexp.model;

import javax.persistence.*;

@Entity
@Table(name="exercise_configs")
public class ExerciseConfig {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="exercise_id")
    private long exerciseId;

    @Column(name="filename")
    private String fileName;

    @Column(name="text")
    private String text;

    public ExerciseConfig() {
    }

    public ExerciseConfig(long solutionId, String fileName, String text) {
        this.exerciseId = solutionId;
        this.fileName = fileName;
        this.text = text;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getExerciseId() {
        return exerciseId;
    }

    public void setExerciseId(long exerciseId) {
        this.exerciseId = exerciseId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    @Override
    public String toString() {
        return "ExerciseConfig{" +
                "id=" + id +
                ", exerciseId=" + exerciseId +
                ", fileName='" + fileName + '\'' +
//                ", text='" + text + '\'' +
                '}';
    }
}
