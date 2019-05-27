package com.agilexp.storage;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.*;
import java.util.stream.Stream;

import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.solution.SolutionContent;
import com.agilexp.storage.exception.StorageException;
import com.agilexp.storage.exception.StorageFileNotFoundException;
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
    public void store(SolutionContent solutionContent, String directoryName, String parentDirectoryName) {
        String filename = solutionContent.getFilename();
        String code = solutionContent.getContent();

        createFolder(parentDirectoryName);
        Path directoryLocation = createFolder(directoryName, parentDirectoryName);
        storeSourceCode(filename, code, directoryLocation);
    }

    @Override
    public void store(ExerciseContent exerciseContent, String directoryName, String parentDirectoryName) {
        String filename = exerciseContent.getFilename();
        String code = exerciseContent.getContent();

        createFolder(parentDirectoryName);
        Path directoryLocation = createFolder(directoryName, parentDirectoryName);
        storeSourceCode(filename, code, directoryLocation);
    }

    @Override
    public void store(int number, String fileName, String parentDirectoryName) {
        createFolder(parentDirectoryName);
        Path directoryLocation = createFolder(fileName, parentDirectoryName);
        storeNumber(fileName, number, directoryLocation);
    }

    private Path createFolder(String directoryName, String parentDirectoryName) {
        try {
            Path directory = this.rootLocation.resolve(parentDirectoryName).resolve(directoryName);
            if (directory.toFile().isDirectory()) {
                return directory;
            }
            Files.createDirectory(directory);
            return directory;
        } catch (IOException e) {
            throw new StorageException("Failed to create folder for task");
        }
    }

    private void createFolder(String directoryName) {
        try {
            Path directory = this.rootLocation.resolve(directoryName);
            if (directory.toFile().isDirectory()) {
                return;
            }
            Files.createDirectory(directory);
            this.rootLocation.resolve(directoryName);
        } catch (IOException e) {
            throw new StorageException("Failed to create folder for task");
        }
    }

    private void storeSourceCode(String filename, String code, Path directoryLocation) throws StorageException {
        try {
            if (filename.isEmpty()) {
                throw new StorageException("Failed to store file with empty name");
            }
            Files.write(directoryLocation.resolve(filename),
                    code.getBytes(),
                    StandardOpenOption.CREATE);
        } catch (IOException e) {
            throw new StorageException("Failed to store file", e);
        }
    }

    private void storeNumber(String filename, int number, Path directoryLocation) {
        try {
            if (filename.isEmpty()) {
                throw new StorageException("Failed to store file with empty name");
            }
            Files.write(directoryLocation.resolve(filename),
                    String.valueOf(number).getBytes(),
                    StandardOpenOption.CREATE);
        } catch (IOException e) {
                throw new StorageException("Failed to store file", e);
            }
    }

    @Override
    public Stream<Path> loadAll() {
        try {
            return Files.walk(this.rootLocation, 1)
                    .filter(path -> !path.equals(this.rootLocation))
                    .map(this.rootLocation::relativize);
        } catch (IOException e) {
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
                throw new StorageFileNotFoundException("Could not read file: " + filename);
            }
        } catch (MalformedURLException e) {
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
        } catch (IOException e) {
            throw new StorageException("Could not initialize storage", e);
        }
    }

    public void copy(String sourceDirectoryName, String destinationDirectoryName) {
        File sourceFolder = new File(sourceDirectoryName);
        File destinationFolder = this.load(destinationDirectoryName).toFile();
        copyRecursively(sourceFolder, destinationFolder);
    }

    private void copyRecursively(File sourceDirectory, File destinationDirectory) {
        if (sourceDirectory.isDirectory()) {
            if (!destinationDirectory.exists()) {
                createDirectory(destinationDirectory);
            }
            String[] files = listFiles(sourceDirectory);
            for (String file : files) {
                File srcFile = new File(sourceDirectory, file);
                File destFile = new File(destinationDirectory, file);
                copyRecursively(srcFile, destFile);
            }
        } else {
            copy(sourceDirectory, destinationDirectory);
        }
    }

    private void createDirectory(File directory) {
        boolean mkdir = directory.mkdir();
        if (!mkdir) {
            throw new StorageException("Failed to copy estimation files: " + "failed to create destination directory");
        }
    }

    private String[] listFiles(File directory) {
        String[] files = directory.list();
        if (files == null) {
            throw new StorageException("Failed to copy estimation files: " +
                    "listing the source folder files returned null");
        }
        return files;
    }

    private void copy(File sourceDirectory, File destinationDirectory) {
        try {
            Files.copy(sourceDirectory.toPath(), destinationDirectory.toPath(), StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            throw new StorageException("Failed to copy estimation files: " + e.getMessage());
        }
    }

    @Override
    public void clear(String directoryName) {
        FileSystemUtils.deleteRecursively(load(directoryName).toFile());
    }
}
