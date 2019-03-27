import { Component, Input, OnInit } from '@angular/core';
import { Exercise } from '../../shared/exercise.model';
import { SolutionSource } from '../../shared/solution-source.model';
import { SolutionTest } from '../../shared/solution-test.model';
import { SolutionEstimation } from '../../shared/solution-extimation.model';
import { ExerciseSourceService } from '../../shared/exercise-source.service';
import { ExerciseTestService } from '../../shared/exercise-test.service';
import { ExerciseSource } from '../../shared/exercise-source.model';
import { ExerciseTest } from '../../shared/exercise-test.model';
import { Solution } from '../../shared/solution.model';
import { SolutonService } from '../../shared/soluton.service';
import { SolutonSourceService } from '../../shared/soluton-source.service';
import { SolutonTestService } from '../../shared/soluton-test.service';
import { SolutionEstimationService } from '../../shared/solution-estimation.service';

@Component({
  selector: 'solve-white-box',
  templateUrl: './solve-white-box.component.html',
  styleUrls: ['./solve-white-box.component.scss']
})
export class SolveWhiteBoxComponent implements OnInit {

  editorOptions = { theme: 'vs', language: 'java' };

  @Input() exercise: Exercise;
  exerciseSources: Array<ExerciseSource> = new Array<ExerciseSource>();
  exerciseTests: Array<ExerciseTest> = new Array<ExerciseTest>();

  solution: Solution = new Solution();
  solutionSources: SolutionSource[] = new Array<SolutionSource>();
  solutionTests: SolutionTest[] = new Array<SolutionTest>();
  solutionEstimation: SolutionEstimation = new SolutionEstimation();

  constructor(
    private exerciseCodeService: ExerciseSourceService,
    private exerciseTestService: ExerciseTestService,
    private solutionService: SolutonService,
    private solutionSourceService: SolutonSourceService,
    private solutionTestService: SolutonTestService,
    private solutionEstimationService: SolutionEstimationService
  ) { }

  ngOnInit() {
    console.log(this.exercise);
    this.getSourceCodes();
    this.getTests();
  }

  getSourceCodes() {
    this.exerciseCodeService.getExerciseSourcesByExerciseId(this.exercise.id)
      .subscribe(
        data => {
          this.exerciseSources = data;
          console.log(this.exerciseSources);
          this.createSolutionSources(data);
        },
        error => console.log(error)
      );
  }

  createSolutionSources(sourceCodes: Array<ExerciseSource>) {
    sourceCodes.forEach(sc => {
      const solutionSource = new SolutionSource();
      solutionSource.fileName = sc.fileName;
      solutionSource.code = sc.code;
      this.solutionSources.push(solutionSource);
    });
  }

  getTests() {
    this.exerciseTestService.getExerciseTestsByExerciseId(this.exercise.id)
      .subscribe(
        data => {
          this.exerciseTests = data;
          console.log(this.exerciseTests);
          this.createSolutionTests(data);
        }
      );
  }

  createSolutionTests(sourceTests: Array<ExerciseTest>) {
    sourceTests.forEach(st => {
      const solutionTest = new SolutionTest();
      solutionTest.fileName = st.fileName;
      solutionTest.code = st.code;
      this.solutionTests.push(solutionTest);
    });
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
            this.getEstimation();
          },
          error => console.log(error)
        );
    });
  }

  getEstimation() {
    this.solutionEstimationService.estimateSolution(this.solution.id)
      .subscribe(
        data => {
          console.log(data);
          this.solutionEstimation = data;
        },
        error => console.log(error)
      );
  }

  addSourceFile() {
    const newFile = new SolutionSource();
    newFile.fileName = 'NewSolutionSourceFile.java';
    this.solutionSources.push(newFile);
  }

}
