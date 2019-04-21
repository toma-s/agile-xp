package com.agilexp.dbmodel.solution;

import javax.persistence.*;

@Entity(name="solution_file")
public class SolutionFile extends SolutionContent {

    public SolutionFile() {
    }

    public SolutionFile(long solutionId, String filename, String content, long solutionEstimationId) {
        super(solutionId, filename, content, solutionEstimationId);
    }

    @Override
    public String toString() {
        return "SolutionFile{} " + super.toString();
    }
}
