package com.agilexp.service.exercise;

import com.agilexp.dbmodel.exercise.ExerciseType;
import com.agilexp.repository.exercise.ExerciseTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ExerciseTypeServiceImpl implements ExerciseTypeService {

    @Autowired
    private ExerciseTypeRepository repository;

    @Override
    public ExerciseType getById(long id) {
        Optional<ExerciseType> optional = repository.findById(id);
        System.out.format("Got exercise type with id %s\n", id);
        return optional.orElse(null);
    }

    @Override
    public ExerciseType getByValue(String value) {
        ExerciseType exerciseType = repository.findByValue(value);
        System.out.format("Got exercise type with value %s\n", value);
        return exerciseType;
    }

    @Override
    public List<ExerciseType> getAll() {
        List<ExerciseType> exerciseTypes = new ArrayList<>();
        repository.findAll().forEach(exerciseTypes::add);
        System.out.println("Got all exercise types");
        return exerciseTypes;
    }
}
