package com.agilexp.model;

import javax.persistence.*;

@Entity
@Table(name="solution_tests")
public class SolutionTest {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="solution_id")
    private long solutionId;

    @Column(name="filename")
    private String fileName;

    @Column(name="content")
    private String content;

    public SolutionTest() {
    }

    public SolutionTest(long solutionId, String fileName, String content) {
        this.solutionId = solutionId;
        this.fileName = fileName;
        this.content = content;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "SolutionTest{" +
                "id=" + id +
                ", solutionId=" + solutionId +
                ", fileName='" + fileName + '\'' +
//                ", content='" + content.substring(0, 10) + '\'' +
                '}';
    }
}
