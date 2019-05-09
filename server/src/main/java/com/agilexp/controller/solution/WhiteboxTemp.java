package com.agilexp.controller.solution;

import com.agilexp.DockerController;
import com.agilexp.dbmodel.solution.SolutionContent;
import com.agilexp.dbmodel.solution.SolutionEstimation;
import com.agilexp.model.SolutionItems;
import com.agilexp.storage.StorageException;
import com.agilexp.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class WhiteboxTemp {

    private final StorageService storageService;

    @Autowired
    public WhiteboxTemp(StorageService storageService) {
        this.storageService = storageService;
    }

        @PostMapping(value = "/solution-estimation/estimate/whitebox-file")
    public SolutionEstimation getWhiteboxFileEstimation(@RequestBody SolutionItems solutionItems) {
        storeFiles(solutionItems);
        String result = doDockerStuff(solutionItems);
        System.out.println(result);

        SolutionEstimation solutionEstimation = new SolutionEstimation(solutionItems.getSolutionId());

        return solutionEstimation;
    }

    private void storeFiles(SolutionItems solutionItems) {
        String solutionId = String.valueOf(solutionItems.getSolutionId());
        solutionItems.getSolutionSources().forEach(solutionSource ->
                storageService.store(solutionSource, "solution_source", solutionId));
        solutionItems.getSolutionTests().forEach(solutionTest ->
                storageService.store(solutionTest, "solution_test", solutionId));
        solutionItems.getSolutionFiles().forEach(solutionFile ->
                storageService.store(solutionFile, "solution_file", solutionId));

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

    private String doDockerStuff(SolutionItems solutionItems) {
        String solutionId = String.valueOf(solutionItems.getSolutionId());

        Path dockerDirectoryPath = storageService.load(solutionId);
        String imageName = String.format("%s:%s", "image", solutionId);
        String imageId = DockerController.buildImage(dockerDirectoryPath, imageName);
        System.out.printf("Image id: %s:\n", imageId);

        String containerId = DockerController.createContainer(imageId);
        System.out.printf("Container id: %s:\n", containerId);

        String command = "java -jar tester-java-1.0.jar whitebox-file";
        String result = DockerController.execStart(containerId, command);
        System.out.println("Got result");

        DockerController.cleanUp(containerId);
        System.out.println("Cleaned up");

        return result;
    }
}
