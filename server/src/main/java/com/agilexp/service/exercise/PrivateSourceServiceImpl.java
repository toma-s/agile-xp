package com.agilexp.service.exercise;

import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.exercise.PrivateSource;
import com.agilexp.repository.exercise.PrivateSourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class PrivateSourceServiceImpl implements ExerciseContentService {

    @Autowired
    private PrivateSourceRepository repository;

    private final String contentType = "private source";

    @Override
    public PrivateSource create(ExerciseContent exerciseContent) {
        PrivateSource newExerciseContent = repository.save(new PrivateSource(
                exerciseContent.getExerciseId(),
                exerciseContent.getFilename(),
                exerciseContent.getContent()
        ));
        System.out.format("Created %s %s%n", contentType, newExerciseContent);
        return newExerciseContent;
    }

    @Override
    public List<PrivateSource> getByExerciseId(long exerciseId) {
        List<PrivateSource> exerciseContents = new ArrayList<>(repository.findPrivateSourcesByExerciseId(exerciseId));
        System.out.format("Found %s from exercise %s: %s%n", contentType, exerciseId, exerciseContents);
        return exerciseContents;
    }

    @Override
    public boolean update(long id, ExerciseContent exerciseContent) {
        Optional<PrivateSource> optional = repository.findById(id);
        if (!optional.isPresent()) {
            System.out.format("Failed to %s with id %s%n", contentType, id);
            return false;
        }
        PrivateSource updatedExerciseContent = optional.get();
        updatedExerciseContent.setFilename(exerciseContent.getFilename());
        updatedExerciseContent.setExerciseId(exerciseContent.getExerciseId());
        updatedExerciseContent.setContent(exerciseContent.getContent());
        repository.save(updatedExerciseContent);
        System.out.format("Updated %s with id %s%n", contentType, id);
        return true;
    }

    @Override
    public void deleteByExerciseId(long exerciseId) {
        List<PrivateSource> privateFiles = repository.findPrivateSourcesByExerciseId(exerciseId);
        privateFiles.forEach(privateFile -> repository.delete(privateFile));
        System.out.format("Deleted %ss with exercise id %s%n", contentType, exerciseId);
    }
}
