package com.agilexp.service.exercise;

import com.agilexp.dbmodel.exercise.Exercise;
import com.agilexp.repository.exercise.ExerciseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class ExerciseServiceImpl implements ExerciseService {

    @Autowired
    private ExerciseRepository repository;

    @Override
    public Exercise create(Exercise exercise) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());
        Exercise newExercise = repository.save(new Exercise(
                exercise.getName(),
                exercise.getIndex(),
                exercise.getLessonId(),
                exercise.getTypeId(),
                created,
                exercise.getDescription()));
        System.out.format("Created exercise %s from lesson %s\n", newExercise.getName(), newExercise.getLessonId());
        return newExercise;
    }

    @Override
    public Exercise getById(long id) {
        Optional<Exercise> optional = repository.findById(id);
        System.out.format("Got exercise with id %s\n", id);
        return optional.orElse(null);
    }

    @Override
    public List<Exercise> getByLessonId(long lessonId) {
        List<Exercise> exercises = repository.findAllByLessonIdOrderByIndex(lessonId);
        System.out.format("Got exercises with lesson id %s\n", lessonId);
        return exercises;
    }

    @Override
    public List<Exercise> getAll() {
        List<Exercise> exercises = new ArrayList<>();
        repository.findAll().forEach(exercises::add);
        System.out.println("Got all exercises");
        return exercises;
    }

    @Override
    public boolean update(long id, Exercise exercise) {
        Optional<Exercise> exerciseData = repository.findById(id);
        if (!exerciseData.isPresent()) {
            System.out.format("Failed to update exercise with id %s\n", id);
            return false;
        }
        Exercise updatedExercise = exerciseData.get();
        updatedExercise.setName(exercise.getName());
        updatedExercise.setIndex(exercise.getIndex());
        updatedExercise.setLessonId(exercise.getLessonId());
        updatedExercise.setTypeId(exercise.getTypeId());
        updatedExercise.setCreated(exercise.getCreated());
        updatedExercise.setDescription(exercise.getDescription());
        repository.save(updatedExercise);
        System.out.format("Updates exercise with id %s\n", id);
        return true;
    }

    @Override
    public void delete(long id) {
        repository.deleteById(id);
        System.out.format("Deleted exercise with id %s\n", id);
    }
}
