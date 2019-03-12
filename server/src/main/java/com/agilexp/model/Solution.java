package com.agilexp.model;

import javax.persistence.*;

@Entity
@Table(name="solutions")
public class Solution {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name = "exercise_id")
    private long exerciseId;

    public Solution() {}

    public Solution(long exerciseId) {
        this.exerciseId = exerciseId;
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

    @Override
    public String toString() {
        return "Solution{" +
                "id=" + id +
                ", exerciseId=" + exerciseId +
                '}';
    }
}
