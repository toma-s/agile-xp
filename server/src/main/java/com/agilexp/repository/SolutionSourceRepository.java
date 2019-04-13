package com.agilexp.repository;

import com.agilexp.dbmodel.SolutionSource;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionSourceRepository extends CrudRepository<SolutionSource, Long> {
    List<SolutionSource> findBySolutionId(long solutionId);
}