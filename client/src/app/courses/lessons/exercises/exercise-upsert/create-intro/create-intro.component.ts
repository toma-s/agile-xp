import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, Validators, ControlContainer } from '@angular/forms';
import { ExerciseTypeService } from '../../shared/exercise/exercise-type/exercise-type.service';
import { ExerciseType } from '../../shared/exercise/exercise-type/exercise-type.model';

@Component({
  selector: 'create-intro',
  templateUrl: './create-intro.component.html',
  styleUrls: ['./create-intro.component.scss']
})
export class CreateIntroComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  form: FormGroup;
  types = new Array<ExerciseType>();

  constructor(
    private exerciseTypeServise: ExerciseTypeService,
    public controlContainer: ControlContainer
  ) { }

  async ngOnInit() {
    this.form = <FormGroup>this.controlContainer.control;
    this.types = await this.getExerciseTypes();
  }

  getExerciseTypes(): any {
    return new Promise((resolve, reject) => {
      this.exerciseTypeServise.getExericseTypesList().subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

}
