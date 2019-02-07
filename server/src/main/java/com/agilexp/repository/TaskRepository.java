package com.agilexp.repository;

import com.agilexp.model.TaskData;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface TaskRepository extends CrudRepository<TaskData, Long> {
}
