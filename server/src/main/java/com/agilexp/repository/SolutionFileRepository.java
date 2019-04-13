package com.agilexp.repository;

import com.agilexp.dbmodel.SolutionFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionFileRepository extends CrudRepository<SolutionFile, Long> {
    List<SolutionFile> findBySolutionId(long solutionId);
}
