package com.agilexp.storage;

import com.agilexp.model.SourceCode;
import com.agilexp.model.TaskContent;
import org.springframework.core.io.Resource;

import java.nio.file.Path;
import java.util.stream.Stream;

public interface StorageService {

    void init();

    void store(TaskContent taskContent, Long id);

    void store(SourceCode sourceCode);

    Stream<Path> loadAll();

    Path load(String filename);

    Resource loadAsResource(String filename);

    void deleteAll();

}