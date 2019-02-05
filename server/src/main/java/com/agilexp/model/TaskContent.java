package com.agilexp.model;

public class TaskContent extends Task {

    private long taskId;
    private String sourceFilename;
    private String testFilename;
    private String sourceCode;
    private String testCode;

    public TaskContent() {}

    public long getId() {
        return this.taskId;
    }

    public String getSourceCode() {
        return this.sourceCode;
    }

    public String getTestCode() {
        return this.testCode;
    }

    public String getSourceFilename() {
        return this.sourceFilename;
    }

    public String getTestFilename() {
        return this.testFilename;
    }


    public void setId(Long taskId) {
        this.taskId = taskId;
    }

    public void setSourceCode(String sourceCode) {
        this.sourceCode = sourceCode;
    }

    public void setTestCode(String testCode) {
        this.testCode = testCode;
    }

    public void setSourceFilename(String sourceFilename) {
        this.sourceFilename = sourceFilename;
    }

    public void setTestFilename(String testFilename) {
        this.testFilename = testFilename;
    }

}