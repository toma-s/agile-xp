package com.agilexp.controller.estimation;

import com.agilexp.dbmodel.estimation.Estimation;
import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.dbmodel.exercise.PrivateTest;
import com.agilexp.dbmodel.solution.SolutionFile;
import com.agilexp.dbmodel.solution.SolutionSource;
import com.agilexp.dbmodel.solution.SolutionTest;
import com.agilexp.docker.DockerControllerException;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.repository.exercise.PrivateFileRepository;
import com.agilexp.repository.exercise.PrivateTestRepository;
import com.agilexp.repository.solution.SolutionEstimationRepository;
import com.agilexp.storage.StorageException;
import com.agilexp.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class WhiteBoxFileEstimationController extends Super {

    private final SolutionEstimationRepository repository;
    private final PrivateTestRepository privateTestRepository;
    private final PrivateFileRepository privateFileRepository;

    @Autowired
    public WhiteBoxFileEstimationController(StorageService storageService, SolutionEstimationRepository repository, PrivateTestRepository privateTestRepository, PrivateFileRepository privateFileRepository) {
        super(storageService);
        this.repository = repository;
        this.privateTestRepository = privateTestRepository;
        this.privateFileRepository = privateFileRepository;
    }

    @PostMapping(value = "/solution-estimation/estimate/whitebox-file")
    public Estimation getWhiteBoxFileEstimation(@RequestBody SolutionItems solutionItems) {
        Estimation estimation = super.getWhiteBoxEstimation(solutionItems);
        Estimation _solutionEstimation = repository.save(estimation);
        System.out.format("Created solution estimation %s\n", _solutionEstimation);
        return _solutionEstimation;
    }

    void storePublicFiles(SolutionItems solutionItems, String directoryName) {
        try {
            for (SolutionSource solutionSource : solutionItems.getSolutionSources()) {
                storageService.store(solutionSource, "sources", directoryName);
            }
            for (SolutionTest solutionTest : solutionItems.getSolutionTests()) {
                storageService.store(solutionTest, "tests", directoryName);
            }
            for (SolutionFile solutionFile : solutionItems.getSolutionFiles()) {
                storageService.store(solutionFile, "files", directoryName);
            }
            copyEstimationFiles(directoryName);
        } catch (StorageException e) {
            throw new StorageException("Storage Exception occurred on storing public files" + e.getMessage());
        }
    }

    void storePrivateFiles(SolutionItems solutionItems, String directoryName) {
        for (SolutionSource solutionSource : solutionItems.getSolutionSources()) {
            storageService.store(solutionSource, "sources", directoryName);
        }
        long exerciseId = solutionItems.getExerciseId();
        List<PrivateTest> privateTests = privateTestRepository.findPrivateTestsByExerciseId(exerciseId);
        for (PrivateTest privateTest : privateTests) {
            storageService.store(privateTest, "tests", directoryName);
        }
        List<PrivateFile> privateFiles = privateFileRepository.findPrivateFilesByExerciseId(exerciseId);
        for (PrivateFile privateFile : privateFiles) {
            storageService.store(privateFile, "files", directoryName);
        }
        copyEstimationFiles(directoryName);
    }


    String executeEstimation(String directoryName) throws DockerControllerException {
        String mode = "whitebox-file";
        return super.executeEstimationByMode(directoryName, mode);
    }
}
