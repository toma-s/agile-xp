import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';
import { ExerciseService } from '../shared/exercise.service';
import { Exercise } from '../shared/exercise.model';
import { SolutonService } from '../shared/soluton.service';
import { Solution } from '../shared/solution.model';
import { SolutionSource } from '../shared/solution-source.model';
import { ExerciseSource } from '../shared/exercise-source.model';
import { ExerciseSourceService } from '../shared/exercise-source.service';
import { SolutonSourceService } from '../shared/soluton-source.service';
import { ExerciseTestService } from '../shared/exercise-test.service';
import { ExerciseTest } from '../shared/exercise-test.model';
import { SolutionTest } from '../shared/solution-test.model';
import { SolutonTestService } from '../shared/soluton-test.service';

@Component({
  selector: 'app-exercise-solve',
  templateUrl: './exercise-solve.component.html',
  styleUrls: ['./exercise-solve.component.scss']
})
export class ExerciseSolveComponent implements OnInit {

  exercise: Exercise = new Exercise();
  exerciseSources: ExerciseSource[] = new Array<ExerciseSource>();
  exerciseTests: ExerciseTest[] = new Array<ExerciseTest>();
  solution: Solution = new Solution();
  solutionSources: SolutionSource[] = new Array<SolutionSource>();
  solutionTests: SolutionTest[] = new Array<SolutionTest>();
  output: string;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService,
    private solutionService: SolutonService,
    private exerciseCodeService: ExerciseSourceService,
    private exerciseTestService: ExerciseTestService,
    private solutionSourceService: SolutonSourceService,
    private solutionTestService: SolutonTestService
  ) { }

  ngOnInit() {
    this.getExercise();
  }

  getExercise() {
    const exercise$ = this.route.paramMap.pipe(
      switchMap(((params: ParamMap) =>
        this.exerciseService.getExerciseById(Number(params.get('exerciseId')))
      ))
    );
    exercise$.subscribe(
      data => {
        console.log(data);
        this.exercise = data;
        this.getSourceCodes();
        this.getTests();
      }
    );
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
    this.createSolution();
    this.saveSolution();
  }

  createSolution() {
    this.solution.exerciseId = this.exercise.id;
  }

  saveSolution() {
    this.solutionService.createSolution(this.solution)
      .subscribe(
        data => {
          console.log(data);
          this.solution = data;
          this.saveSolutionContent();
        },
        error => console.log(error)
      );
  }

  saveSolutionContent() {
    switch (this.exercise.type) {
      case 'white-box': {
        console.log('white-box');
        console.log(this.solutionSources);
        this.saveSolutionSources();
        this.saveSolutionTests();
        this.getEstimation();
        break;
      }
      default: {
        console.log('default');
        break;
      }
    }
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

  getEstimation() {
    
  }

}
