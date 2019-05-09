package com.tester;

import com.tester.compiler.Compiler;
import com.tester.compiler.exception.CompilationFailedException;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {

    public static void main(String[] args) {

        String mode = args[0];
        System.out.println(mode);

        String result = "";

        switch (mode) {
            case "whitebox-file": {
                result = estimateSourceTestFile();
            }
        }

        System.out.println(result);
    }

    private static String estimateSourceTestFile() {
        System.out.println("Public estimation");
        String publicEstimation = estimatePublic();
        return String.format("Solved, Estimation: %s",
                publicEstimation);
    }

    private static String estimatePublic() {
        try {
            compileFiles();
        } catch (CompilationFailedException e) {
            return "Compilation failed: \n" + e.getMessage();
        }
        return "Compiled successfully";
    }

    private static void compileFiles() throws CompilationFailedException {
        try {
            System.out.println("Files compilation");
            List<Path> filePaths = getFilePaths();
            System.out.println(filePaths);

            Path outDirectory = Paths.get("");
            System.out.println(outDirectory.toAbsolutePath().toFile().exists());
            System.out.println(outDirectory.toAbsolutePath());

            Path out = outDirectory.resolve("out");
            boolean mkdir = out.toFile().mkdir();
            System.out.println(mkdir);
            System.out.println(out.toAbsolutePath().toFile().exists());
            System.out.println(out.toAbsolutePath());

            Compiler.compile(filePaths, outDirectory);
        } catch (CompilationFailedException e) {
            throw new CompilationFailedException(e.getMessage());
        }
    }

    private static List<Path> getFilePaths() {
        List<Path> filePaths = new ArrayList<>();
        String[] directories = new String[] {
                "solution_source",
                "solution_test"};
        for (String directory : directories) {
            File directoryFile = Paths.get(directory).toFile();
            System.out.println(Paths.get(directory).toAbsolutePath());
            System.out.println(directoryFile.getName());
            System.out.println(directoryFile.exists());
            File[] dirListing = directoryFile.listFiles();
            System.out.println("dirListing: " + Arrays.toString(dirListing));
            if (dirListing != null) {
                for (File file : dirListing) {
                    filePaths.add(file.toPath());
                    System.out.println("File path: " + file.toPath());
                }
            }
        }

        return filePaths;
    }
}
