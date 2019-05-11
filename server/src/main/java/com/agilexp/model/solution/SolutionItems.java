package com.agilexp.model.solution;

import com.agilexp.dbmodel.solution.SolutionFile;
import com.agilexp.dbmodel.solution.SolutionSource;
import com.agilexp.dbmodel.solution.SolutionTest;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class SolutionItems {

    private long exerciseId;
    private long solutionId;
    private List<SolutionSource> solutionSources = new ArrayList<>();
    private List<SolutionTest> solutionTests = new ArrayList<>();
    private List<SolutionFile> solutionFiles = new ArrayList<>();
    private String estimation;
    private boolean solved;
    private Timestamp created;

    public SolutionItems() {
    }

    public SolutionItems(long exerciseId, long solutionId, List<SolutionSource> solutionSources, List<SolutionTest> solutionTests, List<SolutionFile> solutionFiles, String estimation, boolean solved, Timestamp created) {
        this.exerciseId = exerciseId;
        this.solutionId = solutionId;
        this.solutionSources = solutionSources;
        this.solutionTests = solutionTests;
        this.solutionFiles = solutionFiles;
        this.estimation = estimation;
        this.solved = solved;
        this.created = created;
    }

    public long getExerciseId() {
        return exerciseId;
    }

    public void setExerciseId(long exerciseId) {
        this.exerciseId = exerciseId;
    }

    public long getSolutionId() {
        return solutionId;
    }

    public void setSolutionId(long solutionId) {
        this.solutionId = solutionId;
    }

    public List<SolutionSource> getSolutionSources() {
        return solutionSources;
    }

    public void setSolutionSources(List<SolutionSource> solutionSources) {
        this.solutionSources = solutionSources;
    }

    public List<SolutionTest> getSolutionTests() {
        return solutionTests;
    }

    public void setSolutionTests(List<SolutionTest> solutionTests) {
        this.solutionTests = solutionTests;
    }

    public List<SolutionFile> getSolutionFiles() {
        return solutionFiles;
    }

    public void setSolutionFiles(List<SolutionFile> solutionFiles) {
        this.solutionFiles = solutionFiles;
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

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }
}
