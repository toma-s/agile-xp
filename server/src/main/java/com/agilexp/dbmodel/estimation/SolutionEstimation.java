package com.agilexp.dbmodel.estimation;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name="solution_estimation")
public class SolutionEstimation {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="solutionId")
    private long solutionId;

    @Column(name="estimation")
    private String estimation;

    @Column(name="value")
    private int value;

    @Column(name="solved")
    private boolean solved;

    @Column(name="created")
    private Timestamp created;

    public SolutionEstimation() {
        value = 0;
        solved = false;
    }

    public SolutionEstimation(long solutionId, String estimation, int value, boolean solved, Timestamp created) {
        this.solutionId = solutionId;
        this.estimation = estimation;
        this.value = value;
        this.solved = solved;
        this.created = created;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getSolutionId() {
        return solutionId;
    }

    public void setSolutionId(long solutionId) {
        this.solutionId = solutionId;
    }

    public String getEstimation() {
        return estimation;
    }

    public void setEstimation(String estimation) {
        this.estimation = estimation;
    }

    public boolean isSolved() {
        return solved;
    }

    public void setSolved(boolean solved) {
        this.solved = solved;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "SolutionEstimation{" +
                "id=" + id +
                ", solutionId=" + solutionId +
                ", estimation='" + estimation + '\'' +
                ", value=" + value +
                ", solved=" + solved +
                ", created=" + created +
                '}';
    }
}
