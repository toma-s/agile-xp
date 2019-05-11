package com.estimator.utils;

import com.estimator.estimation.Estimation;
import com.estimator.utils.exception.FilesUtilsException;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

public class FilesUtils {

    public static void prepareDirectory(File directory) throws FilesUtilsException {
        if (directory.exists()) {
            FilesUtils.clearDirectory(directory);
        } else {
            FilesUtils.createDirectory(directory);
        }
    }

    private static void createDirectory(File directory) throws FilesUtilsException {
        boolean mkdir = directory.mkdir();
        if (!mkdir) {
            String message = "Failed to create directory" + directory.getName();
            throw new FilesUtilsException(message);
        }
    }

    private static void clearDirectory(File directory) throws FilesUtilsException {
        File[] files = listFiles(directory);
        for(File f: files) {
            if(f.isDirectory()) {
                clearDirectory(f);
            } else {
                deleteFile(f);
            }
        }
    }

    private static void deleteFile(File file) throws FilesUtilsException {
        boolean delete = file.delete();
        if (!delete) {
            String message = "Failed to delete directory" + file.getName();
            throw new FilesUtilsException(message);
        }
    }

    public static File[] listFiles(File directory) throws FilesUtilsException {
        File[] files = directory.listFiles();
        if(files == null) {
            String message = "Failed to list files in directory " + directory.getName();
            throw new FilesUtilsException(message);
        }
        return files;
    }

    public static void copyFileContent(Path source, Path destination) throws FilesUtilsException {
        try {
            Files.copy(source, destination, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            throw new FilesUtilsException("Failed to copy " + source + " file content to file " + destination + ": " + e.getMessage());
        }
    }

    public static void createFile(File file) throws FilesUtilsException {
        try {
            boolean created = file.createNewFile();
            if (!created) {
                throw new FilesUtilsException("Failed to create file " + file.getName());
            }
        } catch (IOException e) {
            throw new FilesUtilsException("Failed to create file " + file.getName() + ": " + e.getMessage());
        }
    }

    static void writeGsonEstimationToFile(Estimation estimation, Path filePath) throws FilesUtilsException {
        try {
            Writer fileWriter = new FileWriter(filePath.toFile());
            Gson gson = new GsonBuilder().create();
            gson.toJson(estimation, fileWriter);
            fileWriter.flush();
            fileWriter.close();
        } catch (IOException e) {
            throw new FilesUtilsException("Failed to write gson estimation to file " + filePath + ": " + e.getMessage());
        }
    }
}
