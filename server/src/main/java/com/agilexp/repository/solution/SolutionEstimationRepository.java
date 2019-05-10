package com.agilexp.repository.solution;

import com.agilexp.dbmodel.estimation.Estimation;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SolutionEstimationRepository extends CrudRepository<Estimation, Long> {
    List<Estimation> findAllBySolutionId(long solutionId);

//    @Query("select solution_content.filename as filename,\n" +
//            "       solution_content.content as content,\n" +
//            "       solution_estimation.estimation as estimation,\n" +
//            "       solution_estimation.solved as solved\n" +
//            "from solution_content\n" +
//            "join solution_estimation\n" +
//            "on solution_content.solution_id = solution_estimation.solution_id\n" +
//            "where solution_content.solution_id = ?1")
//    List<SolutionContentEstimationProjection> findBySolutionId(long solutionId);


//    @Query(value=
//            "select solution_content.id as solution_content_id,\n" +
//            "       solution_estimation.id as id,\n" +
//            "       solution_estimation.estimation as estimation,\n" +
//            "       solution_estimation.solved as solved\n" +
//            "from solution_content\n" +
//            "join solution_estimation\n" +
//            "on solution_content.solution_id = solution_estimation.solution_id\n" +
//            "where solution_estimation.solution_id = ?1",
//            nativeQuery = true)
//    List<Estimation> findSolutionEstimationsBySolutionId(long solutionId);
}
