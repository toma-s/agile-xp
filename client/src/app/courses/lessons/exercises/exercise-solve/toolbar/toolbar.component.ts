import { Component, OnInit, Input, OnChanges } from '@angular/core';
import { Exercise } from '../../shared/exercise/exercise/exercise.model';
import { ExerciseService } from '../../shared/exercise/exercise/exercise.service';
import { ActivatedRoute } from '@angular/router';
import { ControlContainer, FormGroup } from '@angular/forms';

@Component({
  selector: 'toolbar',
  templateUrl: './toolbar.component.html',
  styleUrls: ['./toolbar.component.scss']
})
export class ToolbarComponent implements OnInit {

  currentIndex: number;
  exercises: Array<Exercise>;
  solved: boolean;
  value: string;
  maxIndex: number;
  previousIndex: number;
  previousExerciseId: number;
  nextIndex: number;
  nextExerciseId: number;
  form: FormGroup;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService,
    public controlContainer: ControlContainer
  ) { }

  async ngOnInit() {
    this.form = <FormGroup>this.controlContainer.control;
    this.exercises = await this.getExercises();
    this.reload();
    this.form.get('solved').valueChanges.subscribe(() => {
      this.reload();
    });
  }

  async reload() {
    this.currentIndex = this.form.get('exerciseIndex').value;
    this.value = this.form.get('value').value;
    this.solved = this.form.get('solved').value;
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

    this.previousIndex = this.currentIndex - 1;
    this.previousExerciseId = this.previousIndex >= 0 ? this.exercises[this.previousIndex].id : this.exercises[this.currentIndex].id;

    this.nextIndex = this.currentIndex + 1;
    this.nextExerciseId = this.nextIndex < this.maxIndex ? this.exercises[this.nextIndex].id : this.exercises[this.currentIndex].id;
  }

}
