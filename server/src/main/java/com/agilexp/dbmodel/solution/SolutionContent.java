package com.agilexp.dbmodel.solution;
import javax.persistence.*;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "solution_content_type")
public abstract class SolutionContent {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="solution_id")
    private long solutionId;

    @Column(name="filename")
    private String filename;

    @Column(name="content")
    private String content;

    SolutionContent() {
    }

    SolutionContent(long solutionId, String filename, String content) {
        this.solutionId = solutionId;
        this.filename = filename;
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

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "SolutionContent{" +
                "id=" + id +
                ", solutionId=" + solutionId +
                ", filename='" + filename + '\'' +
//                ", content='" + content + '\'' +
                '}';
    }
}
