import { Component, OnInit, Input } from '@angular/core';
import { Exercise } from '../shared/exercise/exercise.model';
import { ExerciseService } from '../shared/exercise/exercise.service';

@Component({
  selector: 'toolbar',
  templateUrl: './toolbar.component.html',
  styleUrls: ['./toolbar.component.scss']
})
export class ToolbarComponent implements OnInit {

  @Input() exercise: Exercise;
  exercises: Array<Exercise>;
  maxIndex: number;
  previousIndex: number;
  previousExerciseId: number;
  nextIndex: number;
  nextExerciseId: number;

  constructor(
    private exerciseService: ExerciseService
  ) { }

  ngOnInit() {
    this.getExercisesCount();
  }

  getExercisesCount() {
      this.exerciseService.getExercisesByLessonId(this.exercise.lessonId).subscribe(
        data => {
          this.exercises = data;
          this.getIndexes();
        }
      );
    }

  getIndexes() {
    this.maxIndex = this.exercises.length;
    const currentIndex = this.exercise.index;

    this.previousIndex = currentIndex - 1;
    this.previousExerciseId = this.previousIndex > 0 ? this.exercises[this.previousIndex].id : currentIndex;

    this.nextIndex = currentIndex + 1;
    this.nextExerciseId = this.nextIndex < this.maxIndex ? this.exercises[this.nextIndex].id : currentIndex;
  }

}
