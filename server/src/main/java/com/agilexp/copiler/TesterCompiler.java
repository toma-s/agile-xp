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


public class TesterCompiler {

    private Long id;
    private File taskDirectory;
    private Path taskDirectoryPath;
    private String state;
    private String msg = "";
    private TaskContent content;
    private ArrayList<File> filesToCompile = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public TesterCompiler() {
        this.id = Application.createId();
        Calendar cal = Calendar.getInstance();
        msg = "No compille";
        state = "Start";
    }

    public void setTask(TaskContent content, Path taskDirectoryPath) {
        this.content = content;
        this.taskDirectoryPath = taskDirectoryPath;
        this.taskDirectory = this.taskDirectoryPath.toFile();
        System.out.println("* taskDirectoryPath: " + taskDirectoryPath.toString());
        System.out.println("* taskDirectory: " + taskDirectory.toString());
    }

    public void createTaskFiles() {
        Path sourceFilePath = this.taskDirectoryPath.resolve(content.getSourceFilename());
        Path testFilePath = this.taskDirectoryPath.resolve(content.getTestFilename());

        File sourceFile = null;
        File testFile = null;

        try {
            sourceFile =  Files.createFile(sourceFilePath).toFile();
            testFile = Files.createFile(testFilePath).toFile();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (sourceFile != null && testFile != null) {
                write(sourceFile, content.getSourceCode());
                write(testFile, content.getTestCode());
                filesToCompile.add(sourceFile);
                filesToCompile.add(testFile);
            }
        }

    }

    private void write(File file, String content) {
        FileWriter writer = null;

        try {
            writer = new FileWriter(file);
            writer.write(content);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (writer != null) {
                    writer.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public Result compile() throws IOException {

        Path outDirectoryPath = this.taskDirectoryPath.resolve("out");
        System.out.println("outDirectoryPath: " + outDirectoryPath.toString());
        File outDirectory = outDirectoryPath.toFile();
        Files.createDirectory(outDirectoryPath);

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
            throw new IOException("Could not compile files");
        }

        URL outUrl = outDirectory.toURI().toURL();
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
