package com.agilexp.repository;

import com.agilexp.model.SolutionConfig;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionConfigRepository extends CrudRepository<SolutionConfig, Long> {
    List<SolutionConfig> findSolutionConfigBySolutionId(long solutionId);
}
