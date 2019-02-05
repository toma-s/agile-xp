package com.prototype.model;

import javax.persistence.*;
import java.sql.Timestamp;

abstract class Task {
    private long id;

    public long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

}
