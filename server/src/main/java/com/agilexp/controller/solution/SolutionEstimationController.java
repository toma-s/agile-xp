package com.agilexp.controller.solution;

import com.agilexp.compiler.Compiler;
import com.agilexp.compiler.exception.CompilationFailedException;
import com.agilexp.dbmodel.exercise.ExerciseContent;
import com.agilexp.dbmodel.exercise.PrivateFile;
import com.agilexp.dbmodel.exercise.PrivateSource;
import com.agilexp.dbmodel.exercise.PrivateTest;
import com.agilexp.dbmodel.solution.*;
import com.agilexp.model.ExerciseFlags;
import com.agilexp.model.ExerciseSwitcher;
import com.agilexp.model.SolutionItems;
import com.agilexp.repository.exercise.BugsNumberRepository;
import com.agilexp.repository.exercise.PrivateFileRepository;
import com.agilexp.repository.exercise.PrivateSourceRepository;
import com.agilexp.repository.exercise.PrivateTestRepository;
import com.agilexp.repository.solution.*;
import com.agilexp.storage.StorageException;
import com.agilexp.storage.StorageService;
import com.agilexp.tester.Tester;
import com.agilexp.tester.exception.TestFailedException;
import javafx.util.Pair;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.util.*;
import java.util.stream.Collectors;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionEstimationController {
    @Autowired private SolutionEstimationRepository repository;
    @Autowired private PrivateSourceRepository privateSourceRepository;
    @Autowired private PrivateTestRepository privateTestRepository;
    @Autowired private PrivateFileRepository privateFileRepository;
    @Autowired private BugsNumberRepository bugsNumberRepository;
    @Autowired private SolutionRepository solutionRepository;
    @Autowired private SolutionSourceRepository solutionSourceRepository;
    @Autowired private SolutionTestRepository solutionTestRepository;
    @Autowired private SolutionFileRepository solutionFileRepository;

    private final StorageService storageService;

    private final String PUBLIC = "Public";
    private final String PRIVATE = "Private";

    @Autowired
    public SolutionEstimationController(StorageService storageService) {
        this.storageService = storageService;
    }

    @GetMapping(value = "/solution-estimation/estimate/whitebox")
    public SolutionEstimation getWhiteboxEstimation(@RequestBody SolutionItems solutionItems) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());

        SolutionEstimation solutionEstimation = new SolutionEstimation(solutionItems.getSolutionId());

        Pair<Boolean, String> estimation = estimateSourceTest(solutionItems);
        solutionEstimation.setSolved(estimation.getKey());
        solutionEstimation.setEstimation(estimation.getValue());
        solutionEstimation.setCreated(created);

        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s\n", _solutionEstimation);
        return _solutionEstimation;
    }

    private Pair<Boolean, String> estimateSourceTest(SolutionItems solutionItems) {
        String directoryName = "12345";

        long exerciseId = solutionItems.getExerciseId();
        List<SolutionSource> solutionSources = solutionItems.getSolutionSources();
        List<SolutionTest> solutionTests = solutionItems.getSolutionTests();
        List<PrivateTest> privateTests = privateTestRepository.findPrivateTestsByExerciseId(exerciseId);

        List<List<? extends SolutionContent>> solutionContents = List.of(solutionSources, solutionTests);
        List<List<? extends ExerciseContent>> exerciseContents = List.of(privateTests);

        Path outDirPath = storageService.load(directoryName + "/solution_public");
        Pair<Boolean, String> publicEstimation = estimatePublic(solutionContents, outDirPath, directoryName);
        Pair<Boolean, String> privateEstimation = estimatePrivate(solutionContents, exerciseContents, outDirPath, directoryName);
        boolean solved = publicEstimation.getKey() && privateEstimation.getKey();
        return new Pair<>(solved, publicEstimation.getValue() + "\n\n" + privateEstimation.getValue());
    }

    @PostMapping(value = "/solution-estimation/estimate/whitebox-file")
    public SolutionEstimation getWhiteboxFileEstimation(@RequestBody SolutionItems solutionItems) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());

        SolutionEstimation solutionEstimation = new SolutionEstimation(solutionItems.getSolutionId());

        Pair<Boolean, String> estimation = estimateSourceTestFile(solutionItems);
        solutionEstimation.setSolved(estimation.getKey());
        solutionEstimation.setEstimation(estimation.getValue());
        solutionEstimation.setCreated(created);

        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s\n", _solutionEstimation);
        return _solutionEstimation;
    }

    private Pair<Boolean, String> estimateSourceTestFile(SolutionItems solutionItems) {
        String directoryName = "12345";

        long exerciseId = solutionItems.getExerciseId();
        List<SolutionSource> solutionSources = solutionItems.getSolutionSources();
        List<SolutionTest> solutionTests = solutionItems.getSolutionTests();
        List<SolutionFile> solutionFiles = solutionItems.getSolutionFiles();
        List<PrivateTest> privateTests = privateTestRepository.findPrivateTestsByExerciseId(exerciseId);
//      privateFileRepository.findExerciseFilesByExerciseId(exerciseId)
//      TODO: 02-Apr-19 exerciseFiles when solutionFiles work completely

        List<List<? extends SolutionContent>> solutionContents = List.of(solutionSources, solutionTests, solutionFiles);
        List<List<? extends ExerciseContent>> exerciseContents = List.of(privateTests);

        Path outDirPath = storageService.load(directoryName + "/solution_private");
        Pair<Boolean, String> publicEstimation = estimatePublic(solutionContents, outDirPath, directoryName);
        Pair<Boolean, String> privateEstimation = estimatePrivate(solutionContents, exerciseContents, outDirPath, directoryName);
        boolean solved = publicEstimation.getKey() && privateEstimation.getKey();
        return new Pair<>(solved, publicEstimation.getValue() + "\n\n" + privateEstimation.getValue());
    }


    private Pair<Boolean, String> estimatePublic(List<List<? extends SolutionContent>> solutionContents, Path outDirPath, String created) {
        try {
            storeFiles(solutionContents, List.of(), created);

//            copyDefault(created);

//            run(created);

            List<Path> paths = getPublicPaths(solutionContents, created);
            compileFiles(paths, outDirPath);
            List<Result> testResults = testPublicFiles(solutionContents, outDirPath);
            boolean solved = isSolved(testResults);
            removeTempFiles();
            return new Pair<>(solved, getResult(testResults, PUBLIC));
        } catch (StorageException e) {
            e.printStackTrace();
            return new Pair<>(false, "File storing failed: \n" + e.getMessage());
        } catch (CompilationFailedException e) {
            e.printStackTrace();
            return new Pair<>(false, "Compilation failed: \n" + e.getMessage());
        } catch (TestFailedException e) {
            e.printStackTrace();
            return new Pair<>(false, "Tests run failed: \n" + e.getMessage());
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

    private Pair<Boolean, String> estimatePrivate(List<List<? extends SolutionContent>> solutionContents, List<List<? extends ExerciseContent>> exerciseContents, Path outDirPath, String created) {
        try {
            storeFiles(solutionContents, exerciseContents, created);
            List<Path> paths = getPrivatePaths(solutionContents, exerciseContents, created);
            compileFiles(paths, outDirPath);
            List<Result> testResults = testPrivateFiles(exerciseContents, outDirPath);
            removeTempFiles();
            boolean solved = isSolved(testResults);
            return new Pair<>(solved, getResult(testResults, PRIVATE));
        } catch (StorageException e) {
            e.printStackTrace();
            return new Pair<>(false, "File storing failed: " + e.getMessage());
        } catch (CompilationFailedException e) {
            e.printStackTrace();
            return new Pair<>(false, "Compilation failed: " + e.getMessage());
        } catch (TestFailedException e) {
            e.printStackTrace();
            return new Pair<>(false, "Tests run failed: " + e.getMessage());
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

    @GetMapping(value = "/solution-estimation/estimate/blackbox")
    public SolutionEstimation getBlackboxEstimation(@RequestBody SolutionItems solutionItems) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());

        SolutionEstimation solutionEstimation = new SolutionEstimation(solutionItems.getSolutionId());

        Pair<Boolean, String> estimation = estimateBlackBox(solutionItems);
        solutionEstimation.setSolved(estimation.getKey());
        solutionEstimation.setEstimation(estimation.getValue());
        solutionEstimation.setCreated(created);

        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s\n", _solutionEstimation);
        return _solutionEstimation;
    }

    private Pair<Boolean, String> estimateBlackBox(SolutionItems solutionItems) {
        String directoryName = "12345";

        long exerciseId = solutionItems.getExerciseId();
        List<SolutionTest> solutionTests = solutionItems.getSolutionTests();
        List<PrivateSource> privateSources = privateSourceRepository.findPrivateSourcesByExerciseId(exerciseId);
        List<ExerciseSwitcher> exerciseSwitchers = getExerciseSwitchers();
        int bugsNum = bugsNumberRepository.findBugsNumberByExerciseId(exerciseId).getNumber();
        List<ExerciseFlags> exerciseFlags = getExerciseFlags(bugsNum);
        ExerciseFlags controllingFlags = getControllingFlags(bugsNum);
        Path outDirPath = storageService.load(directoryName + "/solution_public_blackbox");

        try {
            int bugsFound = 0;
            for (int i = 0; i < bugsNum; i++) {
                storeFiles(List.of(solutionTests), List.of(privateSources, exerciseSwitchers, List.of(exerciseFlags.get(i))), directoryName);
                List<Path> paths = getPublicBlackBoxPaths(solutionTests, exerciseSwitchers, privateSources, directoryName);
                compileFiles(paths, outDirPath);
                List<Result> testResults = testPublicFiles(List.of(solutionTests), outDirPath);
                removeTempFiles();

                storeFiles(List.of(solutionTests), List.of(privateSources, exerciseSwitchers, List.of(controllingFlags)), directoryName);
                List<Path> controllingPaths = getPublicBlackBoxPaths(solutionTests, exerciseSwitchers, privateSources, directoryName);
                compileFiles(controllingPaths, outDirPath);
                List<Result> controllingTestResults = testPublicFiles(List.of(solutionTests), outDirPath);
                removeTempFiles();

                if (bugWasFound(testResults, controllingTestResults)) {
                    bugsFound++;
                }
            }
            boolean solved = bugsFound == bugsNum;
            return new Pair<>(solved, String.format("Bugs found: %s / %s", bugsFound, bugsNum));
        } catch (StorageException e) {
            e.printStackTrace();
            return new Pair<>(false, "File storing failed: \n" + e.getMessage());
        } catch (CompilationFailedException e) {
            e.printStackTrace();
            return new Pair<>(false, "Compilation failed: \n" + e.getMessage());
        } catch (TestFailedException e) {
            e.printStackTrace();
            return new Pair<>(false, "Tests run failed: \n" + e.getMessage());
        }
    }

    @GetMapping(value = "/solution-estimation/estimate/blackbox-file")
    public SolutionEstimation getSolutionTestFileEstimation(@RequestBody SolutionItems solutionItems) {
        Date date = new Date();
        Timestamp created = new Timestamp(date.getTime());

        SolutionEstimation solutionEstimation = new SolutionEstimation(solutionItems.getSolutionId());

        Pair<Boolean, String> estimation = estimateTestFile(solutionItems);
        solutionEstimation.setSolved(estimation.getKey());
        solutionEstimation.setEstimation(estimation.getValue());
        solutionEstimation.setCreated(created);

        SolutionEstimation _solutionEstimation = repository.save(solutionEstimation);
        System.out.format("Created solution estimation %s\n", _solutionEstimation);
        return _solutionEstimation;
    }

    private Pair<Boolean, String> estimateTestFile(SolutionItems solutionItems) {
        String directoryName = "12345";

        long exerciseId = solutionItems.getExerciseId();
        List<SolutionTest> solutionTests = solutionItems.getSolutionTests();
        List<SolutionFile> solutionFiles = solutionItems.getSolutionFiles();
        List<PrivateSource> privateSources = privateSourceRepository.findPrivateSourcesByExerciseId(exerciseId);
        List<PrivateFile> privateFiles = privateFileRepository.findPrivateFilesByExerciseId(exerciseId);
        List<ExerciseSwitcher> exerciseSwitchers = getExerciseSwitchers();
        int bugsNum = bugsNumberRepository.findBugsNumberByExerciseId(exerciseId).getNumber();
        List<ExerciseFlags> exerciseFlags = getExerciseFlags(bugsNum);
        ExerciseFlags controllingFlags = getControllingFlags(bugsNum);
        Path outDirPath = storageService.load(directoryName + "/solution_public_blackbox");

        try {
            int bugsFound = 0;
            for (int i = 0; i < bugsNum; i++) {
                storeFiles(List.of(solutionTests, solutionFiles), List.of(privateSources, exerciseSwitchers, List.of(exerciseFlags.get(i))), directoryName);
                List<Path> paths = getPublicBlackBoxPaths(solutionTests, exerciseSwitchers, privateSources, directoryName);
                compileFiles(paths, outDirPath);
                List<Result> testResults = testPublicFiles(List.of(solutionTests), outDirPath);
                removeTempFiles();

                storeFiles(List.of(solutionTests), List.of(privateSources, privateFiles, exerciseSwitchers, List.of(controllingFlags)), directoryName);
                List<Path> controllingPaths = getPublicBlackBoxPaths(solutionTests, exerciseSwitchers, privateSources, directoryName);
                compileFiles(controllingPaths, outDirPath);
                List<Result> controllingTestResults = testPublicFiles(List.of(solutionTests), outDirPath);
                removeTempFiles();

                if (bugWasFound(testResults, controllingTestResults)) {
                    bugsFound++;
                }
            }
            boolean solved = bugsFound == bugsNum;
            return new Pair<>(solved, String.format("Bugs found: %s / %s", bugsFound, bugsNum));
        } catch (StorageException e) {
            e.printStackTrace();
            return new Pair<>(false, "File storing failed: " + e.getMessage());
        } catch (CompilationFailedException e) {
            e.printStackTrace();
            return new Pair<>(false, "Compilation failed: " + e.getMessage());
        } catch (TestFailedException e) {
            e.printStackTrace();
            return new Pair<>(false, "Tests run failed: " + e.getMessage());
        }
    }

    private boolean bugWasFound(List<Result> testResults, List<Result> controllingTestResults) {
        int resultFailures = 0;
        int controllingResultFailures = 0;
        for (int j = 0; j < testResults.size(); j++) {
            Result result = testResults.get(j);
            Result controllingResult = controllingTestResults.get(j);
            resultFailures += result.getFailureCount();
            controllingResultFailures += controllingResult.getFailureCount();
        }
        if (resultFailures - controllingResultFailures >= 1) {
            return true;
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
                .filter(e -> e instanceof PrivateTest)
                .map(e -> storageService
                        .load(created + "/exercise_content" + e.getId())
                        .resolve(e.getFilename()))
                .collect(Collectors.toList());
        paths.addAll(exercisePaths);
        return paths;
    }

    private List<Path> getPublicBlackBoxPaths(List<SolutionTest> solutionTests, List<ExerciseSwitcher> exerciseSwitchers, List<PrivateSource> exerciseSources, String created) {
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
                if (!exerciseContent.getClass().equals(PrivateTest.class)) continue;
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

    private boolean isSolved(List<Result> results) {
        boolean solved = true;
        for (Result result : results)
            if (result.getFailureCount() != 0) {
                solved = false;
            }
        return solved;
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
                String detail = String.format(
                        "Test class: %s\nTest name: %s\nFailure cause: %s\n",
                        failure.getDescription().getClassName(),
                        failure.getDescription().getDisplayName(),
                        failure.getException().toString());
                output.append("\n").append(i + 1).append(") ").append(detail);
            }
        }
        output.append("\nIgnored count: ").append(result.getIgnoreCount());
        return output;
    }

    @GetMapping(value="/solution-estimation/exercise/{exerciseId}/source/{pageNumber}/{pageSize}")
    public List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeSource(
            @PathVariable("exerciseId") long exerciseId,
            @PathVariable("pageNumber") int pageNumber,
            @PathVariable("pageSize") int pageSize) {
        System.out.println("Get solution estimations with exercise id " + exerciseId + "...");

        Pageable pageable = PageRequest.of(pageNumber, pageSize);
        List<Solution> solutions = solutionRepository.findSolutionsByExerciseIdOrderByCreatedDesc(pageable, exerciseId);
        List<SolutionItems> solutionItems = new ArrayList<>();
        for (Solution solution : solutions) {
            SolutionItems newSolutionItems = new SolutionItems();
            List<SolutionSource> solutionSources = new ArrayList<>(solutionSourceRepository.findBySolutionId(solution.getId()));
            SolutionEstimation solutionEstimation = repository.findAllBySolutionId(solution.getId()).get(0);
            newSolutionItems.setSolutionId(solution.getId());
            newSolutionItems.setExerciseId(exerciseId);
            newSolutionItems.setSolutionSources(solutionSources);
            newSolutionItems.setCreated(solutionEstimation.getCreated());
            newSolutionItems.setEstimation(solutionEstimation.getEstimation());
            newSolutionItems.setSolved(solutionEstimation.isSolved());
            solutionItems.add(newSolutionItems);
        }

        System.out.format("Found solution items\n");
        return solutionItems;
    }

    @GetMapping(value="/solution-estimation/exercise/{exerciseId}/test/{pageNumber}/{pageSize}")
    public List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeTest(
            @PathVariable("exerciseId") long exerciseId,
            @PathVariable("pageNumber") int pageNumber,
            @PathVariable("pageSize") int pageSize) {
        System.out.println("Get solution estimations with exercise id " + exerciseId + "...");

        Pageable pageable = PageRequest.of(pageNumber, pageSize);
        List<Solution> solutions = solutionRepository.findSolutionsByExerciseIdOrderByCreatedDesc(pageable, exerciseId);
        List<SolutionItems> solutionItems = new ArrayList<>();
        for (Solution solution : solutions) {
            SolutionItems newSolutionItems = new SolutionItems();
            List<SolutionTest> solutionTests = new ArrayList<>(solutionTestRepository.findBySolutionId(solution.getId()));
            SolutionEstimation solutionEstimation = repository.findAllBySolutionId(solution.getId()).get(0);
            newSolutionItems.setSolutionId(solution.getId());
            newSolutionItems.setExerciseId(exerciseId);
            newSolutionItems.setSolutionTests(solutionTests);
            newSolutionItems.setCreated(solutionEstimation.getCreated());
            newSolutionItems.setEstimation(solutionEstimation.getEstimation());
            newSolutionItems.setSolved(solutionEstimation.isSolved());
            solutionItems.add(newSolutionItems);
        }

        System.out.format("Found solution items\n");
        return solutionItems;
    }

    @GetMapping(value="/solution-estimation/exercise/{exerciseId}/file/{pageNumber}/{pageSize}")
    public List<SolutionItems> getSolutionEstimationsByExerciseIdAndTypeFile(
            @PathVariable("exerciseId") long exerciseId,
            @PathVariable("pageNumber") int pageNumber,
            @PathVariable("pageSize") int pageSize) {
        System.out.println("Get solution estimations with exercise id " + exerciseId + "...");

        Pageable pageable = PageRequest.of(pageNumber, pageSize);
        List<Solution> solutions = solutionRepository.findSolutionsByExerciseIdOrderByCreatedDesc(pageable, exerciseId);
        List<SolutionItems> solutionItems = new ArrayList<>();
        for (Solution solution : solutions) {
            SolutionItems newSolutionItems = new SolutionItems();
            List<SolutionFile> solutionFiles = new ArrayList<>(solutionFileRepository.findBySolutionId(solution.getId()));
            SolutionEstimation solutionEstimation = repository.findAllBySolutionId(solution.getId()).get(0);
            newSolutionItems.setSolutionId(solution.getId());
            newSolutionItems.setExerciseId(exerciseId);
            newSolutionItems.setSolutionFiles(solutionFiles);
            newSolutionItems.setCreated(solutionEstimation.getCreated());
            newSolutionItems.setEstimation(solutionEstimation.getEstimation());
            newSolutionItems.setSolved(solutionEstimation.isSolved());
            solutionItems.add(newSolutionItems);
        }

        System.out.format("Found solution items\n");
        return solutionItems;
    }
}
