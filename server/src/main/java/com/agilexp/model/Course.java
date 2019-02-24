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

    public Course() {}

    public Course(String name, Timestamp created) {
        this.name = name;
        this.created = created;
    }

    public String getName() {
        return name;
    }
}
