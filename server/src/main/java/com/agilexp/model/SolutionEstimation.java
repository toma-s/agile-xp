package com.agilexp.model;

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

    public SolutionEstimation() {
    }

    public SolutionEstimation(long solutionId, String estimation) {
        this.solutionId = solutionId;
        this.estimation = estimation;
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

    @Override
    public String toString() {
        return "SolutionEstimation{" +
                "id=" + id +
                ", solutionId=" + solutionId +
                ", estimation='" + estimation.substring(0, 10) + '\'' +
                '}';
    }
}
