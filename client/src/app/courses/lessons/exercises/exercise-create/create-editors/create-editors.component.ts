import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, Validators, ControlContainer } from '@angular/forms';
import { Lesson } from '../../../shared/lesson.model';
import { Exercise } from '../../shared/exercise/exercise.model';

@Component({
  selector: 'create-editors',
  templateUrl: './create-editors.component.html',
  styleUrls: ['./create-editors.component.scss']
})
export class CreateEditorsComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  exerciseType: string;
  exerciseTypePlural: string;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };
  lessons: Array<Lesson>;
  exercises: Array<Exercise>;
  form: FormGroup;
  viewPrivateInput: boolean;
  viewPublicInput: boolean;

  constructor(
    public controlContainer: ControlContainer
  ) { }

  ngOnInit() {
    this.form = <FormGroup>this.controlContainer.control;
    this.exerciseType = this.form.get('exerciseType').value;
    console.log(this.form);
    this.setupValidators();
    this.setViewInput();
  }

  setViewInput() {
    const privateType = `private-${this.exerciseType}`;
    this.viewPrivateInput = this.exerciseFormGroup.get('params').get('viewInput').get(privateType).value;
    const publicType = `public-${this.exerciseType}`;
    this.viewPublicInput = this.exerciseFormGroup.get('params').get('viewInput').get(publicType).value;
  }

  setupValidators() {
    this.form.get('publicType').get('chosen').valueChanges.subscribe(chosenValue => {
      if (chosenValue === 'custom') {
        this.form.get('publicControl').get('tabContent').controls.forEach(control => {
          control.get('content').setValidators(Validators.required);
          control.get('content').updateValueAndValidity();
        });
      } else if (chosenValue === 'same') {
        this.form.get('publicControl').get('tabContent').controls.forEach(control => {
          control.get('content').clearValidators();
          control.get('content').updateValueAndValidity();
        });
      }
    });
  }

}
