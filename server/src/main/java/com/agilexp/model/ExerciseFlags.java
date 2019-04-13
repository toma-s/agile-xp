package com.agilexp.model;

import com.agilexp.dbmodel.ExerciseContent;

public class ExerciseFlags extends ExerciseContent {

    private String filename;
    private String content;

    public ExerciseFlags() {
    }

    @Override
    public String getFilename() {
        return filename;
    }

    @Override
    public void setFilename(String filename) {
        this.filename = filename;
    }

    @Override
    public String getContent() {
        return content;
    }

    @Override
    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "ExerciseFlags{} " + super.toString();
    }
}
