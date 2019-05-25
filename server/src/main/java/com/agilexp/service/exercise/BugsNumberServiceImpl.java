package com.agilexp.service.exercise;

import com.agilexp.dbmodel.exercise.BugsNumber;
import com.agilexp.repository.exercise.BugsNumberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BugsNumberServiceImpl implements BugsNumberService {

    @Autowired
    BugsNumberRepository repository;

    @Override
    public BugsNumber create(long exerciseId, int bugsNumber) {
        BugsNumber newBugsNumber = new BugsNumber();
        newBugsNumber.setExerciseId(exerciseId);
        newBugsNumber.setNumber(bugsNumber);
        repository.save(newBugsNumber);
        System.out.format("Created bugs number %s for exercise %s\n", newBugsNumber.getId(), newBugsNumber.getExerciseId());
        return newBugsNumber;
    }

    @Override
    public BugsNumber getByExerciseId(long exerciseId) {
        BugsNumber bugsNumber = repository.findBugsNumberByExerciseId(exerciseId);
        System.out.println(System.out.format("Got bugs number with exercise id %s\n", exerciseId));
        System.out.println(exerciseId);
        System.out.println(bugsNumber);
        return bugsNumber;
    }
}
