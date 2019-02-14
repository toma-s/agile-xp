package com.agilexp.controller;

import java.nio.file.Path;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import com.agilexp.compiler.CompilerTester;
import com.agilexp.model.TaskContent;
import com.agilexp.model.TaskData;
import com.agilexp.repository.TaskRepository;
import com.agilexp.storage.StorageFileNotFoundException;
import com.agilexp.storage.StorageService;
import org.junit.runner.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
    public ResponseEntity<String> createTask(@RequestBody TaskContent taskContent) {
        if (taskContent == null || taskContent.isEmpty()) {{
            return new ResponseEntity<>("Content can't be empty", HttpStatus.BAD_REQUEST);
        }}

        Long taskId = saveToDB(taskContent);
        TaskData taskData = new TaskData(taskId);

        storageService.store(taskContent, taskId);

        Path taskDirectoryPath = storageService.load("task" + taskId);
        CompilerTester compiler = new CompilerTester(taskContent, taskDirectoryPath);

        String compileMessage = compiler.compile();
        if (! compileMessage.equals("Compiled successfully")) {
            removeFromDB(taskData);
            return new ResponseEntity<>("Compilation failed: " + compileMessage, HttpStatus.BAD_REQUEST);
        }

        taskData.setCompileSuccessful(true);
        taskData.setCompileMessage(compileMessage);

        Class<?> junitTest = compiler.getJunit();
        if (junitTest == null) {
            removeFromDB(taskData);
            return new ResponseEntity<>("Junit test creation failed", HttpStatus.BAD_REQUEST);
        }

        Result result = compiler.runTests(junitTest);

        if (updateInDB(taskData, result) == null) {
            removeFromDB(taskData);
            return new ResponseEntity<>("Saving to the DB failed", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(String.valueOf(taskData.getId()), HttpStatus.OK);
    }

    private Long saveToDB(TaskContent taskContent) {
        Date date = new Date();
        Timestamp timestamp = new Timestamp(date.getTime());
        TaskData taskData = repository.save(new TaskData(taskContent.getSourceFilename(), taskContent.getTestFilename(), timestamp));
        return taskData.getId();
    }

    private TaskData updateInDB(TaskData taskData, Result result) {
        Optional<TaskData> origTaskData = repository.findById(taskData.getId());
        TaskData updTaskData;
        if (origTaskData.isPresent()) {
            updTaskData = origTaskData.get();
            updTaskData.setCompileSuccessful(taskData.getCompileSuccessful());
            updTaskData.setCompileMessage(taskData.getCompileMessage());
            updTaskData.setResultRunTime(result.getRunTime());
            updTaskData.setResultSuccessful(result.wasSuccessful());
            updTaskData.setResultRunCount(result.getRunCount());
            updTaskData.setResultFailuresCount(result.getFailureCount());
            updTaskData.setResultFailures(result.getFailures());
            updTaskData.setResultIgnoreCount(result.getIgnoreCount());
            return repository.save(updTaskData);
        }
        return null;
    }

    private void removeFromDB(TaskData taskData) {
        repository.deleteById(taskData.getId());
    }

    @PostMapping(value="/tasks/task-{id}")
    public TaskData getTaskById(@PathVariable("id") String id) {
        Long idL = Long.parseLong(id);
        Optional<TaskData> taskDataOptional = repository.findById(idL);
        return taskDataOptional.orElse(null);
    }

    @ExceptionHandler(StorageFileNotFoundException.class)
    public ResponseEntity<?> handleStorageFileNotFound(StorageFileNotFoundException exc) {
        return ResponseEntity.notFound().build();
    }

}
