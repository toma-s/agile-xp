import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ExerciseTypeService } from '../../shared/exercise-type/exercise-type.service';
import { ExerciseType } from '../../shared/exercise-type/exercise-type.model';

@Component({
  selector: 'create-intro',
  templateUrl: './create-intro.component.html',
  styleUrls: ['./create-intro.component.scss']
})
export class CreateIntroComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  types = new Array<ExerciseType>();
  exerciseDescription: string;

  constructor(
    private exerciseTypeServise: ExerciseTypeService,
    private fb: FormBuilder,
  ) { }

  ngOnInit() {
    this.setExerciseIntro();
    this.getExerciseTypes();
    console.log(this.exerciseFormGroup);
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

  setExerciseIntro() {
    this.exerciseFormGroup.addControl(
      'intro', this.fb.group({
        exerciseName: [''],
        exerciseDescription: [''],
        exerciseType: ['']
      })
    );
  }

}
