package com.agilexp.model;

import javax.persistence.*;

@Entity
@Table(name="exercise_sources")
public class ExerciseSource {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="filename")
    private String fileName;

    @Column(name="content")
    private String content;

    @Column(name="exercise_id")
    private long exerciseId;

    public ExerciseSource() {}

    public ExerciseSource(long exerciseId, String fileName, String content) {
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

    public long getExerciseId() {
        return exerciseId;
    }

    public void setExerciseId(long exerciseId) {
        this.exerciseId = exerciseId;
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
