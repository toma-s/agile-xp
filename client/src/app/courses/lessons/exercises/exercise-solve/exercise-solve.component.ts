import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';
import { ExerciseService } from '../shared/exercise/exercise.service';
import { Exercise } from '../shared/exercise/exercise.model';
import { ExerciseTypeService } from '../shared/exercise-type/exercise-type.service';

@Component({
  selector: 'exercise-solve',
  templateUrl: './exercise-solve.component.html',
  styleUrls: ['./exercise-solve.component.scss']
})
export class ExerciseSolveComponent implements OnInit {

  exercise: Exercise;
  exerciseType: string;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService,
    private exerciseTypeService: ExerciseTypeService
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
        this.getExerciseType();
      },
      error => console.log(error)
    );
  }

  getExerciseType() {
    this.exerciseTypeService.getExerciseTypeById(this.exercise.typeId).subscribe(
      data => {
        console.log(data);
        this.exerciseType = data;
      },
      error => console.log(error)
    );
  }

}
