package com.agilexp.dbmodel.solution;

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

    @Column(name="solved")
    private boolean solved;

    @Column(name="created")
    private Timestamp created;

    public SolutionEstimation() {
    }

    public SolutionEstimation(long solutionId) {
        this.solutionId = solutionId;
    }

    public SolutionEstimation(long solutionId, String estimation, boolean solved, Timestamp created) {
        this.solutionId = solutionId;
        this.estimation = estimation;
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

    @Override
    public String toString() {
        return "SolutionEstimation{" +
                "id=" + id +
                ", solutionId=" + solutionId +
                ", estimation='" + estimation + '\'' +
                ", solved=" + solved +
                '}';
    }
}
