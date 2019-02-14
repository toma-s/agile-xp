package com.agilexp.compiler;

import com.agilexp.model.TaskContent;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;

import javax.tools.*;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Objects;


public class CompilerTester {

    private Path taskDirectoryPath;
    private TaskContent content;
    private ArrayList<File> filesToCompile = new ArrayList<>();
    private File outDirectory;

    public CompilerTester(TaskContent content, Path taskDirectoryPath) {
        this.content = content;
        this.taskDirectoryPath = taskDirectoryPath;
    }

    public String compile() {

        String message = "Compiled successfully";

        File taskDirectory = this.taskDirectoryPath.toFile();
        for (File file : Objects.requireNonNull(taskDirectory.listFiles())) {
            if (file.isFile()) {
                this.filesToCompile.add(file);
            }
        }

        Path outDirectoryPath = this.taskDirectoryPath.resolve("out");
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
                    fileManager.getJavaFileObjectsFromFiles(this.filesToCompile);

            final Iterable<String> options = Arrays.asList("-d", this.taskDirectoryPath.resolve("out").toString());

            compiler.getTask(null, fileManager, null, options, null, compilationUnits).call();
            for (Diagnostic diagnostic: diagnostics.getDiagnostics()) {
                message = String.format("Error on line %d in %s",
                        diagnostic.getLineNumber(),
                        diagnostic.getSource().toString());
                System.out.format("Error on line %d in %s",
                        diagnostic.getLineNumber(),
                        diagnostic.getSource().toString());
            }

            fileManager.close();
        } catch (IOException io) {
            io.printStackTrace();
        }

        return message;
    }

    public Class<?> getJunit() {
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
        } catch (ClassNotFoundException | NullPointerException e) {
            e.printStackTrace();
        }

        return junitTest;
    }

    public Result runTests(Class<?> junitTest) {
        JUnitCore junit = new JUnitCore();
        return junit.run(junitTest);
    }
}
