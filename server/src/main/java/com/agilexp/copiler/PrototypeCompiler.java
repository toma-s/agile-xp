package com.agilexp.copiler;

import com.agilexp.model.TaskContent;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;

import javax.tools.*;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Objects;


public class PrototypeCompiler {

    public static Result compile(TaskContent taskContent, Path taskDirectoryPath) throws IOException {
        File taskDirectory = taskDirectoryPath.toFile();
        System.out.println("taskDirectoryPath: " + taskDirectoryPath.toString());
        ArrayList<File> filesToCompile = new ArrayList<>();
        for (File file : Objects.requireNonNull(taskDirectory.listFiles())) {
            if (file.isFile()) {
                filesToCompile.add(file);
            }
        }

        Path outDirectoryPath = taskDirectoryPath.resolve("out");
        System.out.println("outDirectoryPath: " + outDirectoryPath.toString());
        File outDirectory = outDirectoryPath.toFile();
        if (outDirectory.exists()) {
            for (File file : Objects.requireNonNull(outDirectory.listFiles())) {
                if (file != null) {
                    file.delete();
                }
            }
        } else {
            Files.createDirectory(outDirectoryPath);
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
            throw new IOException("Could not compile files");
        }

        URL outUrl = outDirectory.toURI().toURL();
        URL[] outUrls = {outUrl};
        ClassLoader classLoader = new URLClassLoader(outUrls);

        Class<?> junitTest = null;
        try {
            junitTest = Class.forName(taskContent.getTestFilename(), true, classLoader);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        JUnitCore junit = new JUnitCore();

        return junit.run(junitTest);
    }
}
