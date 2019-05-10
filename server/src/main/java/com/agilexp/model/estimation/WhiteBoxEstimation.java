package com.agilexp.model.estimation;

public class WhiteBoxEstimation {

    private boolean compiled;
    private String compilationResult;
    private boolean tested;
    private String testsResult;
    private boolean solved;
    private int value;
    private String errorMessage;

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

    public boolean isSolved() {
        return solved;
    }

    public void setSolved(boolean solved) {
        this.solved = solved;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
}
