package com.estimator.utils;

import com.estimator.estimation.Estimation;
import com.estimator.utils.exception.FilesUtilsException;

import java.nio.file.Path;
import java.nio.file.Paths;

public class JsonWriter {

    public static void write(Estimation estimation) {
        try {
            Path estimationDirectory = Paths.get("estimation");
            FilesUtils.prepareDirectory(estimationDirectory.toFile());
            Path filePath = estimationDirectory.resolve("estimation.json");
            FilesUtils.writeGsonEstimationToFile(estimation, filePath);
        } catch (FilesUtilsException e) {
            e.printStackTrace();
        }

    }

}
