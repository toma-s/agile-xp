package com.agilexp.service.estimator;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.dbmodel.exercise.PrivateTest;
import com.agilexp.dbmodel.solution.SolutionFile;
import com.agilexp.dbmodel.solution.SolutionSource;
import com.agilexp.dbmodel.solution.SolutionTest;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.repository.exercise.PrivateFileRepository;
import com.agilexp.repository.exercise.PrivateTestRepository;
import com.agilexp.repository.solution.SolutionEstimationRepository;
import com.agilexp.storage.StorageService;
import com.agilexp.storage.exception.StorageException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WhiteBoxFileEstimatorServiceImpl extends WhiteBoxEstimatorSuper implements EstimatorService {

    @Autowired
    SolutionEstimationRepository repository;

    @Autowired
    PrivateTestRepository privateTestRepository;

    @Autowired
    PrivateFileRepository privateFileRepository;

    @Autowired
    StorageService storageService;


    @Override
    public SolutionEstimation getEstimation(SolutionItems solutionItems) {
        SolutionEstimation estimation = getWhiteBoxEstimation(solutionItems);
        SolutionEstimation _solutionEstimation = repository.save(estimation);
        System.out.format("Created solution estimation %s%n", _solutionEstimation);
        return _solutionEstimation;
    }

    @Override
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
            storageService.copy("docker", directoryName);
        } catch (StorageException e) {
            throw new StorageException("Storage Exception occurred on storing public files" + e.getMessage());
        }
    }

    @Override
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
        storageService.copy("docker", directoryName);
    }
}
