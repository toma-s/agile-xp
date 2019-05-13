package com.agilexp.storage;

import java.awt.print.Pageable;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.*;
import java.util.stream.Stream;

import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.dbmodel.solution.SolutionContent;
import com.agilexp.model.exercise.ExerciseFlags;
import jnr.ffi.annotations.In;
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
        // TODO: 10-May-19 refactor (duplicity)
        String filename = solutionContent.getFilename();
        String code = solutionContent.getContent();

        createFolder(parentDirectoryName, null);
        Path directoryLocation = createFolder(directoryName, parentDirectoryName);
        storeSourceCode(filename, code, directoryLocation);
    }

    @Override
    public void store(ExerciseContent exerciseContent, String directoryName, String parentDirectoryName) {
        String filename = exerciseContent.getFilename();
        String code = exerciseContent.getContent();

        createFolder(parentDirectoryName, null);
        Path directoryLocation = createFolder(directoryName, parentDirectoryName);
        storeSourceCode(filename, code, directoryLocation);
    }

    @Override
    public void store(int number, String fileName, String parentDirectoryName) {
        createFolder(parentDirectoryName, null);
        Path directoryLocation = createFolder(fileName, parentDirectoryName);
        storeNumber(fileName, number, directoryLocation);
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
                throw new StorageFileNotFoundException(
                        "Could not read file: " + filename);

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
                boolean mkdir = destinationDirectory.mkdir();
                if (!mkdir) {
                    throw new StorageException("Failed to copy estimation files: " +
                            "failed to create destination directory");
                }
            }
            String[] files = sourceDirectory.list();
            if (files == null) {
                throw new StorageException("Failed to copy estimation files: " +
                        "listing the source folder files returned null");
            }
            for (String file : files) {
                File srcFile = new File(sourceDirectory, file);
                File destFile = new File(destinationDirectory, file);
                copyRecursively(srcFile, destFile);
            }
        } else {
            try {
                Files.copy(sourceDirectory.toPath(), destinationDirectory.toPath(), StandardCopyOption.REPLACE_EXISTING);
            } catch (IOException e) {
                throw new StorageException("Failed to copy estimation files: " + e.getMessage());
            }
        }
    }

    @Override
    public void clear(String directoryName) {
        System.out.println(directoryName);
        System.out.println("EXISTS: " + load(directoryName).toFile().exists());
        boolean deleted = FileSystemUtils.deleteRecursively(load(directoryName).toFile());
        System.out.println("DELETED: " + deleted);
    }
}
