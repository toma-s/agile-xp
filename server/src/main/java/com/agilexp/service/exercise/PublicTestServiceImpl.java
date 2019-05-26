package com.agilexp.service.exercise;

import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.exercise.PublicTest;
import com.agilexp.repository.exercise.PublicTestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class PublicTestServiceImpl implements ExerciseContentService {

    @Autowired
    PublicTestRepository repository;

    private final String contentType = "public test";

    @Override
    public PublicTest create(ExerciseContent exerciseContent) {
        PublicTest newExerciseContent = repository.save(new PublicTest(
                exerciseContent.getExerciseId(),
                exerciseContent.getFilename(),
                exerciseContent.getContent()
        ));
        System.out.format("Created %s %s\n", contentType, newExerciseContent);
        return newExerciseContent;
    }

    @Override
    public List<PublicTest> getByExerciseId(long exerciseId) {
        List<PublicTest> exerciseContents = new ArrayList<>(repository.findPublicTestsByExerciseId(exerciseId));
        System.out.format("Found %s from exercise %s: %s\n", contentType, exerciseId, exerciseContents);
        return exerciseContents;
    }

    @Override
    public boolean update(long id, ExerciseContent exerciseContent) {
        Optional<PublicTest> optional = repository.findById(id);
        if (!optional.isPresent()) {
            System.out.format("Failed to %s with id %s\n", contentType, id);
            return false;
        }
        PublicTest updatedExerciseContent = optional.get();
        updatedExerciseContent.setFilename(exerciseContent.getFilename());
        updatedExerciseContent.setExerciseId(exerciseContent.getExerciseId());
        updatedExerciseContent.setContent(exerciseContent.getContent());
        repository.save(updatedExerciseContent);
        System.out.format("Updated %s with id %s\n", contentType, id);
        return true;
    }

    @Override
    public void deleteByExerciseId(long exerciseId) {
        List<PublicTest> privateFiles = repository.findPublicTestsByExerciseId(exerciseId);
        privateFiles.forEach(privateFile -> repository.delete(privateFile));
        System.out.format("Deleted %ss with exercise id %s\n", contentType, exerciseId);
    }
}
