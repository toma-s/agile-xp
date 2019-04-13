package com.agilexp.dbmodel;

import javax.persistence.*;

@Entity
@Table(name="bugs_number")
public class BugsNumber {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    long id;

    @Column(name = "exercise_id")
    private long exerciseId;

    @Column(name = "number")
    private int number;

    public BugsNumber() {
    }

    public BugsNumber(long exerciseId, int number) {
        this.exerciseId = exerciseId;
        this.number = number;
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

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    @Override
    public String toString() {
        return "BugsNumber{" +
                "id=" + id +
                ", exerciseId=" + exerciseId +
                ", number=" + number +
                '}';
    }
}
