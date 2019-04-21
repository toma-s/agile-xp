package com.agilexp.dbmodel.solution;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="solution_estimation")
public class SolutionEstimation {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="estimation")
    private String estimation;

    @Column(name="solved")
    private boolean solved;

    @OneToMany(mappedBy = "solutionEstimation")
    private List<SolutionContent> solutionContent;

    public SolutionEstimation() {
    }

    public SolutionEstimation(long solutionId, String estimation, boolean solved) {
        this.estimation = estimation;
        this.solved = solved;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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

    public List<SolutionContent> getSolutionContent() {
        return solutionContent;
    }

    public void setSolutionContent(List<SolutionContent> solutionContent) {
        this.solutionContent = solutionContent;
    }

    @Override
    public String toString() {
        return "SolutionEstimation{" +
                "id=" + id +
                ", estimation='" + estimation + '\'' +
                ", solved=" + solved +
                '}';
    }
}
