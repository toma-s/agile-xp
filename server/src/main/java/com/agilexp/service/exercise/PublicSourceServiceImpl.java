package com.agilexp.service.exercise;

import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.exercise.PublicSource;
import com.agilexp.repository.exercise.PublicSourceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class PublicSourceServiceImpl implements ExerciseContentService {

    @Autowired
    private PublicSourceRepository repository;

    private final String contentType = "public source";

    @Override
    public PublicSource create(ExerciseContent exerciseContent) {
        PublicSource newExerciseContent = repository.save(new PublicSource(
                exerciseContent.getExerciseId(),
                exerciseContent.getFilename(),
                exerciseContent.getContent()
        ));
        System.out.format("Created %s %s\n", contentType, newExerciseContent);
        return newExerciseContent;
    }

    @Override
    public List<PublicSource> getByExerciseId(long exerciseId) {
        List<PublicSource> exerciseContents = new ArrayList<>(repository.findPublicSourcesByExerciseId(exerciseId));
        System.out.format("Found %s from exercise %s: %s\n", contentType, exerciseId, exerciseContents);
        return exerciseContents;
    }

    @Override
    public boolean update(long id, ExerciseContent exerciseContent) {
        Optional<PublicSource> optional = repository.findById(id);
        if (!optional.isPresent()) {
            System.out.format("Failed to %s with id %s\n", contentType, id);
            return false;
        }
        PublicSource updatedExerciseContent = optional.get();
        updatedExerciseContent.setFilename(exerciseContent.getFilename());
        updatedExerciseContent.setExerciseId(exerciseContent.getExerciseId());
        updatedExerciseContent.setContent(exerciseContent.getContent());
        repository.save(updatedExerciseContent);
        System.out.format("Updated %s with id %s\n", contentType, id);
        return true;
    }

    @Override
    public void deleteByExerciseId(long exerciseId) {
        List<PublicSource> privateFiles = repository.findPublicSourcesByExerciseId(exerciseId);
        privateFiles.forEach(privateFile -> repository.delete(privateFile));
        System.out.format("Deleted %ss with exercise id %s\n", contentType, exerciseId);
    }
}
