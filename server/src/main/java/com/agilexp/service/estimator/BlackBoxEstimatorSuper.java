package com.agilexp.service.estimator;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import com.agilexp.docker.DockerController;
import com.agilexp.docker.DockerControllerException;
import com.agilexp.model.estimation.Estimation;
import com.agilexp.model.exercise.ExerciseFlags;
import com.agilexp.model.exercise.ExerciseSwitcher;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.storage.StorageService;
import com.agilexp.storage.exception.StorageException;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public abstract class BlackBoxEstimatorSuper {

    @Autowired
    private StorageService storageService;

    Estimation getBlackBoxEstimation(SolutionItems solutionItems) {
        try {
            String directoryName = String.valueOf(solutionItems.getSolutionId());
            storeFiles(solutionItems, directoryName);
            String output = executeEstimation(directoryName);
            System.out.println(output);
            Gson gson = new Gson();
            Estimation estimation = gson.fromJson(output, Estimation.class);
            removeTempFiles(solutionItems);
            return estimation;
        } catch (StorageException | DockerControllerException e) {
            Estimation estimation = new Estimation();
            estimation.setErrorMessage(String.format("Public estimation failed:%n%s", e.getMessage()));
            return estimation;
        }
    }

    abstract void storeFiles(SolutionItems solutionItems, String directoryName);

    List<ExerciseFlags> getExerciseFlags(int bugsNum) {
        List<ExerciseFlags> exerciseFlags = new ArrayList<>();
        for (int i = 0; i < bugsNum; i++) {
            String[] booleans = new String[bugsNum];
            Arrays.fill(booleans, "false");
            booleans[i] = "true";
            ExerciseFlags flags = new ExerciseFlags();
            String content = String.join("\n", booleans);
            content += "\n";
            flags.setContent(content);
            flags.setFilename("flags" + i + ".txt");
            exerciseFlags.add(flags);
        }
        return exerciseFlags;
    }

    ExerciseFlags getControllingFlags(int bugsNum) {
        String[] booleans = new String[bugsNum];
        Arrays.fill(booleans, "false");
        ExerciseFlags flags = new ExerciseFlags();
        String content = String.join("\n", booleans);
        content += "\n";
        flags.setContent(content);
        flags.setFilename("flags.txt");
        return flags;
    }

    ExerciseSwitcher getExerciseSwitcher() {
        try {
            ExerciseSwitcher switcher = new ExerciseSwitcher();
            Path switcherFilePath = Paths.get("assets/switcher/BlackBoxSwitcher.java");
            String switcherContent = new String(Files.readAllBytes(switcherFilePath), StandardCharsets.UTF_8);
            switcher.setContent(switcherContent);
            switcher.setFilename("BlackBoxSwitcher.java");
            return switcher;
        } catch (IOException e) {
            throw new StorageException("Storage Exception occurred on reading switcher content" + e.getMessage());
        }
    }

    private String executeEstimation(String directoryName) throws DockerControllerException {
        String containerId = createDockerContainer(directoryName);
        String command = "java -jar estimator-java-1.0.jar blackbox";
        DockerController.execStart(containerId, command);

        String estimationPath = "/usr/src/app/estimation/estimation.json";
        String estimation = DockerController.getFileContent(containerId, estimationPath);

        DockerController.cleanUp(containerId);

        return estimation;
    }

    private String createDockerContainer(String directoryName) throws DockerControllerException {
        Path dockerDirectoryPath = storageService.load(directoryName);
        String imageId = DockerController.buildImage(dockerDirectoryPath, directoryName);
        return DockerController.createContainer(imageId);
    }

    SolutionEstimation getEstimation(long solutionId, Estimation blackBoxEstimation) {
        SolutionEstimation estimation = new SolutionEstimation();
        Date date = new Date();
        estimation.setCreated(new Timestamp(date.getTime()));
        estimation.setSolutionId(solutionId);

        if (!blackBoxEstimation.getErrorMessage().isEmpty()) {
            estimation.setSolved(false);
            estimation.setEstimation(blackBoxEstimation.getErrorMessage());
            return estimation;
        }

        estimation.setSolved(blackBoxEstimation.isSolved());
        estimation.setEstimation(getEstimationContent(blackBoxEstimation));
        estimation.setValue(blackBoxEstimation.getValue());

        return estimation;
    }

    private String getEstimationContent(Estimation estimation) {
        return String.format("Progress: %s%%%n%n" +
                        "SolutionEstimation result:%n" +
                        "%n" +
                        "Compilation result:%n" +
                        "Compiled successfully: %s%n" +
                        "%s%n%n" +
                        "Tests result:%n" +
                        "Tested successfully: %s%n" +
                        "%s%n%n",
                estimation.getValue(),
                estimation.isCompiled(),
                estimation.getCompilationResult(),
                estimation.isTested(),
                estimation.getTestsResult()
        );
    }

    private void removeTempFiles(SolutionItems solutionItems) {
        String solutionId = String.valueOf(solutionItems.getSolutionId());
        storageService.clear(solutionId);
    }
}
