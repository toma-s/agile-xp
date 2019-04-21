package com.agilexp.dbmodel.solution;

import java.util.ArrayList;
import java.util.List;

public class SolutionItems {

    private long exerciseId;
    private List<SolutionSource> solutionSources = new ArrayList<>();
    private List<SolutionTest> solutionTests = new ArrayList<>();
    private List<SolutionFile> solutionFiles = new ArrayList<>();

    public SolutionItems() {
    }

    public SolutionItems(long exerciseId, List<SolutionSource> solutionSources, List<SolutionTest> solutionTests, List<SolutionFile> solutionFiles) {
        this.exerciseId = exerciseId;
        this.solutionSources = solutionSources;
        this.solutionTests = solutionTests;
        this.solutionFiles = solutionFiles;
    }

    public long getExerciseId() {
        return exerciseId;
    }

    public void setExerciseId(long exerciseId) {
        this.exerciseId = exerciseId;
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
}
