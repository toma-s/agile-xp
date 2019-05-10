package com.agilexp.controller.estimation;

import com.agilexp.dbmodel.estimation.Estimation;
import com.agilexp.docker.DockerController;
import com.agilexp.docker.DockerControllerException;
import com.agilexp.model.estimation.WhiteBoxEstimation;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.storage.StorageException;
import com.agilexp.storage.StorageService;
import com.google.gson.Gson;
import org.springframework.web.bind.annotation.RequestBody;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.util.Date;

abstract public class Super {

    final StorageService storageService;

    public Super(StorageService storageService) {
        this.storageService = storageService;
    }

    Estimation getWhiteBoxEstimation(@RequestBody SolutionItems solutionItems) {
        WhiteBoxEstimation publicEstimation = getPublicEstimation(solutionItems);
        WhiteBoxEstimation privateEstimation = getPrivateEstimation(solutionItems);
        return getEstimation(solutionItems.getSolutionId(), publicEstimation, privateEstimation);
    }

    private WhiteBoxEstimation getPublicEstimation(SolutionItems solutionItems) {
        try {
            String solutionId = String.valueOf(solutionItems.getSolutionId());
            String directoryName = "public" + solutionId;
            storePublicFiles(solutionItems, directoryName);
            String output = executeEstimation(directoryName);
            System.out.println(output);
            Gson gson = new Gson();
            return gson.fromJson(output, WhiteBoxEstimation.class);
        } catch (StorageException | DockerControllerException e) {
            WhiteBoxEstimation estimation = new WhiteBoxEstimation();
            estimation.setErrorMessage(String.format("Public estimation failed:\n%s", e.getMessage()));
            return estimation;
        }
    }

    abstract void storePublicFiles(SolutionItems solutionItems, String directoryName);

    abstract String executeEstimation(String directoryName) throws DockerControllerException;

    String executeEstimationByMode(String directoryName, String mode) throws DockerControllerException {
        String containerId = createDockerContainer(directoryName);
        String command = "java -jar estimator-java-1.0.jar " + mode;
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


    private WhiteBoxEstimation getPrivateEstimation(SolutionItems solutionItems) {
        try {
            String solutionId = String.valueOf(solutionItems.getSolutionId());
            String directoryName = "private" + solutionId;
            storePrivateFiles(solutionItems, directoryName);
            String output = executeEstimation(directoryName);
            System.out.println(output);
            Gson gson = new Gson();
            return gson.fromJson(output, WhiteBoxEstimation.class);
        } catch (StorageException | DockerControllerException e) {
            WhiteBoxEstimation estimation = new WhiteBoxEstimation();
            estimation.setErrorMessage(String.format("Private estimation failed:\n%s", e.getMessage()));
            return estimation;
        }
    }

    abstract void storePrivateFiles(SolutionItems solutionItems, String directoryName);


    void copyEstimationFiles(String destDirectoryName) {
        File sourceFolder = new File("docker");
        File destinationFolder = storageService.load(destDirectoryName).toFile();
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


    private Estimation getEstimation(long solutionId, WhiteBoxEstimation publicEstimation, WhiteBoxEstimation privateEstimation) {
        Estimation estimation = new Estimation();
        Date date = new Date();
        estimation.setCreated(new Timestamp(date.getTime()));
        estimation.setSolutionId(solutionId);

        if (!publicEstimation.getErrorMessage().isEmpty()) {
            estimation.setSolved(false);
            estimation.setEstimation(publicEstimation.getErrorMessage());
            return estimation;
        }

        if (!privateEstimation.getErrorMessage().isEmpty()) {
            estimation.setSolved(false);
            estimation.setEstimation(privateEstimation.getErrorMessage());
            return estimation;
        }

        estimation.setSolved(publicEstimation.isSolved() && privateEstimation.isSolved());
        estimation.setEstimation(getEstimationContent(publicEstimation, privateEstimation));
        estimation.setValue(privateEstimation.getValue());

        return estimation;
    }

    private String getEstimationContent(WhiteBoxEstimation publicWBEstimation, WhiteBoxEstimation privateWBEstimation) {
        String publicEstimationContent = getEstimationContent(publicWBEstimation, "Public");
        String privateEstimationContent = getEstimationContent(privateWBEstimation, "Private");
        return String.format("Progress: %s%%\n\n" +
                        "%s%s",
                privateWBEstimation.getValue(),
                publicEstimationContent,
                privateEstimationContent
        );
    }

    private String getEstimationContent(WhiteBoxEstimation estimation, String type) {
        return String.format("%s estimation result:\n" +
                        "\n" +
                        "Compilation result:\n" +
                        "Compiled successfully: %s\n" +
                        "%s\n" +
                        "Tests result:\n" +
                        "Tested successfully: %s\n" +
                        "%s\n",
                type,
                estimation.isCompiled(),
                estimation.getCompilationResult(),
                estimation.isTested(),
                estimation.getTestsResult()
        );
    }

}
