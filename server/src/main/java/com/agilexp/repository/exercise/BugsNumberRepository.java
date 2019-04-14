package com.agilexp.repository.exercise;

import com.agilexp.dbmodel.exercise.BugsNumber;
import org.springframework.data.repository.CrudRepository;

public interface BugsNumberRepository extends CrudRepository<BugsNumber, Long> {
    BugsNumber findBugsNumberByExerciseId(long exerciseId);
}
