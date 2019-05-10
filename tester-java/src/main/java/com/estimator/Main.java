package com.estimator;

import com.estimator.estimator.Estimator;
import com.estimator.estimator.WhiteBoxFileEstimator;

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

        String estimation = estimator.estimate();
        System.out.println(estimation);
    }
}
