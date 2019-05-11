package com.agilexp.controller.estimation;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import com.agilexp.docker.DockerController;
import com.agilexp.docker.DockerControllerException;
import com.agilexp.model.estimation.Estimation;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.storage.StorageException;
import com.agilexp.storage.StorageService;
import com.google.gson.Gson;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.util.Date;

abstract public class WhiteBoxEstimationSuper {

    final StorageService storageService;

    private final String publicMode = "public";
    private final String privateMode = "private";

    public WhiteBoxEstimationSuper(StorageService storageService) {
        this.storageService = storageService;
    }

    SolutionEstimation getWhiteBoxEstimation(@RequestBody SolutionItems solutionItems) {
        Estimation publicEstimation = getPublicEstimation(solutionItems);
        Estimation privateEstimation = getPrivateEstimation(solutionItems);
        return getEstimation(solutionItems.getSolutionId(), publicEstimation, privateEstimation);
    }

    private Estimation getPublicEstimation(SolutionItems solutionItems) {
        try {
            String solutionId = String.valueOf(solutionItems.getSolutionId());
            String directoryName = publicMode + solutionId;
            storePublicFiles(solutionItems, directoryName);
            String output = executeEstimation(directoryName);
            System.out.println(output);
            Gson gson = new Gson();
            return gson.fromJson(output, Estimation.class);
        } catch (StorageException | DockerControllerException e) {
            Estimation estimation = new Estimation();
            estimation.setErrorMessage(String.format("Public estimation failed:\n%s", e.getMessage()));
            return estimation;
        }
    }

    abstract void storePublicFiles(SolutionItems solutionItems, String directoryName);

    private String executeEstimation(String directoryName) throws DockerControllerException {
        String containerId = createDockerContainer(directoryName);
        String command = "java -jar estimator-java-1.0.jar whitebox";
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


    private Estimation getPrivateEstimation(SolutionItems solutionItems) {
        try {
            String solutionId = String.valueOf(solutionItems.getSolutionId());
            String directoryName = privateMode + solutionId;
            storePrivateFiles(solutionItems, directoryName);
            String output = executeEstimation(directoryName);
            System.out.println(output);
            Gson gson = new Gson();
            return gson.fromJson(output, Estimation.class);
        } catch (StorageException | DockerControllerException e) {
            Estimation estimation = new Estimation();
            estimation.setErrorMessage(String.format("Private estimation failed:\n%s", e.getMessage()));
            return estimation;
        }
    }

    abstract void storePrivateFiles(SolutionItems solutionItems, String directoryName);


    void copyEstimationFiles(String destDirectoryName) {
        String dockerFolderFilename = "docker";
        File sourceFolder = new File(dockerFolderFilename);
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


    private SolutionEstimation getEstimation(long solutionId, Estimation publicEstimation, Estimation privateEstimation) {
        SolutionEstimation estimation = new SolutionEstimation();
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

    private String getEstimationContent(Estimation publicWBEstimation, Estimation privateWBEstimation) {
        String publicEstimationContent = getEstimationContent(publicWBEstimation, publicMode);
        String privateEstimationContent = getEstimationContent(privateWBEstimation, privateMode);
        return String.format("Progress: %s%%\n\n" +
                        "%s%s",
                privateWBEstimation.getValue(),
                publicEstimationContent,
                privateEstimationContent
        );
    }

    private String getEstimationContent(Estimation estimation, String mode) {
        return String.format("%s estimation result:\n" +
                        "\n" +
                        "Compilation result:\n" +
                        "Compiled successfully: %s\n" +
                        "%s\n" +
                        "Tests result:\n" +
                        "Tested successfully: %s\n" +
                        "%s\n",
                StringUtils.capitalize(mode),
                estimation.isCompiled(),
                estimation.getCompilationResult(),
                estimation.isTested(),
                estimation.getTestsResult()
        );
    }

}
