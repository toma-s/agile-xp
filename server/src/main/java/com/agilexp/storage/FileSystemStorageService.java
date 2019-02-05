package com.agilexp.storage;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.*;
import java.util.stream.Stream;

import com.agilexp.model.TaskContent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;

@Service
public class FileSystemStorageService implements StorageService {

    private final Path rootLocation;
    private final String extention = ".java";

    @Autowired
    public FileSystemStorageService(StorageProperties properties) {
        this.rootLocation = Paths.get(properties.getLocation());
    }

    @Override
    public void store(TaskContent taskContent) {
        String sourceFilename = taskContent.getSourceFilename() + extention;
        String testFilename = taskContent.getTestFilename() + extention;
        String taskDirectoryname = "task" + taskContent.getId();
        Path directoryLocation;

        try {
            Files.createDirectory(Paths.get(this.rootLocation.resolve(taskDirectoryname).toString()));
            directoryLocation = this.rootLocation.resolve(taskDirectoryname);
        } catch (IOException e) {
            throw new StorageException("Failed to create folder for task");
        }

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
