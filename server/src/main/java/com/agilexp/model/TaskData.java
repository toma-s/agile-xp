package com.agilexp.model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name="tasks")
public class TaskData extends Task {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="source_filename")
    private String sourceFilename;

    @Column(name="test_filename")
    private String testFilename;

    @Column(name= "timestamp")
    private Timestamp timestamp;

    @Column(name="result_run_time")
    private long resultRunTime;

    @Column(name="result_successful")
    private Boolean resultSuccessful;

    @Column(name="result_run_count")
    private int resultRunCount;

    @Column(name="result_failures_count")
    private int resultFailuresCount;

    @Column(name="result_failures")
    private String resultFailures;

    @Column(name="result_ignore_count")
    private int resultIgnoreCount;

    @Column(name="compile_successful")
    private Boolean compileSuccessful;

    @Column(name="compile_message")
    private String compileMessage;

    public TaskData() {}

    public TaskData(String sourceFilename, String testFilename, Timestamp timestamp) {
        this.sourceFilename = sourceFilename;
        this.testFilename = testFilename;
        this.timestamp = timestamp;
        this.resultRunTime = 0;
        this.resultSuccessful = false;
        this.resultRunCount = 0;
        this.resultFailuresCount = 0;
        this.resultFailures = "";
        this.resultIgnoreCount = 0;
        this.compileMessage = "";
    }

    public long getId() {
        return this.id;
    }

    public String getSourceFilename() {
        return this.sourceFilename;
    }

    public String getTestFilename() {
        return this.testFilename;
    }

    public Timestamp getTimestamp() {
        return this.timestamp;
    }

    public Long getResultRunTime() {
        return this.resultRunTime;
    }

    public boolean getResultSuccessful() {
        return this.resultSuccessful;
    }

    public int getResultRunCount() {
        return this.resultRunCount;
    }

    public int getResultFailureCount() {
        return this.resultFailuresCount;
    }

    public String getResultFailures() {
        return this.resultFailures;
    }

    public int getResultIgnoreCount() {
        return this.resultIgnoreCount;
    }

    public String getCompileMessage() {
        return this.compileMessage;
    }

    public Boolean getCompileSuccessful() {
        return this.compileSuccessful;
    }


    public void setId(Long id) {
        this.id = id;
    }

    public void setSourceFilename(String sourceFilename) {
        this.sourceFilename = sourceFilename;
    }

    public void setTestFilename(String testFilename) {
        this.testFilename = testFilename;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public void setResultRunTime(long resultRunTime) {
        this.resultRunTime = resultRunTime;
    }

    public void setResultSuccessful(boolean resultRunTime) {
        this.resultSuccessful = resultRunTime;
    }

    public void setResultRunCount(int resultRunCount) {
        this.resultRunCount = resultRunCount;
    }

    public void setResultFailuresCount(int resultFailuresCount) {
        this.resultFailuresCount = resultFailuresCount;
    }

    public void setResultFailures(List resultFailures) {
        this.resultFailures = resultFailures.toString();
    }

    public void setResultIgnoreCount(int resultIgnoreCount) {
        this.resultIgnoreCount = resultIgnoreCount;
    }

    public void setCompileMessage(String compileMessage) {
        this.compileMessage = compileMessage;
    }

    public void setCompileSuccessful(Boolean compileSuccessful) {
        this.compileSuccessful = compileSuccessful;
    }
}
