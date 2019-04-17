import { Component, OnInit, Input, OnChanges } from '@angular/core';
import { Exercise } from '../shared/exercise/exercise/exercise.model';
import { ExerciseService } from '../shared/exercise/exercise/exercise.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'toolbar',
  templateUrl: './toolbar.component.html',
  styleUrls: ['./toolbar.component.scss']
})
export class ToolbarComponent implements OnInit {

  exercise: Exercise;
  exercises: Array<Exercise>;
  maxIndex: number;
  previousIndex: number;
  previousExerciseId: number;
  nextIndex: number;
  nextExerciseId: number;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService
  ) { }

  async ngOnInit() {
    this.exercises = await this.getExercises();
    this.route.params.subscribe(() => this.reload());
  }

  async reload() {
    this.exercise = await this.getExercise();
    this.getIndexes();
  }

  getExercise(): Promise<Exercise> {
    return new Promise<Exercise>((resolve, reject) => {
      this.route.params.subscribe(params =>
        this.exerciseService.getExerciseById(params['exerciseId']).subscribe(
          data => resolve(data),
          error => reject(error)
        )
      );
    });
  }

  getExercises() {
    const lessonId = Number(this.route.snapshot.params['lessonId']);
    return new Promise<Array<Exercise>>((resolve, reject) => {
      this.exerciseService.getExercisesByLessonId(lessonId).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  getIndexes() {
    this.maxIndex = this.exercises.length;
    const currentIndex = this.exercise.index;

    this.previousIndex = currentIndex - 1;
    this.previousExerciseId = this.previousIndex >= 0 ? this.exercises[this.previousIndex].id : this.exercises[currentIndex].id;

    this.nextIndex = currentIndex + 1;
    this.nextExerciseId = this.nextIndex < this.maxIndex ? this.exercises[this.nextIndex].id : this.exercises[currentIndex].id;
  }

}
