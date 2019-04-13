package com.agilexp.repository;

import com.agilexp.dbmodel.BugsNumber;
import org.springframework.data.repository.CrudRepository;

public interface BugsNumberRepository extends CrudRepository<BugsNumber, Long> {
    BugsNumber findBugsNumberByExerciseId(long exerciseId);
}
