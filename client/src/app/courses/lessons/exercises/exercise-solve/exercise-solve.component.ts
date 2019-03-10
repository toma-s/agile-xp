import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';
import { ExerciseService } from '../shared/exercise.service';

@Component({
  selector: 'app-exercise-solve',
  templateUrl: './exercise-solve.component.html',
  styleUrls: ['./exercise-solve.component.scss']
})
export class ExerciseSolveComponent implements OnInit {

  exercise$: Observable<any>;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService
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
      data => console.log(data)
    );
  }

}
