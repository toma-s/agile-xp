package com.agilexp.repository;

import com.agilexp.model.SolutionFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionConfigRepository extends CrudRepository<SolutionFile, Long> {
    List<SolutionFile> findSolutionConfigBySolutionId(long solutionId);
}
