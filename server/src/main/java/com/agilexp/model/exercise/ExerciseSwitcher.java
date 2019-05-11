package com.agilexp.model.exercise;

import com.agilexp.dbmodel.exercise.ExerciseContent;


public class ExerciseSwitcher extends ExerciseContent {

    private String filename;
    private String content;

    public ExerciseSwitcher() {
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
        return "ExerciseSwitcher{} " + super.toString();
    }
}
