package com.agilexp.dbmodel.exercise;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.lang.Nullable;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name="exercises")
public class Exercise {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name="name")
    private String name;

    @Column(name="index")
    private long index;

    @Column(name="lesson_id")
    private long lessonId;

    @Column(name="type_id")
    private long typeId;

    @Column(name="created")
    private Timestamp created;

    @Column(name="description")
    private String description;

    @Column(name="load_solution_sources")
    @Value("$")
    private Long loadSolutionSources;

    @Column(name="load_solution_tests")
    private Long loadSolutionTests;

    @Column(name="load_solution_files")
    private Long loadSolutionFiles;

    public Exercise() {}

    public Exercise(String name, long index, long lessonId, long typeId, Timestamp created, String description, long loadSolutionSources, long loadSolutionTests, long loadSolutionFiles) {
        this.name = name;
        this.index = index;
        this.lessonId = lessonId;
        this.typeId = typeId;
        this.created = created;
        this.description = description;
        this.loadSolutionSources = loadSolutionSources;
        this.loadSolutionTests = loadSolutionTests;
        this.loadSolutionFiles = loadSolutionFiles;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getIndex() {
        return index;
    }

    public void setIndex(long index) {
        this.index = index;
    }

    public long getLessonId() {
        return lessonId;
    }

    public void setLessonId(long lessonId) {
        this.lessonId = lessonId;
    }

    public long getTypeId() {
        return typeId;
    }

    public void setTypeId(long typeId) {
        this.typeId = typeId;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public long getLoadSolutionSources() {
        return loadSolutionSources;
    }

    public void setLoadSolutionSources(long loadSolutionSources) {
        this.loadSolutionSources = loadSolutionSources;
    }

    public long getLoadSolutionTests() {
        return loadSolutionTests;
    }

    public void setLoadSolutionTests(long loadSolutionTests) {
        this.loadSolutionTests = loadSolutionTests;
    }

    public long getLoadSolutionFiles() {
        return loadSolutionFiles;
    }

    public void setLoadSolutionFiles(long loadSolutionFiles) {
        this.loadSolutionFiles = loadSolutionFiles;
    }

    @Override
    public String toString() {
        return "Exercise{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", index=" + index +
                ", lessonId=" + lessonId +
                ", typeId=" + typeId +
                ", created=" + created +
                ", description='" + description + '\'' +
                ", loadSolutionSources=" + loadSolutionSources +
                ", loadSolutionTests=" + loadSolutionTests +
                ", loadSolutionFiles=" + loadSolutionFiles +
                '}';
    }
}
