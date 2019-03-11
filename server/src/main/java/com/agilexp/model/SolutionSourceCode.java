package com.agilexp.model;

import javax.persistence.*;

@Entity
@Table(name="solution_source_code")
public class SolutionSourceCode {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="solution_id")
    private long solutionId;

    @Column(name="filename")
    private String fileName;

    @Column(name="code")
    private String code;

    public SolutionSourceCode() {}

    public SolutionSourceCode(long solutionId, String fileName, String code) {
        this.solutionId = solutionId;
        this.fileName = fileName;
        this.code = code;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getSolutionId() {
        return solutionId;
    }

    public void setSolutionId(long solutionId) {
        this.solutionId = solutionId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
