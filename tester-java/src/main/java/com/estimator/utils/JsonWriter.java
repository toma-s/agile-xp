package com.estimator.utils;

import com.estimator.estimation.Estimation;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.nio.file.Path;
import java.nio.file.Paths;

public class JsonWriter {

    public static void write(Estimation estimation) {
        Path dirPath = Paths.get("estimation");
        dirPath.toFile().mkdir();
        Path filePath = dirPath.resolve("estimation.json");
        try {
            Writer fileWriter = new FileWriter(filePath.toFile());
            Gson gson = new GsonBuilder().create();
            gson.toJson(estimation, fileWriter);
            fileWriter.flush();
            fileWriter.close();
            System.out.println("file exists: " + filePath.toFile().exists());
        } catch (IOException e) {
            e.printStackTrace();
            // TODO: 10-May-19 handle
        }

    }
}
