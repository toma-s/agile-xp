package com.agilexp;

import com.spotify.docker.client.DefaultDockerClient;
import com.spotify.docker.client.DockerClient;
import com.spotify.docker.client.LogStream;
import com.spotify.docker.client.exceptions.DockerCertificateException;
import com.spotify.docker.client.exceptions.DockerException;
import com.spotify.docker.client.messages.*;

import java.nio.file.Path;
import java.nio.file.Paths;

public class DockerController {

    private static DockerClient dockerClient;

    static {
        try {
            dockerClient = DefaultDockerClient.fromEnv().connectionPoolSize(100).build();
        } catch (DockerCertificateException e) {
            e.printStackTrace();
        }
    }

    public static String buildImage(Path pathToDockerfile, String imageName) {
        try {
            return dockerClient.build(pathToDockerfile, imageName);
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    public static String buildImage(String pathToDockerfileDir, String imageName) {
        try {
            return dockerClient.build(Paths.get(pathToDockerfileDir), imageName);
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    public static String createContainer(String imageId) {
        ContainerConfig containerConfig = ContainerConfig.builder().image(imageId).attachStdout(true).cmd("sh", "-c", "while :; do sleep 1; done").build();
        ContainerCreation containerCreation = null;
        try {
            containerCreation = dockerClient.createContainer(containerConfig);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return containerCreation.id();
    }

    public static String execStart(String containerId, String runCommand) {
        LogStream output = null;
        try {
            dockerClient.startContainer(containerId);
            String[] command = {"sh", "-c", runCommand};
            ExecCreation execCreation = dockerClient.execCreate(
                    containerId,
                    command,
                    DockerClient.ExecCreateParam.attachStdout(),
                    DockerClient.ExecCreateParam.attachStderr(),
                    DockerClient.ExecCreateParam.tty());
            output = dockerClient.execStart(execCreation.id());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return output.readFully();
    }

    public static void cleanUp(String containerId) {
        if (containerId == null) {
            return;
        }
        try {
            dockerClient.killContainer(containerId);
            dockerClient.removeContainer(containerId);
        } catch (DockerException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

}
