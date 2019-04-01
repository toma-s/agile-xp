package com.agilexp.model;

import javax.persistence.*;

@Entity
@Table(name="exercise_configs")
public class ExerciseFile {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="exercise_id")
    private long exerciseId;

    @Column(name="filename")
    private String fileName;

    @Column(name="content")
    private String content;

    public ExerciseFile() {
    }

    public ExerciseFile(long exerciseId, String fileName, String content) {
        this.exerciseId = exerciseId;
        this.fileName = fileName;
        this.content = content;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "ExerciseFile{" +
                "id=" + id +
                ", exerciseId=" + exerciseId +
                ", fileName='" + fileName + '\'' +
//                ", content='" + content + '\'' +
                '}';
    }
}
