package com.agilexp.storage;

import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.solution.SolutionContent;
import org.springframework.core.io.Resource;

import java.nio.file.Path;
import java.util.stream.Stream;

public interface StorageService {

    void init();

    void store(SolutionContent solutionContent, String directoryName, String created);

    void store(ExerciseContent exerciseContent, String created);

    Stream<Path> loadAll();

    Path load(String filename);

    Resource loadAsResource(String filename);

    void deleteAll();

}