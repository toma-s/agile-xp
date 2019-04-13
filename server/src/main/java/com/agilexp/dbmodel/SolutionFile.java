package com.agilexp.dbmodel;

import javax.persistence.*;

@Entity(name="solution_file")
public class SolutionFile extends SolutionContent {

    public SolutionFile() {
    }

    public SolutionFile(long solutionId, String filename, String content) {
        super(solutionId, filename, content);
    }

    @Override
    public String toString() {
        return "SolutionFile{} " + super.toString();
    }
}
