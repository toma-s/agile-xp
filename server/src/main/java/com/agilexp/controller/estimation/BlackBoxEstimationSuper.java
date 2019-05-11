package com.agilexp.controller.estimation;

import com.agilexp.storage.StorageService;

public abstract class BlackBoxEstimationSuper {

    final StorageService storageService;

    public BlackBoxEstimationSuper(StorageService storageService) {
        this.storageService = storageService;
    }

}
