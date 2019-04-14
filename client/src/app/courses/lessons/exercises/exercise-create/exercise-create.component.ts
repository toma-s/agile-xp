import { Component, OnInit } from '@angular/core';
import { ExerciseType } from '../shared/exercise-type/exercise-type.model';
import { Exercise } from '../shared/exercise/exercise.model';
import { FormBuilder, FormGroup } from '@angular/forms';

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
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.createForm();
    console.log(this.exerciseFormGroup);
  }

  createForm() {
    this.exerciseFormGroup = this.fb.group({
      'params': this.fb.group({
        success: [false]
      })
    });
    this.exerciseFormGroup.addControl(
      'testControl', new FormGroup({})
    );
  }

}
