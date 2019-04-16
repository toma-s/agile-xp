import { Component, OnInit } from '@angular/core';
import { ExerciseType } from '../shared/exercise-type/exercise-type.model';
import { Exercise } from '../shared/exercise/exercise.model';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

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
  viewInput = new Map<string, boolean>();

  constructor(
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.initViewInput();
    this.createForm();
    console.log(this.exerciseFormGroup);
    this.listenToTypeChange();
  }

  initViewInput() {
    this.viewInput = new Map<string, boolean>();
    ['private', 'public'].forEach(privacyType => {
      ['sources', 'tests', 'files'].forEach(contentType => {
        this.viewInput[`${privacyType}-${contentType}`] = false;
      });
    });
  }

  createForm() {
    this.exerciseFormGroup = this.getParamsGroup();
    this.exerciseFormGroup.addControl('intro', this.getIntroGroup());
    this.exerciseFormGroup.addControl('sourceControl', this.getExerciseGroup('sources'));
    this.exerciseFormGroup.addControl('testControl', this.getExerciseGroup('tests'));
    this.exerciseFormGroup.addControl('fileControl', this.getExerciseGroup('files'));
  }

  getParamsGroup() {
    return this.fb.group({
      'params': this.fb.group({
        success: [false],
        viewInput: this.fb.group(this.viewInput)
      })
    });
  }

  getIntroGroup() {
    return this.fb.group({
      name: [null, Validators.compose([Validators.required])],
      description: [null, Validators.compose([Validators.required])],
      type: [null, Validators.compose([Validators.required])]
    });
  }

  getExerciseGroup(exerciseType: string) {
    return this.fb.group({
      exerciseType: [exerciseType],
      privateControl: this.fb.group({
        tabContent: this.fb.array([this.create(null)])
      }),
      publicType: this.fb.group({
        chosen: ['same', Validators.compose([Validators.required])]
      }),
      publicControl: this.fb.group({
        tabContent: this.fb.array([this.create(null)])
      })
    });
  }

  create(validators): FormGroup {
    return this.fb.group({
      filename: ['filename.java'],
      content: ['', validators]
    });
  }

  listenToTypeChange() {
    this.viewInput = new Map<string, boolean>();
    this.exerciseFormGroup.get('intro').get('type').valueChanges.subscribe(typeValue => {
      if (this.isType(typeValue.value, 'whitebox')) {
        this.setValidators('sourceControl', 'privateControl');
        this.setValidators('testControl', 'privateControl');
        this.viewInput['private-sources'] = true;
        this.viewInput['public-sources'] = true;
        this.viewInput['private-tests'] = true;
        this.viewInput['public-tests'] = true;
      } else {
        this.setValidators('sourceControl', 'privateControl');
        this.clearValidators('testControl', 'publicControl');
        this.clearValidators('testControl', 'privateControl');
        this.setValidators('testControl', 'publicControl');
        this.viewInput['private-sources'] = true;
        this.viewInput['public-sources'] = false;
        this.viewInput['private-tests'] = false;
        this.viewInput['public-tests'] = true;
      }
      if (this.isType(typeValue.value, 'file')) {
        this.setValidators('fileControl', 'privateControl');
        this.viewInput['private-files'] = true;
        this.viewInput['public-files'] = true;
      } else {
        this.clearValidators('fileControl', 'privateControl');
        this.viewInput['private-files'] = false;
        this.viewInput['public-files'] = false;
      }
      this.setViewInputConrol();
    });
  }

  isType(value: string, target: string): boolean {
    return value.search(target) !== -1;
  }

  setValidators(controlType: string, publicitypControl: string) {
    this.exerciseFormGroup.get(controlType).get(publicitypControl).get('tabContent').controls.forEach(control => {
      control.get('content').setValidators(Validators.required);
      control.get('content').updateValueAndValidity();
    });
  }

  clearValidators(controlType: string, publicitypControl: string) {
    this.exerciseFormGroup.get(controlType).get(publicitypControl).get('tabContent').controls.forEach(control => {
      control.get('content').clearValidators();
      control.get('content').updateValueAndValidity();
    });
  }

  setViewInputConrol() {
    this.exerciseFormGroup.get('params').get('viewInput').setValue(this.viewInput);
  }

}
