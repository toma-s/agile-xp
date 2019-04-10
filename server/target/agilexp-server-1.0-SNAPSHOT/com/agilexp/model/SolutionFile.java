package com.agilexp.model;

import javax.persistence.*;

@Entity(name="solution_file")
public class SolutionFile extends SolutionContent {

    public SolutionFile() {
    }

    public SolutionFile(long solutionId, String fileName, String content) {
        super(solutionId, fileName, content);
    }

    @Override
    public String toString() {
        return "SolutionFile{} " + super.toString();
    }
}
