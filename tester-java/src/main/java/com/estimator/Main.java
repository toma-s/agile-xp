package com.estimator;

import com.estimator.estimation.Estimation;
import com.estimator.estimator.BlackBoxEstimator;
import com.estimator.estimator.Estimator;
import com.estimator.estimator.WhiteBoxEstimator;
import com.estimator.utils.JsonWriter;

public class Main {

    public static void main(String[] args) {
        String mode = args[0];
        Estimator estimator;

        switch (mode) {
            case "whitebox": {
                estimator = new WhiteBoxEstimator();
                break;
            }
            case "blackbox": {
                estimator = new BlackBoxEstimator();
                break;
            }
            default:
                throw new IllegalStateException("Unexpected value: " + mode);
        }

        Estimation estimation = estimator.estimate();
        JsonWriter.write(estimation);
    }
}
