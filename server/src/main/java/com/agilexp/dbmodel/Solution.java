package com.agilexp.dbmodel;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name="solutions")
public class Solution {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name = "exercise_id")
    private long exerciseId;

    @Column(name="created")
    private Timestamp created;

    public Solution() {}

    public Solution(long exerciseId, Timestamp created) {
        this.exerciseId = exerciseId;
        this.created = created;
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

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    @Override
    public String toString() {
        return "Solution{" +
                "id=" + id +
                ", exerciseId=" + exerciseId +
                ", created=" + created +
                '}';
    }
}
