package com.agilexp.repository.solution;

import com.agilexp.dbmodel.solution.SolutionSource;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionSourceRepository extends CrudRepository<SolutionSource, Long> {
    List<SolutionSource> findBySolutionId(long solutionId);

//    @Query(value=
//            "select solution_content.id as solution_content_id,\n" +
//                    "       solution_estimation.id as id,\n" +
//                    "       solution_estimation.estimation as estimation,\n" +
//                    "       solution_estimation.solved as solved\n" +
//                    "from solution_content\n" +
//                    "join solution_estimation\n" +
//                    "on solution_content.solution_id = solution_estimation.solution_id\n" +
//                    "where solution_content_type = 'solution_source' and solution_estimation.solution_id = ?1",
//            nativeQuery = true)
//    List<SolutionSource> findSolutionEstimationsBySolutionId(long solutionId);

}