package com.agilexp.docker;

import com.spotify.docker.client.DefaultDockerClient;
import com.spotify.docker.client.DockerClient;
import com.spotify.docker.client.exceptions.DockerCertificateException;
import com.spotify.docker.client.exceptions.DockerException;
import com.spotify.docker.client.messages.ContainerConfig;
import com.spotify.docker.client.messages.ContainerCreation;
import com.spotify.docker.client.messages.ExecCreation;
import org.apache.commons.compress.archivers.ArchiveEntry;
import org.apache.commons.compress.archivers.tar.TarArchiveInputStream;
import org.apache.commons.io.IOUtils;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;

public class DockerController {

    private static DockerClient dockerClient;

    static {
        try {
            dockerClient = DefaultDockerClient.fromEnv().connectionPoolSize(100).build();
        } catch (DockerCertificateException e) {
            e.printStackTrace();
        }
    }

    public static String buildImage(Path pathToDockerfile, String imageName) throws DockerControllerException {
        try {
            return dockerClient.build(pathToDockerfile, imageName);
        } catch (Exception e) {
            throw new DockerControllerException(e.getMessage());
        }
    }

    public static String createContainer(String imageId) throws DockerControllerException {
        try {
            ContainerConfig containerConfig = ContainerConfig.builder()
                    .image(imageId)
                    .attachStdout(true)
                    .cmd("sh", "-c", "while :; do sleep 1; done")
                    .build();
            ContainerCreation containerCreation = dockerClient.createContainer(containerConfig);
            return containerCreation.id();
        } catch (Exception e) {
            throw new DockerControllerException(e.getMessage());
        }
    }

    public static void execStart(String containerId, String runCommand) throws DockerControllerException {
        try {
            dockerClient.startContainer(containerId);
            String[] command = {"sh", "-c", runCommand};
            ExecCreation execCreation = dockerClient.execCreate(
                    containerId,
                    command,
                    DockerClient.ExecCreateParam.attachStdout(),
                    DockerClient.ExecCreateParam.attachStderr(),
                    DockerClient.ExecCreateParam.tty());
            String output = dockerClient.execStart(execCreation.id()).readFully();
            System.out.println("output: " + output);
        } catch (Exception e) {
            e.printStackTrace();
            throw new DockerControllerException(e.getMessage());
        }
    }

    public static String getFileContent(String containerId, String filePath) throws DockerControllerException {
        StringBuilder stringBuilder = new StringBuilder();
        try (final TarArchiveInputStream tarStream = new TarArchiveInputStream(dockerClient.archiveContainer(containerId, filePath))) {
            ArchiveEntry entry;
            while ((entry = tarStream.getNextEntry()) != null) {
                byte[] buf = new byte[(int) entry.getSize()];
                IOUtils.readFully(tarStream,buf);
                String string = new String(buf, StandardCharsets.UTF_8);
                stringBuilder.append(string);
            }
            return stringBuilder.toString();
        } catch (IOException | InterruptedException | DockerException e) {
            e.printStackTrace();
            throw new DockerControllerException(e.getMessage());
        }
    }

    public static void cleanUp(String containerId) throws DockerControllerException {
        try {
            dockerClient.killContainer(containerId);
            dockerClient.removeContainer(containerId);
        } catch (NullPointerException | InterruptedException | DockerException e) {
            throw new DockerControllerException(e.getMessage());
        }
    }
}
