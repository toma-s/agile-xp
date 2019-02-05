package com.prototype.controller;

import java.io.IOException;
import java.nio.file.Path;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Optional;
import java.util.stream.Collectors;

import com.prototype.copiler.PrototypeCompiler;
import com.prototype.model.TaskContent;
import com.prototype.model.TaskData;
import com.prototype.repository.TaskRepository;
import com.prototype.storage.StorageFileNotFoundException;
import com.prototype.storage.StorageService;
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

        model.addAttribute("files", storageService.loadAll().map(
                path -> MvcUriComponentsBuilder.fromMethodName(TaskController.class,
                        "serveFile", path.getFileName().toString()).build().toString())
                .collect(Collectors.toList()));

        return "uploadForm";
    }

    @GetMapping("/files/{filename:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveFile(@PathVariable String filename) {

        Resource file = storageService.loadAsResource(filename);
        return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
                "attachment; filename=\"" + file.getFilename() + "\"").body(file);
    }

    @PostMapping(value = "/tasks/create")
    public TaskContent handleFileUpload(@RequestBody TaskContent taskContent) throws IOException {


        // save result to DB
        Date date = new Date();
        Timestamp timestamp = new Timestamp(date.getTime());
        TaskData taskData = repository.save(new TaskData(taskContent.getSourceFilename(), taskContent.getTestFilename(), timestamp));
        taskContent.setId(taskData.getId());

        // save files: source and test
//        System.out.println("Id: " + taskContent.getId());
//        System.out.println("Source filename: " + taskContent.getSourceFilename());
//        System.out.println("Test filename: " + taskContent.getTestFilename());
//        System.out.println("Source code: " + taskContent.getSourceCode());
//        System.out.println("Test code: " + taskContent.getTestCode());
        storageService.store(taskContent);

        // test code
        Path taskDirectoryPath = storageService.load("task" + taskData.getId());
        Result result = PrototypeCompiler.compile(taskContent, taskDirectoryPath);

        // update in DB
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

        return taskContent;
    }

    @ExceptionHandler(StorageFileNotFoundException.class)
    public ResponseEntity<?> handleStorageFileNotFound(StorageFileNotFoundException exc) {
        return ResponseEntity.notFound().build();
    }

}
