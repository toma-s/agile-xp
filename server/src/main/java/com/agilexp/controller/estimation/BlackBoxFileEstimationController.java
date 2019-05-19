package com.agilexp.controller.estimation;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.dbmodel.exercise.PrivateSource;
import com.agilexp.dbmodel.solution.SolutionFile;
import com.agilexp.dbmodel.solution.SolutionTest;
import com.agilexp.model.estimation.Estimation;
import com.agilexp.model.exercise.ExerciseFlags;
import com.agilexp.model.exercise.ExerciseSwitcher;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.repository.exercise.BugsNumberRepository;
import com.agilexp.repository.exercise.PrivateFileRepository;
import com.agilexp.repository.exercise.PrivateSourceRepository;
import com.agilexp.repository.solution.*;
import com.agilexp.storage.exception.StorageException;
import com.agilexp.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    void storeFiles(SolutionItems solutionItems, String directoryName) {
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
            storageService.copy("docker", directoryName);
        } catch (StorageException e) {
            throw new StorageException("Storage Exception occurred on storing public files" + e.getMessage());
        }
    }
}
