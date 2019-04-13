package com.agilexp.dbmodel;

import javax.persistence.*;

@Entity(name="solution_test")
public class SolutionTest extends SolutionContent {

    public SolutionTest() {
    }

    public SolutionTest(long solutionId, String filename, String content) {
        super(solutionId, filename, content);
    }

    @Override
    public String toString() {
        return "SolutionTest{} " + super.toString();
    }
}
