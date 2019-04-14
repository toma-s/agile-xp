package com.agilexp.repository.solution;

import com.agilexp.dbmodel.solution.SolutionFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionFileRepository extends CrudRepository<SolutionFile, Long> {
    List<SolutionFile> findBySolutionId(long solutionId);
}
