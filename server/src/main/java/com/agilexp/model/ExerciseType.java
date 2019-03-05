package com.agilexp.model;

import javax.persistence.*;

@Entity
@Table(name="exercise_types")
public class ExerciseType {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="name")
    private String name;

    public ExerciseType() {}

    public ExerciseType(String name) {
        this.name = name;
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
}
