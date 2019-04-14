package com.agilexp.controller.solution;

import com.agilexp.compiler.Compiler;
import com.agilexp.compiler.exception.CompilationFailedException;
import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.exercise.ExerciseSource;
import com.agilexp.dbmodel.exercise.ExerciseTest;
import com.agilexp.dbmodel.solution.*;
import com.agilexp.model.ExerciseFlags;
import com.agilexp.model.ExerciseSwitcher;
import com.agilexp.repository.exercise.BugsNumberRepository;
import com.agilexp.repository.exercise.ExerciseFileRepository;
import com.agilexp.repository.exercise.ExerciseSourceRepository;
import com.agilexp.repository.exercise.ExerciseTestRepository;
import com.agilexp.repository.solution.*;
import com.agilexp.storage.StorageException;
import com.agilexp.storage.StorageService;
import com.agilexp.tester.Tester;
import com.agilexp.tester.exception.TestFailedException;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.*;
import java.util.stream.Collectors;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionEstimationController {
    @Autowired private SolutionEstimationRepository repository;
    @Autowired private SolutionRepository solutionRepository;
    @Autowired private SolutionSourceRepository solutionSourceRepository;
    @Autowired private SolutionTestRepository solutionTestRepository;
    @Autowired private SolutionFileRepository solutionFileRepository;
    @Autowired private ExerciseSourceRepository exerciseSourceRepository;
    @Autowired private ExerciseTestRepository exerciseTestRepository;
    @Autowired private ExerciseFileRepository exerciseFileRepository;
    @Autowired private BugsNumberRepository bugsNumberRepository;

    private final StorageService storageService;

    private final String PUBLIC = "Public";
    private final String PRIVATE = "Private";

    @Autowired
    public SolutionEstimationController(StorageService storageService) {
        this.storageService = storageService;
    }

    @GetMapping(value = "/solution-estimations/estimate/source-test/{solutionId}")
    public SolutionEstimation getSolutionSourceTestEstimation(@PathVariable long solutionId) {
//        Date date = new Date();
//        String created = new Timestamp(date.getTime()).toString().replace('.', '-').replace(' ', '-').replace(':', '-');
        String created = "12345";

        SolutionEstimation solutionEstimation = new SolutionEstimation(solutionId);

        String estimation = estimateSourceTest(solutionId, created);
        solutionEstimation.setEstimation(estimation);

        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s\n", _solutionEstimation);
        return _solutionEstimation;
    }

    @GetMapping(value = "/solution-estimations/estimate/source-test-file/{solutionId}")
    public SolutionEstimation getSolutionSourceTestFileEstimation(@PathVariable long solutionId) {
//        Date date = new Date();
//        String created = new Timestamp(date.getTime()).toString().replace('.', '-').replace(' ', '-').replace(':', '-');
        String created = "12345";

        SolutionEstimation solutionEstimation = new SolutionEstimation(solutionId);

        String estimation = estimateSourceTestFile(solutionId, created);
        solutionEstimation.setEstimation(estimation);

        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s\n", _solutionEstimation);
        return _solutionEstimation;
    }

    private String estimateSourceTest(long solutionId, String created) {
        List<SolutionSource> solutionSources = solutionSourceRepository.findBySolutionId(solutionId);
        List<SolutionTest> solutionTests = solutionTestRepository.findBySolutionId(solutionId);

        Solution solution = solutionRepository.findById(solutionId);
        List<ExerciseTest> exerciseTests = exerciseTestRepository.findExerciseTestsByExerciseId(solution.getExerciseId());

        List<List<? extends SolutionContent>> solutionContents = List.of(solutionSources, solutionTests);
        List<List<? extends ExerciseContent>> exerciseContents = List.of(exerciseTests);

        Path outDirPath = storageService.load(created + "/solution_public" + solutionId);
        String publicEstimation = estimatePublic(solutionContents, outDirPath, created);
        String privateEstimation = estimatePrivate(solutionContents, exerciseContents, outDirPath, created);
        return publicEstimation + privateEstimation;
    }

    private String estimateSourceTestFile(long solutionId, String created) {
        List<SolutionSource> solutionSources = solutionSourceRepository.findBySolutionId(solutionId);
        List<SolutionTest> solutionTests = solutionTestRepository.findBySolutionId(solutionId);
        List<SolutionFile> solutionFiles = solutionFileRepository.findBySolutionId(solutionId);

        Solution solution = solutionRepository.findById(solutionId);
        List<ExerciseTest> exerciseTests = exerciseTestRepository.findExerciseTestsByExerciseId(solution.getExerciseId());
//      exerciseFileRepository.findExerciseFilesByExerciseId(solution.getExerciseId())
//      TODO: 02-Apr-19 exerciseFiles when solutionFiles work completely

        List<List<? extends SolutionContent>> solutionContents = List.of(solutionSources, solutionTests, solutionFiles);
        List<List<? extends ExerciseContent>> exerciseContents = List.of(exerciseTests);

        Path outDirPath = storageService.load(created + "/solution_private" + solutionId);
        String publicEstimation = estimatePublic(solutionContents, outDirPath, created);
        String privateEstimation = estimatePrivate(solutionContents, exerciseContents, outDirPath, created);
        return publicEstimation + privateEstimation;
    }


    private String estimatePublic(List<List<? extends SolutionContent>> solutionContents, Path outDirPath, String created) {
        try {
            storeFiles(solutionContents, List.of(), created);

            copyDefault(created);

            run(created);

            List<Path> paths = getPublicPaths(solutionContents, created);
            compileFiles(paths, outDirPath);
            List<Result> testResults = testPublicFiles(solutionContents, outDirPath);
            removeTempFiles();
            return getResult(testResults, PUBLIC);
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

    private void run(String created) {
        String path = storageService.load(created).toString();
        ProcessBuilder processBuilder = new ProcessBuilder();
//        processBuilder.command("sh", "vagrant.sh");
        processBuilder.command("C:\\Windows\\system32\\cmd.exe", "vagrant.sh");
        processBuilder.directory(new File(path + File.separator));
        try {
            System.out.println("start");
            Process process = processBuilder.start();
            int exitCode = process.waitFor();
            if (exitCode != 0) {
                throw new RuntimeException("vagrant error");
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }

    private String estimatePrivate(List<List<? extends SolutionContent>> solutionContents, List<List<? extends ExerciseContent>> exerciseContents, Path outDirPath, String created) {
        try {
            storeFiles(solutionContents, exerciseContents, created);
            List<Path> paths = getPrivatePaths(solutionContents, exerciseContents, created);
            compileFiles(paths, outDirPath);
            List<Result> testResults = testPrivateFiles(exerciseContents, outDirPath);
            removeTempFiles();
            return getResult(testResults, PRIVATE);
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

    private void copyDefault(String created) {
        try {
            File sourceFolder = new File("start-vagrant");
            File destinationFolder = storageService.load(created).toFile();
            copyFolder(sourceFolder, destinationFolder);
        } catch (StorageException | IOException e) {
            throw new StorageException("Failed to copy files");
        }
    }

    private static void copyFolder(File sourceFolder, File destinationFolder) throws IOException {
        if (sourceFolder.isDirectory()) {
            if (!destinationFolder.exists()){
                destinationFolder.mkdir();
            }
            String files[] = sourceFolder.list();
            for (String file : files)
            {
                File srcFile = new File(sourceFolder, file);
                File destFile = new File(destinationFolder, file);
                copyFolder(srcFile, destFile);
            }
        }
        else  {
            Files.copy(sourceFolder.toPath(), destinationFolder.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
    }

    @GetMapping(value = "/solution-estimations/estimate/test/{solutionId}")
    public SolutionEstimation getSolutionTestEstimation(@PathVariable long solutionId) {
//        Date date = new Date();
//        String created = new Timestamp(date.getTime()).toString().replace('.', '-').replace(' ', '-').replace(':', '-');
        String created = "12345";

        SolutionEstimation solutionEstimation = new SolutionEstimation(solutionId);

        String privateEstimation = estimateTest(solutionId, created);
        solutionEstimation.setEstimation(privateEstimation);

        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s\n", _solutionEstimation);
        return _solutionEstimation;
    }

    private String estimateTest(long solutionId, String created) {
        List<SolutionTest> solutionTests = solutionTestRepository.findBySolutionId(solutionId);
        Solution solution = solutionRepository.findById(solutionId);
        List<ExerciseSource> exerciseSources = exerciseSourceRepository.findExerciseSourcesByExerciseId(solution.getExerciseId());
        List<ExerciseSwitcher> exerciseSwitchers = getExerciseSwitchers();
        int bugsNum = bugsNumberRepository.findBugsNumberByExerciseId(solution.getExerciseId()).getNumber();
        List<ExerciseFlags> exerciseFlags = getExerciseFlags(bugsNum);
        ExerciseFlags controllingFlags = getControllingFlags(bugsNum);
        Path outDirPath = storageService.load(created + "/solution_public_blackbox" + solutionId);

        try {
            int bugsFound = 0;
            for (int i = 0; i < bugsNum; i++) {
                storeFiles(List.of(solutionTests), List.of(exerciseSources, exerciseSwitchers, List.of(exerciseFlags.get(i))), created);
                List<Path> paths = getPublicBlackBoxPaths(solutionTests, exerciseSwitchers, exerciseSources, created);
                compileFiles(paths, outDirPath);
                List<Result> testResults = testPublicFiles(List.of(solutionTests), outDirPath);
                removeTempFiles();

                storeFiles(List.of(solutionTests), List.of(exerciseSources, exerciseSwitchers, List.of(controllingFlags)), created);
                List<Path> controllingPaths = getPublicBlackBoxPaths(solutionTests, exerciseSwitchers, exerciseSources, created);
                compileFiles(controllingPaths, outDirPath);
                List<Result> controllingTestResults = testPublicFiles(List.of(solutionTests), outDirPath);
                removeTempFiles();

                if (bugWasFound(testResults, controllingTestResults)) {
                    bugsFound++;
                }
            }
            return String.format("Bugs found: %s / %s", bugsFound, bugsNum);
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

    @GetMapping(value = "/solution-estimations/estimate/test-file/{solutionId}")
    public SolutionEstimation getSolutionTestFileEstimation(@PathVariable long solutionId) {
//        Date date = new Date();
//        String created = new Timestamp(date.getTime()).toString().replace('.', '-').replace(' ', '-').replace(':', '-');
        String created = "12345";

        SolutionEstimation solutionEstimation = new SolutionEstimation(solutionId);

        String privateEstimation = estimateTestFile(solutionId, created);
        solutionEstimation.setEstimation(privateEstimation);

        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s\n", _solutionEstimation);
        return _solutionEstimation;
    }

    private String estimateTestFile(long solutionId, String created) {
        List<SolutionTest> solutionTests = solutionTestRepository.findBySolutionId(solutionId);
        Solution solution = solutionRepository.findById(solutionId);
        List<ExerciseSource> exerciseSources = exerciseSourceRepository.findExerciseSourcesByExerciseId(solution.getExerciseId());
        List<SolutionFile> solutionFiles = solutionFileRepository.findBySolutionId(solutionId);
        List<ExerciseSwitcher> exerciseSwitchers = getExerciseSwitchers();
        int bugsNum = bugsNumberRepository.findBugsNumberByExerciseId(solution.getExerciseId()).getNumber();
        List<ExerciseFlags> exerciseFlags = getExerciseFlags(bugsNum);
        ExerciseFlags controllingFlags = getControllingFlags(bugsNum);
        Path outDirPath = storageService.load(created + "/solution_public_blackbox" + solutionId);

        try {
            int bugsFound = 0;
            for (int i = 0; i < bugsNum; i++) {
                storeFiles(List.of(solutionTests, solutionFiles), List.of(exerciseSources, exerciseSwitchers, List.of(exerciseFlags.get(i))), created);
                List<Path> paths = getPublicBlackBoxPaths(solutionTests, exerciseSwitchers, exerciseSources, created);
                compileFiles(paths, outDirPath);
                List<Result> testResults = testPublicFiles(List.of(solutionTests), outDirPath);
                removeTempFiles();

                storeFiles(List.of(solutionTests), List.of(exerciseSources, exerciseSwitchers, List.of(controllingFlags)), created);
                List<Path> controllingPaths = getPublicBlackBoxPaths(solutionTests, exerciseSwitchers, exerciseSources, created);
                compileFiles(controllingPaths, outDirPath);
                List<Result> controllingTestResults = testPublicFiles(List.of(solutionTests), outDirPath);
                removeTempFiles();

                if (bugWasFound(testResults, controllingTestResults)) {
                    bugsFound++;
                }
            }
            return String.format("Bugs found: %s / %s", bugsFound, bugsNum);
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

    private boolean bugWasFound(List<Result> testResults, List<Result> controllingTestResults) {
        for (int j = 0; j < testResults.size(); j++) {
            Result result = testResults.get(j);
            Result controllingResult = controllingTestResults.get(j);
            if (result.getFailureCount() - controllingResult.getFailureCount() >= 1) {
                return true;
            }
        }
        return false;
    }

    private List<ExerciseSwitcher> getExerciseSwitchers() {
        List<ExerciseSwitcher> switchers = new ArrayList<>();
        ExerciseSwitcher switcher = new ExerciseSwitcher();
        Path switcherFilePath = Paths.get("switcher/BlackBoxSwitcher.java");
        String switcherContent = null;
        try (Scanner scanner = new Scanner(switcherFilePath.toFile())) {
            switcherContent = scanner.useDelimiter("\\A").next();
        } catch (IOException e) {
            e.printStackTrace();
        }
        switcher.setContent(switcherContent);
        switcher.setFilename("BlackBoxSwitcher.java");
        switchers.add(switcher);
        return switchers;
    }

    private List<ExerciseFlags> getExerciseFlags(int bugsNum) {
        List<ExerciseFlags> exerciseFlags = new ArrayList<>();
        for (int i = 0; i < bugsNum; i++) {
            String[] booleans = new String[bugsNum];
            Arrays.fill(booleans, "false");
            booleans[i] = "true";
            ExerciseFlags flags = new ExerciseFlags();
            String content = String.join("\n", booleans);
            content += '\n';
            flags.setContent(content);
            flags.setFilename("flags.txt");
            exerciseFlags.add(flags);
        }
        return exerciseFlags;
    }

    private ExerciseFlags getControllingFlags(int bugsNum) {
        String[] booleans = new String[bugsNum];
        Arrays.fill(booleans, "false");
        ExerciseFlags flags = new ExerciseFlags();
        String content = String.join("\n", booleans);
        content += '\n';
        flags.setContent(content);
        flags.setFilename("flags.txt");
        return flags;
    }

    private void storeFiles(List<List<? extends SolutionContent>> solutionContent, List<List<? extends ExerciseContent>> exerciseContent, String created) {
        try {
            solutionContent.forEach(e -> e.forEach(ee -> storageService.store(ee, created)));
            exerciseContent.forEach(e -> e.forEach(ee -> storageService.store(ee, created)));
        } catch (StorageException e) {
            throw new StorageException(e.getMessage());
        }
    }

    private List<Path> getPublicPaths(List<List<? extends SolutionContent>> solutionContent, String created) {
        return solutionContent.stream()
                .flatMap(Collection::stream)
                .filter(e -> e instanceof SolutionSource ||
                        e instanceof SolutionTest)
                .map(e -> storageService
                        .load(created + "/solution_content" + e.getId())
                        .resolve(e.getFilename()))
                .collect(Collectors.toList());
    }

    private List<Path> getPrivatePaths(List<List<? extends SolutionContent>> solutionContent, List<List<? extends ExerciseContent>> exerciseContent, String created) {
        List<Path> paths = solutionContent.stream()
                .flatMap(Collection::stream)
                .filter(e -> e instanceof SolutionSource)
                .map(e -> storageService
                        .load(created + "/solution_content" + e.getId())
                        .resolve(e.getFilename()))
                .collect(Collectors.toList());
        List<Path> exercisePaths = exerciseContent.stream()
                .flatMap(Collection::stream)
                .filter(e -> e instanceof ExerciseTest)
                .map(e -> storageService
                        .load(created + "/exercise_content" + e.getId())
                        .resolve(e.getFilename()))
                .collect(Collectors.toList());
        paths.addAll(exercisePaths);
        return paths;
    }

    private List<Path> getPublicBlackBoxPaths(List<SolutionTest> solutionTests, List<ExerciseSwitcher> exerciseSwitchers, List<ExerciseSource> exerciseSources, String created) {
        List<Path> paths = new ArrayList<>();
        solutionTests.forEach(solutionTest -> {
            paths.add(storageService
                    .load(created + "/solution_content" + solutionTest.getId())
                    .resolve(solutionTest.getFilename()));
        });
        exerciseSwitchers.forEach(exerciseSwitcher -> {
            paths.add(storageService
                    .load(created + "/exercise_content" + exerciseSwitcher.getId())
                    .resolve(exerciseSwitcher.getFilename()));
        });
        exerciseSources.forEach(exerciseSource -> {
            paths.add(storageService
                    .load(created + "/exercise_content" + exerciseSource.getId())
                    .resolve(exerciseSource.getFilename()));
        });

        return paths;
    }

    private List<Path> getPrivateBlackBoxPaths(List<ExerciseTest> exerciseTests, List<ExerciseSwitcher> exerciseSwitchers, List<ExerciseSource> exerciseSources) {
        List<Path> paths = new ArrayList<>();
        exerciseTests.forEach(exerciseTest -> {
            paths.add(storageService
                    .load("exercise_content" + exerciseTest.getId())
                    .resolve(exerciseTest.getFilename()));
        });
        exerciseSwitchers.forEach(exerciseSwitcher -> {
            paths.add(storageService
                    .load("exercise_content" + exerciseSwitcher.getId())
                    .resolve(exerciseSwitcher.getFilename()));
        });
        exerciseSources.forEach(exerciseSource -> {
            paths.add(storageService
                    .load("exercise_content" + exerciseSource.getId())
                    .resolve(exerciseSource.getFilename()));
        });

        return paths;
    }

    private void compileFiles(List<Path> filesPaths, Path outDirPath) throws CompilationFailedException {
        try {
            Compiler.compile(filesPaths, outDirPath);
        } catch (CompilationFailedException e) {
            throw new CompilationFailedException(e.getMessage());
        }
        System.out.println("compiled");
    }

    private List<Result> testPublicFiles(List<List<? extends SolutionContent>> solutionContents, Path outDirPath) throws TestFailedException {
        List<Result> solutionTestsResults = new ArrayList<>();
        for (List<? extends SolutionContent> solutionContentList : solutionContents) {
            for (SolutionContent solutionContent : solutionContentList){
                if (!solutionContent.getClass().equals(SolutionTest.class)) continue;
                try {
                    solutionTestsResults.add(Tester.test(outDirPath, solutionContent.getFilename()));
                } catch (TestFailedException e) {
                    throw new TestFailedException(e.getMessage());
                }
            }
        }
        System.out.println("tested");
        return solutionTestsResults;
    }

    private List<Result> testPrivateFiles(List<List<? extends ExerciseContent>> exerciseContents, Path outDirPath) throws TestFailedException {
        List<Result> solutionTestsResults = new ArrayList<>();
        for (List<? extends ExerciseContent> exerciseContentList : exerciseContents) {
            for (ExerciseContent exerciseContent : exerciseContentList){
                if (!exerciseContent.getClass().equals(ExerciseTest.class)) continue;
                try {
                    solutionTestsResults.add(Tester.test(outDirPath, exerciseContent.getFilename()));
                } catch (TestFailedException e) {
                    throw new TestFailedException(e.getMessage());
                }
            }
        }
        System.out.println("tested");
        return solutionTestsResults;
    }

    private void removeTempFiles() {
        storageService.deleteAll(); // clean upload-dir
        storageService.init();
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
