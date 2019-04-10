package com.agilexp.model;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name="courses")
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="name")
    private String name;

    @Column(name="created")
    private Timestamp created;

    @Column(name="description")
    private String description;

    public Course() {}

    public Course(String name, Timestamp created, String description) {
        this.name = name;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Course{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", created=" + created +
                ", description='" + description + '\'' +
                '}';
    }
}
