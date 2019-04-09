import { Component, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { ExerciseType } from '../shared/exercise-type/exercise-type.model';
import { Exercise } from '../shared/exercise/exercise.model';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';

@Component({
  selector: 'app-exercise-create',
  templateUrl: './exercise-create.component.html',
  styleUrls: ['./exercise-create.component.scss']
})
export class ExerciseCreateComponent implements OnInit {

  submitted = false;
  types = new Array<ExerciseType>();
  exerciseFormGroup: FormGroup;
  exercise: Exercise = new Exercise();
  index: number;

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.getIndex();
    this.createForm();
    console.log(this.exerciseFormGroup);
  }

  createForm() {
    this.exerciseFormGroup = this.fb.group({
      'params': this.fb.group({
        index: [this.getIndex(), Validators.compose([Validators.required])],
        lessonId: [this.getLessonId(), Validators.compose([Validators.required])],
        success: [false]
      })
    });
  }

  getIndex() {
    return Number(this.route.snapshot.params['index']);
  }

  getLessonId() {
    return this.route.snapshot.params['lessonId'];
  }

}
