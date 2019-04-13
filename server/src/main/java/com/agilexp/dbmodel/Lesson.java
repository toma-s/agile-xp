package com.agilexp.dbmodel;


import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name="lessons")
public class Lesson {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="name")
    private String name;

    @Column(name="course_id")
    private long courseId;

    @Column(name="created")
    private Timestamp created;

    @Column(name="description")
    private String description;

    public Lesson() {}

    public Lesson(String name, long courseId, Timestamp created, String description) {
        this.name = name;
        this.courseId = courseId;
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

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public long getCourseId() {
        return courseId;
    }

    public void setCourseId(long courseId) {
        this.courseId = courseId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Lesson{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", courseId=" + courseId +
                ", created=" + created +
                ", description='" + description + '\'' +
                '}';
    }
}
