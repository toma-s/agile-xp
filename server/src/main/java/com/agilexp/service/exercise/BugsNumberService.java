package com.agilexp.service.exercise;

import com.agilexp.dbmodel.exercise.BugsNumber;

public interface BugsNumberService {

    public abstract BugsNumber create(long exerciseId, int bugsNumber);

    public abstract BugsNumber getByExerciseId(long exerciseId);
}
