package com.agilexp.controller;

import com.agilexp.compiler.Compiler;
import com.agilexp.compiler.exception.CompilationFailedException;
import com.agilexp.model.*;
import com.agilexp.repository.*;
import com.agilexp.storage.StorageService;
import com.agilexp.tester.Tester;
import com.agilexp.tester.exception.TestFailedException;
import org.junit.runner.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

        SolutionSource solutionSource = solutionSourceRepository.findSolutionSourceBySolutionId(solutionId);
        SolutionTest solutionTest = solutionTestRepository.findSolutionTestBySolutionId(solutionId);
        Solution solution = solutionRepository.findById(solutionId);
        List<ExerciseTest> exerciseTests = exerciseTestRepository.findByExerciseId(solution.getExerciseId());

        String solutionEstimationResult = getEstimation(solutionSource, solutionTest);
        String exerciseEstimationResult = getEstimation(solutionSource, exerciseTests);
//        solutionEstimation.setEstimation(getEstimation(solutionSource, solutionTest, exerciseTests));

        solutionEstimation.setEstimation(solutionEstimationResult + exerciseEstimationResult);
        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s\n", solutionEstimation);
        return _solutionEstimation;
    }

    private String getEstimation(SolutionSource solutionSource, SolutionTest solutionTest) {
        storeFiles(solutionSource, solutionTest);
        List<Path> filesPaths = getPaths(solutionSource, solutionTest);
        Path outDirPath = storageService.load("solution_public" + solutionSource.getSolutionId());

        try {
            Compiler.compile(filesPaths, outDirPath);
        } catch (CompilationFailedException e) {
            return "Compilation failed: " + e.getMessage();
        }
        System.out.println("compiled");

        Result solutionTestsResult;
        try {
            solutionTestsResult = Tester.test(outDirPath, solutionTest.getFileName());
        } catch (TestFailedException e) {
            return "Tests run failed: " + e.getMessage();
        }
        System.out.println("tested solutionTest");

        return getResult(solutionTestsResult);
    }

    private String getEstimation(SolutionSource solutionSource, List<ExerciseTest> exerciseTests) {
        storeFiles(solutionSource, exerciseTests);
        List<Path> filesPaths = getPaths(solutionSource, exerciseTests);
        Path outDirPath = storageService.load("solution_private" + solutionSource.getSolutionId());

        try {
            Compiler.compile(filesPaths, outDirPath);
        } catch (CompilationFailedException e) {
            return "Compilation failed: " + e.getMessage();
        }
        System.out.println("compiled");

        List<Result> exerciseTestsResults = new ArrayList<>();
        exerciseTests.forEach(exerciseTest -> {
            try {
                exerciseTestsResults.add(Tester.test(outDirPath, exerciseTest.getFileName()));
                System.out.println("tested exerciseTest");
            } catch (TestFailedException e) {
                e.printStackTrace();
            }
        });

        return getResult(exerciseTestsResults);
    }

    private void storeFiles(SolutionSource solutionSource,
                            SolutionTest solutionTest) {
        storageService.store(solutionSource);
        storageService.store(solutionTest);
    }

    private void storeFiles(SolutionSource solutionSource,
                            List<ExerciseTest> exerciseTests) {
        storageService.store(solutionSource);
        exerciseTests.forEach(storageService::store);
    }

    private List<Path> getPaths(SolutionSource solutionSource,
                                SolutionTest solutionTest) {
        List<Path> paths = new ArrayList<>();
        paths.add(storageService
                .load("solution_source" + solutionSource.getId())
                .resolve(solutionSource.getFileName()));
        paths.add(storageService
                .load("solution_test" + solutionTest.getId())
                .resolve(solutionTest.getFileName()));
        return paths;
    }

    private List<Path> getPaths(SolutionSource solutionSource,
                                List<ExerciseTest> exerciseTests) {
        List<Path> paths = new ArrayList<>();
        paths.add(storageService
                .load("solution_source" + solutionSource.getId())
                .resolve(solutionSource.getFileName()));
        exerciseTests.forEach(exerciseTest ->
            paths.add(storageService
                    .load("exercise_test" + exerciseTest.getId())
                    .resolve(exerciseTest.getFileName()))
        );
        return paths;
    }

    private String getResult(Result solutionTestsResult) {
        StringBuilder result = new StringBuilder();

        result.append("Public tests result:\n")
                .append(getResultInfo(solutionTestsResult));

        return result.toString();
    }

    private String getResult(List<Result> exerciseTestsResults) {
        StringBuilder result = new StringBuilder();

        result.append("Private tests result:\n");
        exerciseTestsResults.forEach(exerciseTestsResult -> {
            result.append(getResultInfo(exerciseTestsResult));
        });

        return result.toString();
    }

    private StringBuffer getResultInfo(Result result) {
        StringBuffer output = new StringBuffer();
        output.append("Test runtime: ")
                .append(result.getRunTime())
                .append("\nTest success: ")
                .append(result.wasSuccessful())
                .append("\nFailures count: ")
                .append(result.getFailureCount())
                .append("\nFailures: ")
                .append(result.getFailures())
                .append("\nIgnored count: ")
                .append(result.getIgnoreCount())
                .append("\n");
        return output;
    }
}
