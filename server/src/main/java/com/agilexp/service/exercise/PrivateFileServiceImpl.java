package com.agilexp.service.exercise;

import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.repository.exercise.PrivateFileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class PrivateFileServiceImpl implements ExerciseContentService {

    @Autowired
    private PrivateFileRepository repository;

    private final String contentType = "private file";

    @Override
    public PrivateFile create(ExerciseContent exerciseContent) {
        PrivateFile newExerciseContent = repository.save(new PrivateFile(
                exerciseContent.getExerciseId(),
                exerciseContent.getFilename(),
                exerciseContent.getContent()
        ));
        System.out.format("Created %s %s\n", contentType, newExerciseContent);
        return newExerciseContent;
    }

    @Override
    public List<PrivateFile> getByExerciseId(long exerciseId) {
        List<PrivateFile> exerciseContents = new ArrayList<>(repository.findPrivateFilesByExerciseId(exerciseId));
        System.out.format("Found %s from exercise %s: %s\n", contentType, exerciseId, exerciseContents);
        return exerciseContents;
    }

    @Override
    public boolean update(long id, ExerciseContent exerciseContent) {
        Optional<PrivateFile> optional = repository.findById(id);
        if (!optional.isPresent()) {
            System.out.format("Failed to %s with id %s\n", contentType, id);
            return false;
        }
        PrivateFile updatedExerciseContent = optional.get();
        updatedExerciseContent.setFilename(exerciseContent.getFilename());
        updatedExerciseContent.setExerciseId(exerciseContent.getExerciseId());
        updatedExerciseContent.setContent(exerciseContent.getContent());
        repository.save(updatedExerciseContent);
        System.out.format("Updated %s with id %s\n", contentType, id);
        return true;
    }

    @Override
    public void deleteByExerciseId(long exerciseId) {
        List<PrivateFile> privateFiles = repository.findPrivateFilesByExerciseId(exerciseId);
        privateFiles.forEach(privateFile -> repository.delete(privateFile));
        System.out.format("Deleted %ss with exercise id %s\n", contentType, exerciseId);
    }
}
