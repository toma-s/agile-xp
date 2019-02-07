package com.agilexp.controller;

import java.io.IOException;
import java.nio.file.Path;
import java.sql.Timestamp;
import java.util.*;

import com.agilexp.copiler.CompilerTester;
import com.agilexp.model.TaskContent;
import com.agilexp.model.TaskData;
import com.agilexp.repository.TaskRepository;
import com.agilexp.storage.StorageFileNotFoundException;
import com.agilexp.storage.StorageService;
import org.junit.runner.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class TaskController {
    @Autowired
    TaskRepository repository;

    private final StorageService storageService;

    @Autowired
    public TaskController(StorageService storageService) {
        this.storageService = storageService;
    }

    @GetMapping("/tasks")
    public List<TaskData> getAllTasks() {
        System.out.println("Get all tasks...");

        List<TaskData> tasks = new ArrayList<>();
        repository.findAll().forEach(tasks::add);

        return tasks;
    }

    @PostMapping(value = "/tasks/create")
    public TaskData handleFileUpload(@RequestBody TaskContent taskContent) throws IOException {

        TaskData taskData = saveToDB(taskContent);

        Path taskDirectoryPath = storageService.load("task" + taskContent.getId());
        CompilerTester compiler = new CompilerTester(taskContent, taskDirectoryPath);
        String compileMessage = compiler.compile();
        taskData.setCompileMessage(compileMessage);
        taskData.setCompileSuccessful(compileMessage.equals("Compiled successfully")); // todo fix hardcoded text
        Result result = compiler.runTests();

        updateInDB(taskData, result);

        return taskData;
    }

    private TaskData saveToDB(TaskContent taskContent) {
        Date date = new Date();
        Timestamp timestamp = new Timestamp(date.getTime());

        TaskData taskData = repository.save(new TaskData(taskContent.getSourceFilename(), taskContent.getTestFilename(), timestamp));
        taskContent.setId(taskData.getId());
        storageService.store(taskContent);
        return taskData;
    }

    private void updateInDB(TaskData taskData, Result result) {
        Optional<TaskData> origTaskData = repository.findById(taskData.getId());
        TaskData updTaskData;
        if (origTaskData.isPresent()) {
            updTaskData = origTaskData.get();
            updTaskData.setResultRunTime(result.getRunTime());
            updTaskData.setResultSuccessful(result.wasSuccessful());
            updTaskData.setResultRunCount(result.getRunCount());
            updTaskData.setResultFailuresCount(result.getFailureCount());
            updTaskData.setResultFailures(result.getFailures());
            updTaskData.setResultIgnoreCount(result.getIgnoreCount());
            repository.save(updTaskData);

            System.out.println("Compiled successfully: " + taskData.getCompileSuccessful());
            System.out.println("Compile message: " + taskData.getCompileMessage());
            System.out.println("Result:");
            System.out.println("Run Time: " + updTaskData.getResultRunTime());
            System.out.println("Successful: " + updTaskData.getResultSuccessful());
            System.out.println("Run Count: " + updTaskData.getResultRunCount());
            System.out.println("Failures Count: " + updTaskData.getResultFailureCount());
            System.out.println("Failures: " + updTaskData.getResultFailures());
            System.out.println("Ignore Count: " + updTaskData.getResultIgnoreCount());
        }
    }


    @ExceptionHandler(StorageFileNotFoundException.class)
    public ResponseEntity<?> handleStorageFileNotFound(StorageFileNotFoundException exc) {
        return ResponseEntity.notFound().build();
    }

}
