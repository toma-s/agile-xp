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

  async ngOnInit() {
    this.types = await this.getExerciseTypes();
    // this.setExerciseIntro();
  }

  getExerciseTypes(): any {
    return new Promise((resolve, reject) => {
      this.exerciseTypeServise.getExericseTypesList().subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  // setExerciseIntro() {
  //   this.exerciseFormGroup.addControl(
  //     'intro', this.fb.group({
  //       name: [null, Validators.compose([Validators.required])],
  //       description: [null, Validators.compose([Validators.required])],
  //       type: [null, Validators.compose([Validators.required])]
  //     })
  //   );
  // }

}
