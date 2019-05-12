import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, Validators, ControlContainer, FormArray } from '@angular/forms';
import { Lesson } from '../../../shared/lesson.model';
import { Exercise } from '../../shared/exercise/exercise/exercise.model';

@Component({
  selector: 'upsert-editors',
  templateUrl: './upsert-editors.component.html',
  styleUrls: ['./upsert-editors.component.scss']
})
export class UpsertEditorsComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  exerciseType: string;
  exerciseTypePlural: string;
  editorOptions = { theme: 'vs', language: 'java' };
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
    this.setEditorOptions();
    this.setupValidators();
    this.setViewInput();
  }

  setEditorOptions() {
    if (this.exerciseType.search('files') !== -1) {
      this.editorOptions.language = 'text';
    }
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
        const array = this.form.get('publicControl').get('tabContent') as FormArray;
        array.controls.forEach(control => {
          control.get('content').setValidators(Validators.required);
          control.get('content').updateValueAndValidity();
        });
      } else if (chosenValue === 'same') {
        const array = this.form.get('publicControl').get('tabContent') as FormArray;
        array.controls.forEach(control => {
          control.get('content').clearValidators();
          control.get('content').updateValueAndValidity();
        });
      }
    });
  }

}
