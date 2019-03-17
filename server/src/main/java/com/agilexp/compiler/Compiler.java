package com.agilexp.compiler;

import com.agilexp.compiler.exception.CompilationFailedException;

import javax.tools.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class Compiler {

    public static void compile(List<Path> filePaths, Path outDir) throws CompilationFailedException {
        try {
            JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
            DiagnosticCollector<JavaFileObject> diagnostics = new DiagnosticCollector<>();
            StandardJavaFileManager fileManager = compiler.getStandardFileManager(diagnostics, null, null);
            Iterable<? extends JavaFileObject> compilationUnits = fileManager.getJavaFileObjectsFromFiles(getFiles(filePaths));
            final Iterable<String> options = Arrays.asList("-d", outDir.resolve("out").toString());
            compiler.getTask(null, fileManager, null, options, null, compilationUnits).call();
            if (! diagnostics.getDiagnostics().isEmpty()) {
                StringBuilder message = new StringBuilder();
                for (Diagnostic diagnostic: diagnostics.getDiagnostics()) {
                    message.append(String.format("Error on line %d in %s",
                            diagnostic.getLineNumber(),
                            diagnostic.getSource().toString()));
                }
                throw new CompilationFailedException(message.toString());
            }

            fileManager.close();
        } catch (IOException io) {
            io.printStackTrace();
            throw new CompilationFailedException(io.getMessage());
        }
    }

    private static List<File> getFiles(List<Path> filePaths) {
        return filePaths.stream().map(Path::toFile).collect(Collectors.toList());
    }

}
