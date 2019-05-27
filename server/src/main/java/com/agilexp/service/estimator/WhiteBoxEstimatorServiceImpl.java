package com.agilexp.service.estimator;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import com.agilexp.dbmodel.exercise.PrivateTest;
import com.agilexp.dbmodel.solution.SolutionSource;
import com.agilexp.dbmodel.solution.SolutionTest;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.repository.exercise.PrivateTestRepository;
import com.agilexp.repository.solution.SolutionEstimationRepository;
import com.agilexp.storage.StorageService;
import com.agilexp.storage.exception.StorageException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WhiteBoxEstimatorServiceImpl extends WhiteBoxEstimatorSuper implements EstimatorService  {

    @Autowired
    SolutionEstimationRepository repository;

    @Autowired
    PrivateTestRepository privateTestRepository;

    @Autowired
    StorageService storageService;


    @Override
    public SolutionEstimation getEstimation(SolutionItems solutionItems) {
        SolutionEstimation estimation = getWhiteBoxEstimation(solutionItems);
        SolutionEstimation _solutionEstimation = repository.save(estimation);
        System.out.format("Created solution estimation %s%n", _solutionEstimation);
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
            storageService.copy("docker", directoryName);
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
        storageService.copy("docker", directoryName);
    }

}
