package com.agilexp.controller.estimation;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.dbmodel.exercise.PrivateSource;
import com.agilexp.dbmodel.solution.SolutionFile;
import com.agilexp.dbmodel.solution.SolutionTest;
import com.agilexp.docker.DockerController;
import com.agilexp.docker.DockerControllerException;
import com.agilexp.model.estimation.Estimation;
import com.agilexp.model.exercise.ExerciseFlags;
import com.agilexp.model.exercise.ExerciseSwitcher;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.repository.exercise.BugsNumberRepository;
import com.agilexp.repository.exercise.PrivateFileRepository;
import com.agilexp.repository.exercise.PrivateSourceRepository;
import com.agilexp.repository.solution.*;
import com.agilexp.storage.StorageException;
import com.agilexp.storage.StorageService;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.util.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class BlackBoxFileEstimationController extends BlackBoxEstimationSuper {

    private final PrivateSourceRepository privateSourceRepository;
    private final BugsNumberRepository bugsNumberRepository;
    private final SolutionEstimationRepository repository;
    private final PrivateFileRepository privateFileRepository;

    @Autowired
    public BlackBoxFileEstimationController(StorageService storageService, SolutionEstimationRepository repository, PrivateFileRepository privateFileRepository, PrivateSourceRepository privateSourceRepository, BugsNumberRepository bugsNumberRepository) {
        super(storageService);
        this.repository = repository;
        this.privateFileRepository = privateFileRepository;
        this.privateSourceRepository = privateSourceRepository;
        this.bugsNumberRepository = bugsNumberRepository;
    }

    @PostMapping(value = "/solution-estimation/estimate/blackbox-file")
    public SolutionEstimation getBlackBoxFileEstimation(@RequestBody SolutionItems solutionItems) {
        Estimation blackBoxEstimation = getBlackBoxEstimation(solutionItems);
        SolutionEstimation estimation = getEstimation(solutionItems.getSolutionId(), blackBoxEstimation);
        SolutionEstimation _solutionEstimation = repository.save(estimation);
        System.out.format("Created solution estimation %s\n", _solutionEstimation);
        return _solutionEstimation;
    }

    private Estimation getBlackBoxEstimation(SolutionItems solutionItems) {
        try {
            String directoryName = String.valueOf(solutionItems.getSolutionId());
            storeFiles(solutionItems, directoryName);
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

    private void storeFiles(SolutionItems solutionItems, String directoryName) {
        try {
            for (SolutionTest solutionTest : solutionItems.getSolutionTests()) {
                storageService.store(solutionTest, "tests", directoryName);
            }
            for (SolutionFile solutionFile : solutionItems.getSolutionFiles()) {
                storageService.store(solutionFile, "files", directoryName);
            }
            long exerciseId = solutionItems.getExerciseId();
            List<PrivateSource> privateSources = privateSourceRepository.findPrivateSourcesByExerciseId(exerciseId);
            for (PrivateSource privateSource : privateSources) {
                storageService.store(privateSource, "private-sources", directoryName);
            }
            List<PrivateFile> privateFiles = privateFileRepository.findPrivateFilesByExerciseId(exerciseId);
            for (PrivateFile privateFile : privateFiles) {
                storageService.store(privateFile, "private-files", directoryName);
            }
            int bugsNumber = bugsNumberRepository.findBugsNumberByExerciseId(exerciseId).getNumber();
            storageService.store(bugsNumber, "bugsNumber", directoryName);
            List<ExerciseFlags> exerciseFlags = getExerciseFlags(bugsNumber);
            for (ExerciseFlags exerciseFlags1 : exerciseFlags) {
                storageService.store(exerciseFlags1, "altering-flags", directoryName);
            }
            ExerciseFlags controllingFlags = getControllingFlags(bugsNumber);
            storageService.store(controllingFlags, "control-flags", directoryName);
            ExerciseSwitcher exerciseSwitcher = getExerciseSwitcher();
            storageService.store(exerciseSwitcher, "switcher", directoryName);
            copyEstimationFiles(directoryName);
        } catch (StorageException e) {
            throw new StorageException("Storage Exception occurred on storing public files" + e.getMessage());
        }
    }

    private List<ExerciseFlags> getExerciseFlags(int bugsNum) {
        // TODO: 10-May-19 refactor
        List<ExerciseFlags> exerciseFlags = new ArrayList<>();
        for (int i = 0; i < bugsNum; i++) {
            String[] booleans = new String[bugsNum];
            Arrays.fill(booleans, "false");
            booleans[i] = "true";
            ExerciseFlags flags = new ExerciseFlags();
            String content = String.join("\n", booleans);
            content += '\n';
            flags.setContent(content);
            flags.setFilename("flags" + i + ".txt");
            exerciseFlags.add(flags);
        }
        return exerciseFlags;
    }

    private ExerciseFlags getControllingFlags(int bugsNum) {
        // TODO: 10-May-19 refactor
        String[] booleans = new String[bugsNum];
        Arrays.fill(booleans, "false");
        ExerciseFlags flags = new ExerciseFlags();
        String content = String.join("\n", booleans);
        content += '\n';
        flags.setContent(content);
        flags.setFilename("flags.txt");
        return flags;
    }

    private ExerciseSwitcher getExerciseSwitcher() {
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

    private void copyEstimationFiles(String destDirectoryName) {
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


    private SolutionEstimation getEstimation(long solutionId, Estimation blackBoxEstimation) {
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
        return String.format("Progress: %s%%\n\n" +
                        "SolutionEstimation result:\n" +
                        "\n" +
                        "Compilation result:\n" +
                        "Compiled successfully: %s\n" +
                        "%s\n" +
                        "Tests result:\n" +
                        "Tested successfully: %s\n" +
                        "%s\n",
                estimation.getValue(),
                estimation.isCompiled(),
                estimation.getCompilationResult(),
                estimation.isTested(),
                estimation.getTestsResult()
        );
    }
}
