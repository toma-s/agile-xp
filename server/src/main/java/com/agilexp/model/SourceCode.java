package com.agilexp.model;

import javax.persistence.*;

@Entity
@Table(name="source_codes")
public class SourceCode {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="filename")
    private String fileName;

    @Column(name="exercise_id")
    private long exerciseId;

    public SourceCode() {}

    public SourceCode(String fileName, long exerciseId) {
        this.fileName = fileName;
        this.exerciseId = exerciseId;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public long getExerciseId() {
        return exerciseId;
    }

    public void setExerciseId(long exerciseId) {
        this.exerciseId = exerciseId;
    }
}
