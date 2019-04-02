package com.agilexp.model;

import javax.persistence.*;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "content_type")
public abstract class ExerciseContent {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    long id;

    @Column(name = "filename")
    String fileName;

    @Column(name = "content")
    String content;

    @Column(name = "exercise_id")
    long exerciseId;

    public ExerciseContent() {
    }

    public ExerciseContent(long exerciseId, String fileName, String content) {
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
        return "ExerciseContent{" +
                "id=" + id +
                ", fileName='" + fileName + '\'' +
                ", content='" + content + '\'' +
                ", exerciseId=" + exerciseId +
                '}';
    }
}
