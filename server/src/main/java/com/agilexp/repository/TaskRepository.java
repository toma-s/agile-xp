package com.agilexp.repository;

import com.agilexp.model.TaskData;
import org.springframework.data.repository.CrudRepository;

public interface TaskRepository extends CrudRepository<TaskData, Long> {
}
