import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';
import { ExerciseService } from '../shared/exercise.service';
import { Exercise } from '../shared/exercise.model';

@Component({
  selector: 'app-exercise-solve',
  templateUrl: './exercise-solve.component.html',
  styleUrls: ['./exercise-solve.component.scss']
})
export class ExerciseSolveComponent implements OnInit {

  exercise: Exercise;
  exercises: Array<Exercise>;
  previous: number;
  next: number;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService
  ) { }

  ngOnInit() {
    this.getExercise();
    this.getExercises();
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
      },
      error => console.log(error)
    );
  }

  getExercises() {
    this.exerciseService.getExercisesList()
      .subscribe(
        data => {
          console.log(data);
          this.exercises = data;
          this.getPrevious();
        },
        error => console.log(error)
      );   
  }

  getPrevious() {
    
  }

}
