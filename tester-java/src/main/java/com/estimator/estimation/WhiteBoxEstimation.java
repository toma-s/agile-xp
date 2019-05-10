package com.estimator.estimation;

public class WhiteBoxEstimation {

    private boolean compiled;
    private String compilationResult;
    private boolean tested;
    private String testsResult;

    public WhiteBoxEstimation() {
    }

    public boolean isCompiled() {
        return compiled;
    }

    public void setCompiled(boolean compiled) {
        this.compiled = compiled;
    }

    public String getCompilationResult() {
        return compilationResult;
    }

    public void setCompilationResult(String compilationResult) {
        this.compilationResult = compilationResult;
    }

    public boolean isTested() {
        return tested;
    }

    public void setTested(boolean tested) {
        this.tested = tested;
    }

    public String getTestsResult() {
        return testsResult;
    }

    public void setTestsResult(String testsResult) {
        this.testsResult = testsResult;
    }
}
