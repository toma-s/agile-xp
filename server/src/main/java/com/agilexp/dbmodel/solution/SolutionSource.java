package com.agilexp.dbmodel.solution;

import javax.persistence.*;
import java.util.List;

@Entity(name="solution_source")
public class SolutionSource extends SolutionContent {

    public SolutionSource() {}

    public SolutionSource(long solutionId, String filename, String content) {
        super(solutionId, filename, content);
    }

    @Override
    public String toString() {
        return "SolutionSource{} " + super.toString();
    }
}
