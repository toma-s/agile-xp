import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
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

  constructor(
    private exerciseTypeServise: ExerciseTypeService,
    private fb: FormBuilder,
  ) { }

  ngOnInit() {
    this.getExerciseTypes();
    this.setExerciseIntro();
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
        name: [null, Validators.compose([Validators.required])],
        description: [null, Validators.compose([Validators.required])],
        type: [null, Validators.compose([Validators.required])]
      })
    );
  }

}
