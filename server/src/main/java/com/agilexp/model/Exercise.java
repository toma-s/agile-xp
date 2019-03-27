package com.agilexp.model;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name="exercises")
public class Exercise {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="name")
    private String name;

    @Column(name="index")
    private long index;

    @Column(name="lesson_id")
    private long lessonId;

    @Column(name="type")
    private String type;

    @Column(name="created")
    private Timestamp created;

    @Column(name="description")
    private String description;

    public Exercise() {}

    public Exercise(String name, long index, long lessonId, String type, Timestamp created, String description) {
        this.name = name;
        this.index = index;
        this.lessonId = lessonId;
        this.type = type;
        this.created = created;
        this.description = description;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getIndex() {
        return index;
    }

    public void setIndex(long index) {
        this.index = index;
    }

    public long getLessonId() {
        return lessonId;
    }

    public void setLessonId(long lessonId) {
        this.lessonId = lessonId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Exercise{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", index=" + index +
                ", lessonId=" + lessonId +
                ", type='" + type + '\'' +
                ", created=" + created +
                ", description='" + description + '\'' +
                '}';
    }
}
