package com.agilexp.service.exercise;

import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.exercise.PrivateTest;
import com.agilexp.repository.exercise.PrivateTestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class PrivateTestServiceImpl implements ExerciseContentService {

    @Autowired
    private PrivateTestRepository repository;

    private final String contentType = "private test";

    @Override
    public PrivateTest create(ExerciseContent exerciseContent) {
        PrivateTest newExerciseContent = repository.save(new PrivateTest(
                exerciseContent.getExerciseId(),
                exerciseContent.getFilename(),
                exerciseContent.getContent()
        ));
        System.out.format("Created %s %s\n", contentType, newExerciseContent);
        return newExerciseContent;
    }

    @Override
    public List<PrivateTest> getByExerciseId(long exerciseId) {
        List<PrivateTest> exerciseContents = new ArrayList<>(repository.findPrivateTestsByExerciseId(exerciseId));
        System.out.format("Found %s from exercise %s: %s\n", contentType, exerciseId, exerciseContents);
        return exerciseContents;
    }

    @Override
    public boolean update(long id, ExerciseContent exerciseContent) {
        Optional<PrivateTest> optional = repository.findById(id);
        if (!optional.isPresent()) {
            System.out.format("Failed to %s with id %s\n", contentType, id);
            return false;
        }
        PrivateTest updatedExerciseContent = optional.get();
        updatedExerciseContent.setFilename(exerciseContent.getFilename());
        updatedExerciseContent.setExerciseId(exerciseContent.getExerciseId());
        updatedExerciseContent.setContent(exerciseContent.getContent());
        repository.save(updatedExerciseContent);
        System.out.format("Updated %s with id %s\n", contentType, id);
        return true;
    }

    @Override
    public void deleteByExerciseId(long exerciseId) {
        List<PrivateTest> privateFiles = repository.findPrivateTestsByExerciseId(exerciseId);
        privateFiles.forEach(privateFile -> repository.delete(privateFile));
        System.out.format("Deleted %ss with exercise id %s\n", contentType, exerciseId);
    }
}
