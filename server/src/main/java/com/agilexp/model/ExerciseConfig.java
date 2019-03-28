package com.agilexp.model;

import javax.persistence.*;

@Entity
@Table(name="exercise_configs")
public class ExerciseConfig {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="solution_id")
    private long solutionId;

    @Column(name="filename")
    private String fileName;

    @Column(name="text")
    private String text;

    public ExerciseConfig() {
    }

    public ExerciseConfig(long solutionId, String fileName, String text) {
        this.solutionId = solutionId;
        this.fileName = fileName;
        this.text = text;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getSolutionId() {
        return solutionId;
    }

    public void setSolutionId(long solutionId) {
        this.solutionId = solutionId;
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
                ", solutionId=" + solutionId +
                ", fileName='" + fileName + '\'' +
                ", text='" + text + '\'' +
                '}';
    }
}
