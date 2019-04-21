package com.agilexp.dbmodel.solution;

import javax.persistence.*;

@Entity(name="solution_test")
public class SolutionTest extends SolutionContent {

    public SolutionTest() {
    }

    public SolutionTest(long solutionId, String filename, String content, long solutionEstimationId) {
        super(solutionId, filename, content, solutionEstimationId);
    }

    @Override
    public String toString() {
        return "SolutionTest{} " + super.toString();
    }
}
