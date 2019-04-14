package com.agilexp.dbmodel.exercise;

import javax.persistence.*;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "exercise_content_type")
public abstract class ExerciseContent {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    long id;

    @Column(name = "filename")
    private String filename;

    @Column(name = "content")
    private String content;

    @Column(name = "exercise_id")
    private long exerciseId;

    public ExerciseContent() {
    }

    public ExerciseContent(long exerciseId, String filename, String content) {
        this.exerciseId = exerciseId;
        this.filename = filename;
        this.content = content;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
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
                ", filename='" + filename + '\'' +
//                ", content='" + content + '\'' +
                ", exerciseId=" + exerciseId +
                '}';
    }
}
