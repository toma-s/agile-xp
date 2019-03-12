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

@Component({
  selector: 'app-exercise-solve',
  templateUrl: './exercise-solve.component.html',
  styleUrls: ['./exercise-solve.component.scss']
})
export class ExerciseSolveComponent implements OnInit {

  exercise: Exercise = new Exercise();
  sourceCodes: ExerciseSource[] = new Array<ExerciseSource>();
  solution: Solution = new Solution();
  solutionSourceCodes: SolutionSource[] = new Array<SolutionSource>();
  submitted = false;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService,
    private solutionService: SolutonService,
    private sourceCodeService: ExerciseSourceService,
    private solutionSourceCodeService: SolutonSourceService
  ) { }

  ngOnInit() {
    this.getExercise();
    // this.getTests(); todo
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
      }
    );
  }

  getSourceCodes() {
    this.sourceCodeService.getExerciseSourcesByExerciseId(this.exercise.id)
      .subscribe(
        data => {
          this.sourceCodes = data;
          console.log(this.sourceCodes);
          this.createSolutionSourceCodes(data);
        },
        error => console.log(error)
      );
  }

  createSolutionSourceCodes(sourceCodes: Array<ExerciseSource>) {
    sourceCodes.forEach(sc => {
      const solutionSourceCode = new SolutionSource();
      // solutionSourceCode.solutionId = this.solution.id;
      solutionSourceCode.fileName = sc.fileName;
      solutionSourceCode.code = sc.code;
      this.solutionSourceCodes.push(solutionSourceCode);
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
        console.log(this.solutionSourceCodes);
        this.saveSolutionSourceCode();
        break;
      }
      default: {
        console.log('default');
        break;
      }
    }
  }

  saveSolutionSourceCode() {
    this.solutionSourceCodes.forEach(ssc => {
      ssc.solutionId = this.solution.id;
      console.log(ssc);
      this.solutionSourceCodeService.createSolutionSource(ssc)
        .subscribe(
          data => {
            console.log(data);
          },
          error => console.log(error)
        );
    });
  }

}
