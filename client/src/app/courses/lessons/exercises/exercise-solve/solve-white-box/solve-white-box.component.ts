import { Component, Input, OnInit } from '@angular/core';
import { Exercise } from '../../shared/exercise/exercise.model';
import { SolutionSource } from '../../shared/solution-source/solution-source.model';
import { SolutionTest } from '../../shared/solution-test/solution-test.model';
import { SolutionEstimation } from '../../shared/solution-estimation/solution-estimation.model';
import { ExerciseSourceService } from '../../shared/exercise-source/exercise-source.service';
import { ExerciseTestService } from '../../shared/exercise-test/exercise-test.service';
import { ExerciseSource } from '../../shared/exercise-source/exercise-source.model';
import { ExerciseTest } from '../../shared/exercise-test/exercise-test.model';
import { Solution } from '../../shared/solution/solution.model';
import { SolutonService } from '../../shared/solution/soluton.service';
import { SolutonSourceService } from '../../shared/solution-source/solution-source.service';
import { SolutonTestService } from '../../shared/solution-test/solution-test.service';
import { SolutionEstimationService } from '../../shared/solution-estimation/solution-estimation.service';
import { SolutionConfig } from '../../shared/solution-config/solution-config.model';
import { ExerciseConfig } from '../../shared/exercise-config/exercise-config.model';
import { ExerciseConfigService } from '../../shared/exercise-config/exercise-config.service';
import { SolutionConfigService } from '../../shared/solution-config/solution-config.service';

@Component({
  selector: 'solve-white-box',
  templateUrl: './solve-white-box.component.html',
  styleUrls: ['./solve-white-box.component.scss']
})
export class SolveWhiteBoxComponent implements OnInit {

  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };

  @Input() exercise: Exercise;
  exerciseSources: Array<ExerciseSource> = new Array<ExerciseSource>();
  exerciseTests: Array<ExerciseTest> = new Array<ExerciseTest>();
  exerciseConfigs: Array<ExerciseConfig> = new Array<ExerciseConfig>();

  solution: Solution = new Solution();
  solutionSources: SolutionSource[] = new Array<SolutionSource>();
  solutionTests: SolutionTest[] = new Array<SolutionTest>();
  solutionEstimation: SolutionEstimation = new SolutionEstimation();
  solutionConfigs: SolutionConfig[] = new Array<SolutionConfig>();

  constructor(
    private exerciseCodeService: ExerciseSourceService,
    private exerciseTestService: ExerciseTestService,
    private exerciseConfigService: ExerciseConfigService,
    private solutionService: SolutonService,
    private solutionSourceService: SolutonSourceService,
    private solutionTestService: SolutonTestService,
    private solutionEstimationService: SolutionEstimationService,
    private solutionConfigService: SolutionConfigService
  ) { }

  ngOnInit() {
    console.log(this.exercise);
    this.getSourceCodes();
    this.getSourceTests();
    this.getSourceConfigs();
  }

  getSourceCodes() {
    this.exerciseCodeService.getExerciseSourcesByExerciseId(this.exercise.id)
      .subscribe(
        data => {
          this.exerciseSources = data;
          console.log(this.exerciseSources);
          this.solutionSources = Object.assign([], this.exerciseSources);
        },
        error => console.log(error)
      );
  }

  getSourceTests() {
    this.exerciseTestService.getExerciseTestsByExerciseId(this.exercise.id).subscribe(
      data => {
        this.exerciseTests = data;
        console.log(this.exerciseTests);
        this.solutionTests = Object.assign([], this.exerciseTests);
      }
    );
  }

  getSourceConfigs() {
    this.exerciseConfigService.getExerciseConfigsByExerciseId(this.exercise.id).subscribe(
      data => {
        console.log(data);
        this.exerciseConfigs = data;
        console.log(this.exerciseConfigs);
        this.solutionConfigs = Object.assign([], this.exerciseConfigs);
      },
      error => console.log(error)
    );
  }


  run() {
    this.solutionEstimation.estimation = 'Running...';
    this.saveSolution();
  }

  saveSolution() {
    this.solution.exerciseId = this.exercise.id;
    this.solutionService.createSolution(this.solution)
      .subscribe(
        data => {
          console.log(data);
          this.solution = data;
          this.saveSolutionSources();
          this.saveSolutionTests();
          this.saveSolutionConfigs();
        },
        error => console.log(error)
      );
  }

  saveSolutionSources() {
    this.solutionSources.forEach(ssc => {
      ssc.solutionId = this.solution.id;
      console.log(ssc);
      this.solutionSourceService.createSolutionSource(ssc)
        .subscribe(
          data => {
            console.log(data);
          },
          error => console.log(error)
        );
    });
  }

  saveSolutionTests() {
    this.solutionTests.forEach(sst => {
      sst.solutionId = this.solution.id;
      console.log(sst);
      this.solutionTestService.createSolutionTest(sst)
        .subscribe(
          data => {
            console.log(data);
          },
          error => console.log(error)
        );
    });
  }

  saveSolutionConfigs() {
    this.solutionConfigs.forEach(sc => {
      sc.solutionId = this.solution.id;
      console.log(sc);
      this.solutionConfigService.createSolutionConfig(sc).subscribe(
        data => {
          console.log(data);
          // TODO | move to saveSolution...subscribe()
          this.getEstimation();
        },
        error => console.log(error)
      );
    });
  }

  getEstimation() {
    this.solutionEstimationService.estimateSourceTestSolution(this.solution.id)
      .subscribe(
        data => {
          console.log(data);
          this.solutionEstimation = data;
        },
        error => console.log(error)
      );
  }

  // addSourceFile() {
  //   const newFile = new SolutionSource();
  //   newFile.fileName = 'NewSolutionSourceFile.java';
  //   this.solutionSources.push(newFile);
  // }

}
