import { Component, OnInit, Input } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { ExerciseCreatorService } from '../utils/exercise-creator.service';
import { HttpErrorResponse } from '@angular/common/http';
import { ExerciseUpdaterService } from '../utils/exercise-updater.service';

@Component({
  selector: 'create-submit',
  templateUrl: './create-submit.component.html',
  styleUrls: ['./create-submit.component.scss']
})
export class CreateSubmitComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;

  constructor(
    private exerciseCreaterService: ExerciseCreatorService,
    private exerciseUpdaterService: ExerciseUpdaterService
  ) { }

  ngOnInit() {
  }

  async submit() {
    this.resetErrorMessage();
    const mode = this.exerciseFormGroup.get('intro').get('mode').value;
    let result;
    if (mode === 'create') {
      result = await this.exerciseCreaterService.save(this.exerciseFormGroup);
    } else if (mode === 'edit') {
      result = await this.exerciseUpdaterService.save(this.exerciseFormGroup);
    }
    console.log(result);
    if (!result.success) {
      this.setErrorMessage(result.success);
    }
    this.setSuccess(result.success);
  }

  setSuccess(success: boolean) {
    this.exerciseFormGroup.get('params').get('success').setValue(success);
  }

  setErrorMessage(success: boolean) {
    const message = 'Error occured during exercise creation';
    this.exerciseFormGroup.get('error').get('errorMessage').setValue(message);
  }

  resetErrorMessage() {
    this.exerciseFormGroup.get('error').get('errorMessage').setValue('');
  }

}
