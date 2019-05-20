package com.agilexp.controller.solution;

import com.agilexp.dbmodel.estimation.SolutionEstimation;
import com.agilexp.model.solution.SolutionItems;
import com.agilexp.service.estimator.BlackBoxEstimatorServiceImpl;
import com.agilexp.service.estimator.BlackBoxFileEstimatorServiceImpl;
import com.agilexp.service.estimator.WhiteBoxFileEstimatorServiceImpl;
import com.agilexp.service.solution.SolutionEstimationServiceImpl;
import com.agilexp.service.estimator.WhiteBoxEstimatorServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class SolutionEstimationController {

    @Autowired
    SolutionEstimationServiceImpl service;

    @Autowired
    WhiteBoxEstimatorServiceImpl whiteBoxEstimatorService;

    @Autowired
    WhiteBoxFileEstimatorServiceImpl whiteBoxFileEstimatorService;

    @Autowired
    BlackBoxEstimatorServiceImpl blackBoxEstimatorService;

    @Autowired
    BlackBoxFileEstimatorServiceImpl blackBoxFileEstimatorService;


    @GetMapping(value = "/solution-estimation/estimate/whitebox")
    public ResponseEntity<SolutionEstimation> getWhiteboxEstimation(@RequestBody SolutionItems solutionItems) {
        SolutionEstimation estimation = whiteBoxEstimatorService.getEstimation(solutionItems);
        return new ResponseEntity<>(estimation, HttpStatus.OK);
    }

    @PostMapping(value = "/solution-estimation/estimate/whitebox-file")
    public ResponseEntity<SolutionEstimation> getWhiteBoxFileEstimation(@RequestBody SolutionItems solutionItems) {
        SolutionEstimation estimation = whiteBoxFileEstimatorService.getEstimation(solutionItems);
        return new ResponseEntity<>(estimation, HttpStatus.OK);
    }

    @PostMapping(value = "/solution-estimation/estimate/blackbox")
    public ResponseEntity<SolutionEstimation> getBlackBoxEstimation(@RequestBody SolutionItems solutionItems) {
        SolutionEstimation estimation = blackBoxEstimatorService.getEstimation(solutionItems);
        return new ResponseEntity<>(estimation, HttpStatus.OK);
    }

    @PostMapping(value = "/solution-estimation/estimate/blackbox-file")
    public ResponseEntity<SolutionEstimation> getBlackBoxFileEstimation(@RequestBody SolutionItems solutionItems) {
        SolutionEstimation estimation = blackBoxFileEstimatorService.getEstimation(solutionItems);
        return new ResponseEntity<>(estimation, HttpStatus.OK);
    }

    @GetMapping(value="/solution-estimation/exercise/{exerciseId}")
    public ResponseEntity<SolutionEstimation> getSolutionEstimationsByExerciseId(
            @PathVariable("exerciseId") long exerciseId) {
        SolutionEstimation estimation = service.getSolutionEstimationByExerciseId(exerciseId);
        return new ResponseEntity<>(estimation, HttpStatus.OK);
    }

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
