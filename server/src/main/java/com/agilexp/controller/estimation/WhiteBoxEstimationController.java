package com.agilexp.controller.estimation;

import com.agilexp.docker.DockerController;
import com.agilexp.dbmodel.estimation.Estimation;
import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.dbmodel.exercise.PrivateTest;
import com.agilexp.docker.DockerControllerException;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.model.estimation.WhiteBoxEstimation;
import com.agilexp.repository.exercise.PrivateFileRepository;
import com.agilexp.repository.exercise.PrivateTestRepository;
import com.agilexp.repository.solution.SolutionEstimationRepository;
import com.agilexp.storage.StorageException;
import com.agilexp.storage.StorageService;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class WhiteBoxEstimationController {

    private final StorageService storageService;

    private final SolutionEstimationRepository repository;
    private final PrivateTestRepository privateTestRepository;
    private final PrivateFileRepository privateFileRepository;

    @Autowired
    public WhiteBoxEstimationController(StorageService storageService, SolutionEstimationRepository repository, PrivateTestRepository privateTestRepository, PrivateFileRepository privateFileRepository) {
        this.storageService = storageService;
        this.repository = repository;
        this.privateTestRepository = privateTestRepository;
        this.privateFileRepository = privateFileRepository;
    }

    @PostMapping(value = "/solution-estimation/estimate/whitebox-file")
    public Estimation getWhiteBoxFileEstimation(@RequestBody SolutionItems solutionItems) {
        WhiteBoxEstimation publicEstimation = getPublicEstimation(solutionItems);
        WhiteBoxEstimation privateEstimation = getPrivateEstimation(solutionItems);
        Estimation estimation = getEstimation(solutionItems.getSolutionId(), publicEstimation, privateEstimation);
        System.out.println(estimation);

        Estimation _solutionEstimation = repository.save(estimation);
        System.out.format("Created solution estimation %s\n", _solutionEstimation);
        return _solutionEstimation;
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

    private void storePublicFiles(SolutionItems solutionItems, String directoryName) {
        try {
            solutionItems.getSolutionSources().forEach(solutionSource ->
                    storageService.store(solutionSource, "sources", directoryName));

            solutionItems.getSolutionTests().forEach(solutionTest ->
                    storageService.store(solutionTest, "tests", directoryName));

            solutionItems.getSolutionFiles().forEach(solutionFile ->
                    storageService.store(solutionFile, "files", directoryName));

            copyEstimationFiles(directoryName);
        } catch (StorageException e) {
            throw new StorageException("Storage Exception occurred on storing public files" +
                    e.getMessage());
        }
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

    private void storePrivateFiles(SolutionItems solutionItems, String directoryName) {
        solutionItems.getSolutionSources().forEach(solutionSource ->
                storageService.store(solutionSource, "sources", directoryName));

        long exerciseId = solutionItems.getExerciseId();
        List<PrivateTest> privateTests = privateTestRepository.findPrivateTestsByExerciseId(exerciseId);
        privateTests.forEach(privateTest -> storageService.store(privateTest, "tests", directoryName));

        List<PrivateFile> privateFiles = privateFileRepository.findPrivateFilesByExerciseId(exerciseId);
        privateFiles.forEach(privateFile -> storageService.store(privateFile, "files", directoryName));

        copyEstimationFiles(directoryName);
    }

    private void copyEstimationFiles(String destDirectoryName) {
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

    private String executeEstimation(String directoryName) throws DockerControllerException {
        String containerId = createDockerContainer(directoryName);
        String command = "java -jar estimator-java-1.0.jar whitebox-file";
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
