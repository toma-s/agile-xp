import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { Observable } from 'rxjs';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';
import { ExerciseService } from '../shared/exercise.service';
import { FormGroup, FormBuilder } from '@angular/forms';
import { Exercise } from '../shared/exercise.model';
import { SolutonService } from '../shared/soluton.service';
import { Solution } from '../shared/solution.model';

@Component({
  selector: 'app-exercise-solve',
  templateUrl: './exercise-solve.component.html',
  styleUrls: ['./exercise-solve.component.scss']
})
export class ExerciseSolveComponent implements OnInit {

  exercise$: Observable<Exercise>;
  exerciseTypeValue: string;
  exerciseId: number;
  solutionFormGroup: FormGroup;
  submitted = false;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService,
    private solutionService: SolutonService,
    private fb: FormBuilder,
  ) { }

  ngOnInit() {
    this.getExercise();
  }

  getExercise() {
    this.exercise$ = this.route.paramMap.pipe(
      switchMap(((params: ParamMap) =>
        this.exerciseService.getExerciseById(Number(params.get('exerciseId')))
      ))
    );
    console.log(this.exercise$);
    this.exercise$.subscribe(
      data => {
        console.log(data);
        this.exerciseId = data.id;
        this.exerciseTypeValue = data.type;
        this.createForm();
      }
    );
  }

  createForm() {
    switch (this.exerciseTypeValue) {
      case 'white-box': {
        console.log('white-box');
        this.createWhiteBoxForm();
        break;
      }
      default: {
        console.log('default');
        break;
      }
    }
  }

  createWhiteBoxForm() {
    this.solutionFormGroup = this.fb.group({
      sourceCode: [''],
      testCode: ['']
    });
  }

  run() {
    console.log('run!');
    const solution = this.createSolution();
    this.saveSolution(solution);
  }

  createSolution(): Solution {
    const solution = new Solution();
    solution.exerciseId = this.exerciseId;
    return solution;
  }

  saveSolution(solution: Solution) {
    this.solutionService.createSolution(solution)
      .subscribe(
        data => {
          console.log(data);
        },
        error => console.log(error)
      );
  }

}
