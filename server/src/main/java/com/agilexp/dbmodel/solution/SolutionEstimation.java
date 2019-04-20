package com.agilexp.dbmodel.solution;

import javax.persistence.*;

@Entity
@Table(name="solution_estimations")
public class SolutionEstimation {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="solution_id")
    private long solutionId;

    @Column(name="estimation")
    private String estimation;

    @Column(name="solved")
    private boolean solved;

    public SolutionEstimation() {
    }

    public SolutionEstimation(long solutionId) {
        this.solutionId = solutionId;
    }

    public SolutionEstimation(long solutionId, String estimation, boolean solved) {
        this.solutionId = solutionId;
        this.estimation = estimation;
        this.solved = solved;
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
