package com.estimator;

import com.estimator.estimation.Estimation;
import com.estimator.estimator.Estimator;
import com.estimator.estimator.WhiteBoxFileEstimator;
import com.estimator.utils.JsonWriter;

public class Main {

    public static void main(String[] args) {
        String mode = args[0];
        Estimator estimator;

        switch (mode) {
            case "whitebox-file": {
                estimator = new WhiteBoxFileEstimator();
                break;
            }
            default:
                throw new IllegalStateException("Unexpected value: " + mode);
        }

        Estimation estimation = estimator.estimate();
        JsonWriter.write(estimation);
    }
}
