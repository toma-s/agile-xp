package com.agilexp.model;

import javax.persistence.*;

@Entity(name="solution_source")
public class SolutionSource extends SolutionContent {

    public SolutionSource() {}

    public SolutionSource(long solutionId, String fileName, String content) {
        super(solutionId, fileName, content);
    }

    @Override
    public String toString() {
        return "SolutionSource{} " + super.toString();
    }
}
