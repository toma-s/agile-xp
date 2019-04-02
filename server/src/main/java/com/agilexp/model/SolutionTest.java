package com.agilexp.model;

import javax.persistence.*;

@Entity(name="solution_test")
public class SolutionTest extends SolutionContent {

    public SolutionTest() {
    }

    public SolutionTest(long solutionId, String fileName, String content) {
        super(solutionId, fileName, content);
    }

    @Override
    public String toString() {
        return "SolutionTest{} " + super.toString();
    }
}
