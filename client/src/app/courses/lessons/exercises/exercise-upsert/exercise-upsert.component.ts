import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormArray } from '@angular/forms';
import { Title } from '@angular/platform-browser';

@Component({
  selector: 'exercise-upsert'
})
export abstract class ExerciseUpsertComponent implements OnInit {

  submitted = false;
  exerciseFormGroup: FormGroup;
  viewInput = new Map<string, boolean>();

  constructor(
    protected titleService: Title,
    protected fb: FormBuilder
  ) { }

  async ngOnInit() {
    this.setTitle();
    this.initViewInput();
    await this.createForm();
    console.log(this.exerciseFormGroup);
    this.listenToTypeChange();
    this.setupValidatorsOnInit();
  }

  protected abstract setTitle();

  initViewInput() {
    this.viewInput = new Map<string, boolean>();
    ['private', 'public'].forEach(privacyType => {
      ['sources', 'tests', 'files'].forEach(contentType => {
        this.viewInput[`${privacyType}-${contentType}`] = false;
      });
    });
  }

  async createForm() {
    this.exerciseFormGroup = this.getParamsGroup();
    this.exerciseFormGroup.addControl('error', this.getErrorGroup());
    this.exerciseFormGroup.addControl('intro', await this.getIntroGroup());
    this.exerciseFormGroup.addControl('sourceControl', await this.getExerciseGroup('sources'));
    this.exerciseFormGroup.addControl('testControl', await this.getExerciseGroup('tests'));
    this.exerciseFormGroup.addControl('fileControl', await this.getExerciseGroup('files'));
  }

  getParamsGroup() {
    return this.fb.group({
      'params': this.fb.group({
        success: [false],
        viewInput: this.fb.group(this.viewInput)
      })
    });
  }

  getErrorGroup() {
    return this.fb.group({
      errorMessage: ['']
    });
  }

  protected abstract async getIntroGroup();

  protected abstract getExerciseGroup(exerciseType);


  listenToTypeChange() {
    this.viewInput = new Map<string, boolean>();
    this.exerciseFormGroup.get('intro').get('type').valueChanges.subscribe(typeValue => {
      this.setupValidatorsByType(typeValue);
    });
  }

  setupValidatorsByType(typeValue: string) {
    console.log(typeValue);
    if (this.isType(typeValue, 'whitebox')) {
      this.setWhiteboxValidators();
    } else if (this.isType(typeValue, 'blackbox')) {
      this.setBlackboxValidators();
    } else if (this.isType(typeValue, 'theory')) {
      this.setTheoryValidators();
    }
    if (this.isType(typeValue, 'file')) {
      this.setFileValidators();
    } else {
      this.unsetFileValidators();
    }
    this.setViewInputConrol();
  }

  isType(value: string, target: string): boolean {
    return value.search(target) !== -1;
  }

  setWhiteboxValidators() {
    this.clearValidators('sourceControl', 'privateControl');
    this.setValidators('testControl', 'privateControl');
    this.viewInput['private-sources'] = false;
    this.viewInput['public-sources'] = true;
    this.viewInput['private-tests'] = true;
    this.viewInput['public-tests'] = true;
  }

  setBlackboxValidators() {
    this.setValidators('sourceControl', 'privateControl');
    this.clearValidators('testControl', 'privateControl');
    this.setValidators('testControl', 'publicControl');
    this.viewInput['private-sources'] = true;
    this.viewInput['public-sources'] = false;
    this.viewInput['private-tests'] = false;
    this.viewInput['public-tests'] = true;
  }

  setTheoryValidators() {
    this.clearValidators('sourceControl', 'privateControl');
    this.clearValidators('sourceControl', 'publicControl');
    this.clearValidators('testControl', 'privateControl');
    this.clearValidators('testControl', 'publicControl');
    this.viewInput['private-sources'] = false;
    this.viewInput['public-sources'] = false;
    this.viewInput['private-tests'] = false;
    this.viewInput['public-tests'] = false;
  }

  setFileValidators() {
    this.viewInput['private-files'] = true;
    this.viewInput['public-files'] = true;
  }

  unsetFileValidators() {
    this.viewInput['private-files'] = false;
    this.viewInput['public-files'] = false;
  }

  setValidators(controlType: string, publicitypControl: string) {
    const array = this.exerciseFormGroup.get(controlType).get(publicitypControl).get('tabContent') as FormArray;
    array.setValidators(Validators.required);
    array.updateValueAndValidity();
    array.controls.forEach(control => {
      control.get('content').setValidators(Validators.required);
      control.get('content').updateValueAndValidity();
    });
  }

  clearValidators(controlType: string, publicitypControl: string) {
    const array = this.exerciseFormGroup.get(controlType).get(publicitypControl).get('tabContent') as FormArray;
    array.clearValidators();
    array.updateValueAndValidity();
    array.controls.forEach(control => {
      control.get('content').clearValidators();
      control.get('content').updateValueAndValidity();
    });
  }

  setViewInputConrol() {
    this.exerciseFormGroup.get('params').get('viewInput').setValue(this.viewInput);
  }

  protected abstract setupValidatorsOnInit();

}
