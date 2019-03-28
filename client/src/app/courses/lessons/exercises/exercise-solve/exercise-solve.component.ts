import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';
import { ExerciseService } from '../shared/exercise/exercise.service';
import { Exercise } from '../shared/exercise/exercise.model';

@Component({
  selector: 'app-exercise-solve',
  templateUrl: './exercise-solve.component.html',
  styleUrls: ['./exercise-solve.component.scss']
})
export class ExerciseSolveComponent implements OnInit {

  exercise: Exercise;
  // exercises: Array<Exercise>;
  // maxIndex: number;
  // previousIndex: number;
  // previousExerciseId: number;
  // nextIndex: number;
  // nextExerciseId: number;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService
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
        // this.getExercisesCount();
      },
      error => console.log(error)
    );
  }

  // getExercisesCount() {
  //   this.exerciseService.getExercisesByLessonId(this.exercise.lessonId).subscribe(
  //     data => {
  //       console.log(data);
  //       this.exercises = data;
  //       // this.getCurrentIndex();
  //     }
  //   )
  // }

  // getCurrentIndex() {
  //   this.maxIndex = this.exercises.length;
  //   const currentIndex = this.exercise.index;
  //   console.log(currentIndex);

  //   this.previousIndex = currentIndex - 1;
  //   this.previousExerciseId = this.previousIndex > 0 ? this.exercises[this.previousIndex].id : currentIndex;
  //   console.log(this.previousIndex);

  //   this.nextIndex = currentIndex + 1;
  //   this.nextExerciseId = this.nextIndex < this.maxIndex ? this.exercises[this.nextIndex].id : currentIndex;
  //   console.log(this.nextIndex);
  // }
}
