package com.agilexp.storage;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.*;
import java.util.stream.Stream;

import com.agilexp.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;

@Service
public class FileSystemStorageService implements StorageService {

    private final Path rootLocation;

    @Autowired
    public FileSystemStorageService(StorageProperties properties) {
        this.rootLocation = Paths.get(properties.getLocation());
    }

    @Override
    public void store(TaskContent taskContent, Long id) {
        String sourceFilename = taskContent.getSourceFilename();
        String testFilename = taskContent.getTestFilename();
        String taskDirectoryName = "task" + id;
        Path directoryLocation;

        createFolder(taskDirectoryName);
        directoryLocation = this.rootLocation.resolve(taskDirectoryName);

        try {
            if (taskContent.getSourceFilename().isEmpty() || taskContent.getTestFilename().isEmpty()) {
                throw new StorageException("Failed to store files with empty names");
            }
            if (taskContent.getSourceCode().isEmpty() || taskContent.getTestCode().isEmpty()) {
                throw new StorageException("Failed to store empty files");
            }
            Files.write(directoryLocation.resolve(sourceFilename), taskContent.getSourceCode().getBytes(), StandardOpenOption.CREATE);
            Files.write(directoryLocation.resolve(testFilename), taskContent.getTestCode().getBytes(), StandardOpenOption.CREATE);
        }
        catch (IOException e) {
            throw new StorageException("Failed to store files", e);
        }
    }

    @Override
    public void store(SolutionSource solutionSource) {
        String fileName = solutionSource.getFileName();
        String code = solutionSource.getContent();
        String directoryName = "solution_source" + solutionSource.getId();

        Path directoryLocation = createFolder(directoryName);
        storeSourceCode(fileName, code, directoryLocation);
    }

    @Override
    public void store(SolutionTest solutionTest) {
        String fileName = solutionTest.getFileName();
        String code = solutionTest.getContent();
        String directoryName = "solution_test" + solutionTest.getId();

        Path directoryLocation = createFolder(directoryName);
        storeSourceCode(fileName, code, directoryLocation);
    }

    @Override
    public void store(ExerciseTest exerciseTest) {
        String fileName = exerciseTest.getFileName();
        String code = exerciseTest.getContent();
        String directoryName = "exercise_test" + exerciseTest.getId();

        Path directoryLocation = createFolder(directoryName);
        storeSourceCode(fileName, code, directoryLocation);
    }

    @Override
    public void store(SolutionFile solutionConfig) {
        String fileName = solutionConfig.getFileName();
        String code = solutionConfig.getContent();

        Path directoryLocation = createFolder("game_config");
        storeFile(fileName, code, directoryLocation);
    }

    private Path createFolder(String directoryName) {
        if (Paths.get(this.rootLocation.toString(), directoryName).toFile().isDirectory()) {
            return this.rootLocation.resolve(directoryName);
        }

        Path directoryLocation;
        try {
            Files.createDirectory(Paths.get(this.rootLocation.resolve(directoryName).toString()));
            directoryLocation = this.rootLocation.resolve(directoryName);
        } catch (IOException e) {
            throw new StorageException("Failed to create folder for task");
        }
        return directoryLocation;
    }

    private void storeSourceCode(String fileName, String code, Path directoryLocation) throws StorageException {
        try {
            if (fileName.isEmpty()) {
                throw new StorageException("Failed to store file with empty name");
            }
            if (code.isEmpty()) {
                throw new StorageException("Failed to store empty file");
            }
            Files.write(directoryLocation.resolve(fileName), code.getBytes(), StandardOpenOption.CREATE);
        }
        catch (IOException e) {
            throw new StorageException("Failed to store file", e);
        }
    }

    private void storeFile(String fileName, String text, Path directoryLocation) {
        try {
            if (fileName.isEmpty()) {
                throw new StorageException("Failed to store file with empty name");
            }
            Files.write(directoryLocation.resolve(fileName), text.getBytes(), StandardOpenOption.CREATE);
        }
        catch (IOException e) {
            throw new StorageException("Failed to store file", e);
        }
    }

    @Override
    public Stream<Path> loadAll() {
        try {
            return Files.walk(this.rootLocation, 1)
                    .filter(path -> !path.equals(this.rootLocation))
                    .map(this.rootLocation::relativize);
        }
        catch (IOException e) {
            throw new StorageException("Failed to read stored files", e);
        }

    }

    @Override
    public Path load(String filename) {
        return rootLocation.resolve(filename);
    }

    @Override
    public Resource loadAsResource(String filename) {
        try {
            Path file = load(filename);
            Resource resource = new UrlResource(file.toUri());
            if (resource.exists() || resource.isReadable()) {
                return resource;
            }
            else {
                throw new StorageFileNotFoundException(
                        "Could not read file: " + filename);

            }
        }
        catch (MalformedURLException e) {
            throw new StorageFileNotFoundException("Could not read file: " + filename, e);
        }
    }

    @Override
    public void deleteAll() {
        FileSystemUtils.deleteRecursively(rootLocation.toFile());
    }

    @Override
    public void init() {
        try {
            Files.createDirectories(rootLocation);
        }
        catch (IOException e) {
            throw new StorageException("Could not initialize storage", e);
        }
    }
}
