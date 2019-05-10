package com.agilexp.controller.solution;

import com.agilexp.DockerController;
import com.agilexp.dbmodel.solution.SolutionEstimation;
import com.agilexp.model.SolutionItems;
import com.agilexp.model.estimation.WhiteBoxEstimation;
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

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class WhiteBoxEstimationController {

    private final StorageService storageService;

    @Autowired
    public WhiteBoxEstimationController(StorageService storageService) {
        this.storageService = storageService;
    }

    @PostMapping(value = "/solution-estimation/estimate/whitebox-file")
    public SolutionEstimation getWhiteBoxFileEstimation(@RequestBody SolutionItems solutionItems) {
        SolutionEstimation solutionEstimation = new SolutionEstimation(solutionItems.getSolutionId());
        Date date = new Date();
        solutionEstimation.setCreated(new Timestamp(date.getTime()));

        storeFiles(solutionItems);
        String result = getEstimation(solutionItems);
        System.out.println(result);
        Gson gson = new Gson();
        WhiteBoxEstimation estimation = gson.fromJson(result, WhiteBoxEstimation.class);

        solutionEstimation.setSolved(estimation.isCompiled() && estimation.isTested());
        solutionEstimation.setEstimation(String.format("Compilation result: %s\nTests result: %s\n",
                estimation.getCompilationResult(),
                estimation.getTestsResult()));
        // TODO: 10-May-19 when estimation structure is fixed

        return solutionEstimation;
    }

    private void storeFiles(SolutionItems solutionItems) {
        String solutionId = String.valueOf(solutionItems.getSolutionId());
        solutionItems.getSolutionSources().forEach(solutionSource ->
                storageService.store(solutionSource, "sources", solutionId));
        solutionItems.getSolutionTests().forEach(solutionTest ->
                storageService.store(solutionTest, "tests", solutionId));
        solutionItems.getSolutionFiles().forEach(solutionFile ->
                storageService.store(solutionFile, "files", solutionId));

        copyEstimationFiles(solutionId);
    }

    private void copyEstimationFiles(String destDirectoryName) {
        try {
            File sourceFolder = new File("docker");
            File destinationFolder = storageService.load(destDirectoryName).toFile();
            copyRecursively(sourceFolder, destinationFolder);
        } catch (StorageException | IOException e) {
            throw new StorageException("Failed to copyEstimationFiles files");
        }
    }

    private static void copyRecursively(File sourceFolder, File destinationFolder) throws IOException {
        if (sourceFolder.isDirectory()) {
            if (!destinationFolder.exists()){
                destinationFolder.mkdir();
                // TODO: 10-May-19 handle
            }
            String[] files = sourceFolder.list();
            if (files != null) {
                for (String file : files)
                {
                    File srcFile = new File(sourceFolder, file);
                    File destFile = new File(destinationFolder, file);
                    copyRecursively(srcFile, destFile);
                }
            }
        }
        else  {
            Files.copy(sourceFolder.toPath(), destinationFolder.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
    }

    private String getEstimation(SolutionItems solutionItems) {
        String solutionId = String.valueOf(solutionItems.getSolutionId());

        Path dockerDirectoryPath = storageService.load(solutionId);
        String imageName = String.format("%s:%s", "image", solutionId);
        String imageId = DockerController.buildImage(dockerDirectoryPath, imageName);
        System.out.printf("Image id: %s:\n", imageId);

        String containerId = DockerController.createContainer(imageId);
        System.out.printf("Container id: %s:\n", containerId);

        String command = "java -jar estimator-java-1.0.jar whitebox-file";
        // // TODO: 10-May-19 handle if Error: Unable to access jarfile`
        String result = DockerController.execStart(containerId, command);
        System.out.println("Got result");

        DockerController.cleanUp(containerId);
        System.out.println("Cleaned up");

        return result;
    }
}
