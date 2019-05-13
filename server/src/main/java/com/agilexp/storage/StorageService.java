package com.agilexp.storage;

import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.dbmodel.solution.SolutionContent;
import org.springframework.core.io.Resource;

import java.nio.file.Path;
import java.util.List;
import java.util.stream.Stream;

public interface StorageService {

    void init();

    void store(SolutionContent solutionContent, String directoryName, String parentDirectoryName);

    void store(ExerciseContent exerciseContent, String directoryName, String parentDirectoryName);

    void store(int number, String fileName, String directoryName);

    Stream<Path> loadAll();

    Path load(String filename);

    Resource loadAsResource(String filename);

    void deleteAll();

    void clear(String directoryName);

    void copy(String sourceDirectoryName, String destinationDirectoryName);
}