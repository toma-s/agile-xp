package com.agilexp.storage;

import com.agilexp.model.ExerciseSource;
import com.agilexp.model.ExerciseTest;
import com.agilexp.model.TaskContent;
import org.springframework.core.io.Resource;

import java.nio.file.Path;
import java.util.stream.Stream;

public interface StorageService {

    void init();

    void store(TaskContent taskContent, Long id);

    void store(ExerciseSource sourceCode);

    void store(ExerciseTest hiddenTest);

    Stream<Path> loadAll();

    Path load(String filename);

    Resource loadAsResource(String filename);

    void deleteAll();

}