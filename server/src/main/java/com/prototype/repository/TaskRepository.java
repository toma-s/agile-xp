package com.prototype.repository;

import com.prototype.model.TaskData;
import org.springframework.data.repository.CrudRepository;

public interface TaskRepository extends CrudRepository<TaskData, Long> {
}
