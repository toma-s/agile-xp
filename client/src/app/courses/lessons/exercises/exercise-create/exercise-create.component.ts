import { Component, OnInit } from '@angular/core';
import { ExerciseType } from '../shared/exercise-type.model';
import { ExerciseTypeService } from '../shared/exercise-type.service';
import { Exercise } from '../shared/exercise.model';

@Component({
  selector: 'app-exercise-create',
  templateUrl: './exercise-create.component.html',
  styleUrls: ['./exercise-create.component.scss']
})
export class ExerciseCreateComponent implements OnInit {

  submitted = false;
  exercise = new Exercise();
  types = new Array<ExerciseType>();
  selectedTypeValue = '';

  constructor(
    private exerciseTypeServise: ExerciseTypeService
  ) { }

  ngOnInit() {
    this.getExerciseTypes();
  }

  getExerciseTypes() {
    this.exerciseTypeServise.getExericseTypesList()
      .subscribe(
        data => {
          this.types = data;
          console.log(data);
        },
        error => console.log(error)
      );
  }

  showVal() {
    console.log(this.selectedTypeValue);
  }

}
