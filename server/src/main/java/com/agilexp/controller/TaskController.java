package com.agilexp.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Optional;
import java.util.stream.Collectors;

import com.agilexp.copiler.CompilerTester;
import com.agilexp.model.TaskContent;
import com.agilexp.model.TaskData;
import com.agilexp.repository.TaskRepository;
import com.agilexp.storage.StorageFileNotFoundException;
import com.agilexp.storage.StorageService;
import org.junit.runner.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;


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

    @GetMapping("/")
    public String listUploadedFiles(Model model) throws IOException {

        System.out.println("*here: listUploadedFiles");

        model.addAttribute("files", storageService.loadAll().map(
                path -> MvcUriComponentsBuilder.fromMethodName(TaskController.class,
                        "serveFile", path.getFileName().toString()).build().toString())
                .collect(Collectors.toList()));

        return "uploadForm";
    }

    @GetMapping("/files/{filename:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveFile(@PathVariable String filename) {

        System.out.println("*here: serveFile");

        Resource file = storageService.loadAsResource(filename);
        return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
                "attachment; filename=\"" + file.getFilename() + "\"").body(file);
    }

    @PostMapping(value = "/tasks/create")
    public TaskData handleFileUpload(@RequestBody TaskContent taskContent) throws IOException {

        TaskData taskData = saveToDB(taskContent);

        Path taskDirectoryPath = storageService.load("task" + taskContent.getId());
        CompilerTester compiler = new CompilerTester(taskContent, taskDirectoryPath);
        compiler.compile();
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

            System.out.println("Result:");
            System.out.println("Run Time:" + updTaskData.getResultRunTime());
            System.out.println("Successful:" + updTaskData.getResultSuccessful());
            System.out.println("Run Count:" + updTaskData.getResultRunCount());
            System.out.println("Failures Count:" + updTaskData.getResultFailureCount());
            System.out.println("Failures:" + updTaskData.getResultFailures());
            System.out.println("Ignore Count:" + updTaskData.getResultIgnoreCount());
        }
    }


    @ExceptionHandler(StorageFileNotFoundException.class)
    public ResponseEntity<?> handleStorageFileNotFound(StorageFileNotFoundException exc) {
        return ResponseEntity.notFound().build();
    }

}
