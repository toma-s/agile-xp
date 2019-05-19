package com.agilexp.controller.solution;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import com.agilexp.dbmodel.solution.Solution;
import com.agilexp.dbmodel.solution.SolutionFile;
import com.agilexp.dbmodel.solution.SolutionSource;
import com.agilexp.dbmodel.solution.SolutionTest;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.service.solution.SolutionEstimationServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionEstimationController {

    @Autowired
    SolutionEstimationServiceImpl service;

    @GetMapping(value="/solution-estimation/exercise/{exerciseId}/source/{pageNumber}/{pageSize}")
    public ResponseEntity<List<SolutionItems>> getSolutionEstimationsByExerciseIdAndTypeSource(
            @PathVariable("exerciseId") long exerciseId,
            @PathVariable("pageNumber") int pageNumber,
            @PathVariable("pageSize") int pageSize) {
        List<SolutionItems> estimation = service.getSolutionEstimationsByExerciseIdAndTypeSource(exerciseId, pageNumber, pageSize);
        return new ResponseEntity<>(estimation, HttpStatus.OK);
    }

    @GetMapping(value="/solution-estimation/exercise/{exerciseId}/test/{pageNumber}/{pageSize}")
    public ResponseEntity<List<SolutionItems>> getSolutionEstimationsByExerciseIdAndTypeTest(
            @PathVariable("exerciseId") long exerciseId,
            @PathVariable("pageNumber") int pageNumber,
            @PathVariable("pageSize") int pageSize) {
        List<SolutionItems> estimation = service.getSolutionEstimationsByExerciseIdAndTypeTest(exerciseId, pageNumber, pageSize);
        return new ResponseEntity<>(estimation, HttpStatus.OK);
    }

    @GetMapping(value="/solution-estimation/exercise/{exerciseId}/file/{pageNumber}/{pageSize}")
    public ResponseEntity<List<SolutionItems>> getSolutionEstimationsByExerciseIdAndTypeFile(
            @PathVariable("exerciseId") long exerciseId,
            @PathVariable("pageNumber") int pageNumber,
            @PathVariable("pageSize") int pageSize) {
        List<SolutionItems> estimation = service.getSolutionEstimationsByExerciseIdAndTypeFile(exerciseId, pageNumber, pageSize);
        return new ResponseEntity<>(estimation, HttpStatus.OK);
    }
}
