package com.agilexp.controller;

import com.agilexp.compiler.Compiler;
import com.agilexp.compiler.exception.CompilationFailedException;
import com.agilexp.model.*;
import com.agilexp.repository.*;
import com.agilexp.storage.StorageException;
import com.agilexp.storage.StorageService;
import com.agilexp.tester.Tester;
import com.agilexp.tester.exception.TestFailedException;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionEstimationController {
    @Autowired
    private SolutionEstimationRepository repository;

    @Autowired
    private SolutionRepository solutionRepository;

    @Autowired
    private SolutionSourceRepository solutionSourceRepository;

    @Autowired
    private SolutionTestRepository solutionTestRepository;

    @Autowired
    private SolutionConfigRepository solutionConfigRepository;

    @Autowired
    private ExerciseTestRepository exerciseTestRepository;

    @Autowired
    private ExerciseConfigRepository exerciseConfigRepository;

    private final StorageService storageService;

    @Autowired
    public SolutionEstimationController(StorageService storageService) {
        this.storageService = storageService;
    }

    @GetMapping(value = "/solution-estimations/estimate/{solutionId}")
    public SolutionEstimation getSolutionEstimation(@PathVariable long solutionId) {
        SolutionEstimation solutionEstimation = new SolutionEstimation();
        solutionEstimation.setSolutionId(solutionId);

        List<SolutionSource> solutionSources = solutionSourceRepository.findSolutionSourcesBySolutionId(solutionId);
        List<SolutionTest> solutionTests = solutionTestRepository.findSolutionTestsBySolutionId(solutionId);
        List<SolutionConfig> solutionConfigs = solutionConfigRepository.findSolutionConfigBySolutionId(solutionId);
        Solution solution = solutionRepository.findById(solutionId);
        List<ExerciseTest> exerciseTests = exerciseTestRepository.findByExerciseId(solution.getExerciseId());
        List<ExerciseConfig> exerciseConfigs = exerciseConfigRepository.findByExerciseId(solution.getExerciseId());

        String estimation = getEstimation(solutionSources, solutionTests, solutionConfigs, exerciseTests, exerciseConfigs, solutionId);
        solutionEstimation.setEstimation(estimation);

        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s\n", solutionEstimation);
        return _solutionEstimation;
    }

    private String getEstimation(List<SolutionSource> solutionSources, List<SolutionTest> solutionTests, List<SolutionConfig> solutionConfigs,
                                 List<ExerciseTest> exerciseTests, List<ExerciseConfig> exerciseConfigs, long solutionId) {
        try {
            String solutionEstimationResult = estimateWithPublicTests(solutionSources, solutionTests, solutionConfigs, solutionId);
//            String exerciseEstimationResult = estimateWithPrivateTests(solutionSources, exerciseTests/*, exerciseConfigs*/, solutionId);
//            return solutionEstimationResult + exerciseEstimationResult;
            return solutionEstimationResult;
        } catch (StorageException e) {
            e.printStackTrace();
            return "File storing failed: " + e.getMessage();
        } catch (CompilationFailedException e) {
            e.printStackTrace();
            return "Compilation failed: " + e.getMessage();
        } catch (TestFailedException e) {
            e.printStackTrace();
            return "Tests run failed: " + e.getMessage();
        }
    }

    private String estimateWithPublicTests(List<SolutionSource> solutionSources, List<SolutionTest> solutionTests, List<SolutionConfig> solutionConfigs, long solutionId) throws CompilationFailedException, TestFailedException {
        try {
            storeFilesWithPublicTests(solutionSources, solutionTests);
        } catch (StorageException e) {
            throw new StorageException(e.getMessage());
        }
        List<Path> filesPaths = getPathsWithPublicTests(solutionSources, solutionTests);
        Path outDirPath = storageService.load("solution_public" + solutionId);

        try {
            Compiler.compile(filesPaths, outDirPath);
        } catch (CompilationFailedException e) {
            throw new CompilationFailedException(e.getMessage());
        }
        System.out.println("compiled");

        solutionConfigs.forEach(storageService::store);
        System.out.println("stored configs");

        List<Result> solutionTestsResults = new ArrayList<>();
        for (SolutionTest solutionTest : solutionTests) {
            try {
                solutionTestsResults.add(Tester.test(outDirPath, solutionTest.getFileName()));
            } catch (TestFailedException e) {
                throw new TestFailedException(e.getMessage());
            }
        }
        System.out.println("tested");

        return getResult(solutionTestsResults, "Public");
    }

    private void storeFilesWithPublicTests(List<SolutionSource> solutionSources, List<SolutionTest> solutionTests) {
        try {
            solutionSources.forEach(storageService::store);
            solutionTests.forEach(storageService::store);
        } catch (StorageException e) {
            throw new StorageException(e.getMessage());
        }
    }

    private List<Path> getPathsWithPublicTests(List<SolutionSource> solutionSources, List<SolutionTest> solutionTests) {
        List<Path> paths = new ArrayList<>();
        solutionSources.forEach(solutionSource ->
                paths.add(storageService
                        .load("solution_source" + solutionSource.getId())
                        .resolve(solutionSource.getFileName())));
        solutionTests.forEach(solutionTest ->
                paths.add(storageService
                        .load("solution_test" + solutionTest.getId())
                        .resolve(solutionTest.getFileName())));
        return paths;
    }

    private String estimateWithPrivateTests(List<SolutionSource> solutionSources, List<ExerciseTest> exerciseTests, long solutionId) {
        try {
            storeFilesWithPrivateTests(solutionSources, exerciseTests);
        } catch (StorageException e) {
            e.printStackTrace();
            return "File storing failed: " + e.getMessage();
        }
        List<Path> filesPaths = getPathsWithPrivateTests(solutionSources, exerciseTests);
        Path outDirPath = storageService.load("solution_private" + solutionId);

        try {
            Compiler.compile(filesPaths, outDirPath);
        } catch (CompilationFailedException e) {
            return "Compilation failed: " + e.getMessage();
        }
        System.out.println("compiled");

        List<Result> exerciseTestsResults = new ArrayList<>();
        for (ExerciseTest exerciseTest : exerciseTests) {
            try {
                exerciseTestsResults.add(Tester.test(outDirPath, exerciseTest.getFileName()));
                System.out.println("tested exerciseTest");
            } catch (TestFailedException e) {
                e.printStackTrace();
                return "Tests run failed: " + e.getMessage();
            }
        }

        return getResult(exerciseTestsResults, "Private");
    }

    private void storeFilesWithPrivateTests(List<SolutionSource> solutionSources, List<ExerciseTest> exerciseTests) {
        try {
            solutionSources.forEach(storageService::store);
            exerciseTests.forEach(storageService::store);
        } catch (StorageException e) {
            throw new StorageException(e.getMessage());
        }
    }

    private List<Path> getPathsWithPrivateTests(List<SolutionSource> solutionSources, List<ExerciseTest> exerciseTests) {
        List<Path> paths = new ArrayList<>();
        solutionSources.forEach(solutionSource ->
                paths.add(storageService
                    .load("solution_source" + solutionSource.getId())
                    .resolve(solutionSource.getFileName())));
        exerciseTests.forEach(exerciseTest ->
            paths.add(storageService
                        .load("exercise_test" + exerciseTest.getId())
                        .resolve(exerciseTest.getFileName()))
        );
        return paths;
    }

    private String getResult(List<Result> exerciseTestsResults, String type) {
        StringBuilder result = new StringBuilder();

        result.append(type)
            .append(" tests result:\n");
        exerciseTestsResults.forEach(exerciseTestsResult ->
            result.append(getResultInfo(exerciseTestsResult))
        );

        return result.toString();
    }

    private StringBuffer getResultInfo(Result result) {
        StringBuffer output = new StringBuffer();
        output.append("Test runtime: ").append(result.getRunTime()).append(" ms")
            .append("\nTest success: ").append(result.wasSuccessful())
            .append("\nFailures count: ").append(result.getFailureCount());
        if (result.getFailureCount() > 0) {
            output.append("\nFailures: ");
            List<Failure> failures = result.getFailures();
            for (int i = 0; i < failures.size(); i++) {
                Failure failure = failures.get(i);
                output.append("\n").append(i + 1).append(") ").append(failure);
            }
        }
        output.append("\nIgnored count: ").append(result.getIgnoreCount()).append("\n\n");
        return output;
    }
}
