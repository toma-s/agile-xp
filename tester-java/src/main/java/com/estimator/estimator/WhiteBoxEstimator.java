package com.estimator.estimator;

import com.estimator.estimation.Estimation;
import com.estimator.compiler.exception.CompilationFailedException;
import com.estimator.tester.TestResult;
import com.estimator.tester.exception.TestFailedException;
import org.junit.runner.notification.Failure;

import java.util.List;

public class WhiteBoxEstimator extends Estimator {

    public WhiteBoxEstimator() {
        super();
    }

    @Override
    public Estimation estimate() {
        try {
            String[] compilationFilesDirectories = new String[]{"sources", "tests"};
            compile(compilationFilesDirectories);
            test();
            return estimation;
        } catch (CompilationFailedException e) {
            estimation.setCompilationResult(e.getMessage());
        } catch (TestFailedException e) {
            estimation.setTestsResult(e.getMessage());
        }
        return estimation;
    }

    private void test() throws TestFailedException {
        List<String> testsFilenames = getTestsFilenames();
        List<TestResult> testResults = testFiles(testsFilenames);
        estimation.setTestsResult(getResult(testResults));
        estimation.setValue(getValue(testResults));
        if (estimation.getValue() == 100) {
            estimation.setSolved(true);
        }
        estimation.setTested(true);
    }

    private int getValue(List<TestResult> testResults) {
        int testsNumber = 0;
        int testsFailed = 0;
        for (TestResult result : testResults) {
            testsNumber += result.getTestsNumber();
            testsFailed += result.getFailureCount();
        }
        System.out.println("tests failed: " + testsFailed + ", tests number: " + testsNumber);
        if (testsFailed == 0) {
            return 100;
        }
        return 100 - (testsFailed / testsNumber * 100);
    }

    private String getResult(List<TestResult> exerciseTestsResults) {
        StringBuilder result = new StringBuilder();
        exerciseTestsResults.forEach(exerciseTestsResult -> {
            result.append(getResultInfo(exerciseTestsResult));
            result.append("\n\n");
        });
        return result.toString();
    }

    private StringBuffer getResultInfo(TestResult result) {
        StringBuffer output = new StringBuffer();
        output.append("Test runtime: ").append(result.getRunTime()).append(" ms")
                .append("\nTests number: ").append(result.getTestsNumber())
                .append("\nTest success: ").append(result.wasSuccessful())
                .append("\nFailures count: ").append(result.getFailureCount());
        if (result.getFailureCount() > 0) {
            output.append("\nFailures: ");
            List<Failure> failures = result.getFailures();
            for (int i = 0; i < failures.size(); i++) {
                Failure failure = failures.get(i);
                String detail = String.format(
                        "Test class: %s\nTest name: %s\nFailure cause: %s\n",
                        failure.getDescription().getClassName(),
                        failure.getDescription().getDisplayName(),
                        failure.getException().toString());
                output.append("\n").append(i + 1).append(") ").append(detail);
            }
        }
        output.append("\nIgnored count: ").append(result.getIgnoreCount());
        return output;
    }

}
