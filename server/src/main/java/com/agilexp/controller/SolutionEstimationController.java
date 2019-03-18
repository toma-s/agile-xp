package com.agilexp.controller;

import com.agilexp.compiler.Compiler;
import com.agilexp.compiler.exception.CompilationFailedException;
import com.agilexp.model.*;
import com.agilexp.repository.*;
import com.agilexp.storage.StorageService;
import com.agilexp.tester.Tester;
import com.agilexp.tester.exception.TestFailedException;
import org.junit.runner.Result;
import org.junit.runners.model.TestTimedOutException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionEstimationController {
    @Autowired
    SolutionEstimationRepository repository;

    @Autowired
    private SolutionRepository solutionRepository;

    @Autowired
    private ExerciseRepository exerciseRepository;

    @Autowired
    private SolutionSourceRepository solutionSourceRepository;

    @Autowired
    private SolutionTestRepository solutionTestRepository;

    @Autowired
    private ExerciseTestRepository exerciseTestRepository;

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
        Solution solution = solutionRepository.findById(solutionId);
        List<ExerciseTest> exerciseTests = exerciseTestRepository.findByExerciseId(solution.getExerciseId());

        String solutionEstimationResult = getEstimationWithSolutionTests(solutionSources, solutionTests, solutionId);
        String exerciseEstimationResult = getEstimation(solutionSources, exerciseTests, solutionId);

        solutionEstimation.setEstimation(solutionEstimationResult + exerciseEstimationResult);
        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s\n", solutionEstimation);
        return _solutionEstimation;
    }

    private String getEstimationWithSolutionTests(List<SolutionSource> solutionSources, List<SolutionTest> solutionTests, long solutionId) {
        storeFilesWithSolutionTests(solutionSources, solutionTests);
        List<Path> filesPaths = getPathsWithSolutionTests(solutionSources, solutionTests);
        Path outDirPath = storageService.load("solution_public" + solutionId);

        try {
            Compiler.compile(filesPaths, outDirPath);
        } catch (CompilationFailedException e) {
            e.printStackTrace();
            return "Compilation failed: " + e.getMessage();
        }
        System.out.println("compiled");

        List<Result> solutionTestsResults = new ArrayList<>();
        for (SolutionTest solutionTest : solutionTests) {
            try {
                solutionTestsResults.add(Tester.test(outDirPath, solutionTest.getFileName()));
            } catch (TestFailedException e) {
                e.printStackTrace();
                return "Tests run failed: " + e.getMessage();
            }
        }
        System.out.println("tested");

        return getResult(solutionTestsResults, "Public");
    }

    private void storeFilesWithSolutionTests(List<SolutionSource> solutionSources, List<SolutionTest> solutionTests) {
        solutionSources.forEach(storageService::store);
        solutionTests.forEach(storageService::store);
    }

    private List<Path> getPathsWithSolutionTests(List<SolutionSource> solutionSources, List<SolutionTest> solutionTests) {
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

    private String getEstimation(List<SolutionSource> solutionSources, List<ExerciseTest> exerciseTests, long solutionId) {
        storeFiles(solutionSources, exerciseTests);
        List<Path> filesPaths = getPaths(solutionSources, exerciseTests);
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

    private void storeFiles(List<SolutionSource> solutionSources, List<ExerciseTest> exerciseTests) {
        solutionSources.forEach(storageService::store);
        exerciseTests.forEach(storageService::store);
    }

    private List<Path> getPaths(List<SolutionSource> solutionSources, List<ExerciseTest> exerciseTests) {
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
        output.append("Test runtime: ")
            .append(result.getRunTime())
            .append(" ms")
            .append("\nTest success: ")
            .append(result.wasSuccessful())
            .append("\nFailures count: ")
            .append(result.getFailureCount())
            .append("\nFailures: ")
            .append(result.getFailures())
            .append("\nIgnored count: ")
            .append(result.getIgnoreCount())
            .append("\n\n");
        return output;
    }
}
