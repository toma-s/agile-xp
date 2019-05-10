package com.agilexp.storage;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.*;
import java.util.stream.Stream;

import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.dbmodel.solution.SolutionContent;
import com.agilexp.model.exercise.ExerciseFlags;
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
    public void store(SolutionContent solutionContent, String directoryName, String created) {
        String filename = solutionContent.getFilename();
        String code = solutionContent.getContent();

        createFolder(created, null);
        Path directoryLocation = createFolder(directoryName, created);
        storeSourceCode(filename, code, directoryLocation);
    }

    @Override
    public void store(ExerciseContent exerciseContent, String directoryName, String created) {
        String filename = exerciseContent.getFilename();
        String code = exerciseContent.getContent();

        createFolder(created, null);
        Path directoryLocation = createFolder(directoryName, created);
        storeSourceCode(filename, code, directoryLocation);
    }

    private Path createFolder(String directoryName, String created) {

        // TODO: 10-May-19 refactor
        Path directoryLocation;
        try {
            if (created != null) {
                if (Paths.get(this.rootLocation.resolve(created).toString(), directoryName).toFile().isDirectory()) {
                    return this.rootLocation.resolve(created).resolve(directoryName);
                }
                Files.createDirectory(Paths.get(this.rootLocation.resolve(created).resolve(directoryName).toString()));
                directoryLocation = this.rootLocation.resolve(created).resolve(directoryName);
            } else {
                if (Paths.get(this.rootLocation.toString(), directoryName).toFile().isDirectory()) {
                    return this.rootLocation.resolve(directoryName);
                }
                Files.createDirectory(Paths.get(this.rootLocation.resolve(directoryName).toString()));
                directoryLocation = this.rootLocation.resolve(directoryName);
            }

        } catch (IOException e) {
            throw new StorageException("Failed to create folder for task");
        }
        return directoryLocation;
    }

    private void storeSourceCode(String filename, String code, Path directoryLocation) throws StorageException {
        try {
            if (filename.isEmpty()) {
                throw new StorageException("Failed to store file with empty name");
            }
            Files.write(directoryLocation.resolve(filename), code.getBytes(), StandardOpenOption.CREATE);
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
