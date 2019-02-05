package com.agilexp.copiler;

import com.agilexp.Application;
import com.agilexp.model.TaskContent;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;

import javax.tools.*;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Objects;


public class CompilerTester {

    private Long id;
    private Path taskDirectoryPath;
    private TaskContent content;
    private ArrayList<File> filesToCompile = new ArrayList<>();
    private File outDirectory;

    public CompilerTester(TaskContent content, Path taskDirectoryPath) {
        this.content = content;
        this.taskDirectoryPath = taskDirectoryPath;
    }

    public void compile() {

        File taskDirectory = taskDirectoryPath.toFile();
        System.out.println("taskDirectoryPath: " + taskDirectoryPath.toString());
        for (File file : Objects.requireNonNull(taskDirectory.listFiles())) {
            if (file.isFile()) {
                this.filesToCompile.add(file);
            }
        }

        Path outDirectoryPath = this.taskDirectoryPath.resolve("out");
        System.out.println("outDirectoryPath: " + outDirectoryPath.toString());
        this.outDirectory = outDirectoryPath.toFile();
        try {
            Files.createDirectory(outDirectoryPath);
        } catch (IOException e) {
            e.printStackTrace();
        }

        try {
            JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
            DiagnosticCollector<JavaFileObject> diagnostics = new DiagnosticCollector<>();
            StandardJavaFileManager fileManager = compiler.getStandardFileManager(diagnostics, null, null);
            Iterable<? extends JavaFileObject> compilationUnits =
                    fileManager.getJavaFileObjectsFromFiles(filesToCompile);

            final Iterable<String> options = Arrays.asList("-d", taskDirectoryPath.resolve("out").toString());

            compiler.getTask(null, fileManager, null, options, null, compilationUnits).call();
            for (Diagnostic diagnostic: diagnostics.getDiagnostics()) {
                System.out.format("Error on line %d in %s",
                        diagnostic.getLineNumber(),
                        diagnostic.getSource().toString());
            }

            fileManager.close();
        } catch (IOException io) {
            io.printStackTrace();
        }

    }

    public Result runTests() {
        URL outUrl = null;
        try {
            outUrl = this.outDirectory.toURI().toURL();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        URL[] outUrls = {outUrl};
        ClassLoader classLoader = new URLClassLoader(outUrls);

        Class<?> junitTest = null;
        try {
            junitTest = Class.forName(this.content.getTestFilename().substring(0, this.content.getTestFilename().lastIndexOf('.')), true, classLoader);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        JUnitCore junit = new JUnitCore();

        return junit.run(junitTest);
    }
}
