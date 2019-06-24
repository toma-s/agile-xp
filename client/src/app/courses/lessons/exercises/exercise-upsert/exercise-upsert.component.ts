import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormArray } from '@angular/forms';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';
import { Exercise } from '../shared/exercise/exercise/exercise.model';
import { ExerciseType } from '../shared/exercise/exercise-type/exercise-type.model';
import { ExerciseTypeService } from '../shared/exercise/exercise-type/exercise-type.service';

@Component({
  selector: 'exercise-upsert'
})
export abstract class ExerciseUpsertComponent implements OnInit {

  submitted = false;
  exerciseFormGroup: FormGroup;
  viewInput = new Map<string, boolean>();
  protected types = new Array<ExerciseType>();

  constructor(
    protected titleService: Title,
    protected fb: FormBuilder,
    protected exerciseTypeServise: ExerciseTypeService
  ) { }

  async ngOnInit() {
    this.setTitle();
    this.types = await this.getExerciseTypes();
    this.initViewInput();
    await this.createForm();
    this.listenToTypeChange();
    this.setupDefaultValidators();
    this.setupValidatorsOnInit();
  }

  protected abstract setTitle();

  getExerciseTypes(): any {
    return new Promise((resolve, reject) => {
      this.exerciseTypeServise.getExericseTypesList().subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

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
        success: [null],
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

  getGroupForExercise(exercise: Exercise, exerciseTypeGroup: any) {
    return this.fb.group({
      id: exercise.id,
      name: exercise.name,
      description: exercise.description,
      type: exerciseTypeGroup,
      lessonId: exercise.lessonId,
      created: exercise.created,
      index: exercise.index
    });
  }

  protected abstract getExerciseGroup(exerciseType);


  listenToTypeChange() {
    this.viewInput = new Map<string, boolean>();
    this.exerciseFormGroup.get('intro').get('exercise').get('type').valueChanges.subscribe(typeValue => {
      this.setupValidatorsByType(typeValue.value);
    });
  }

  setupValidatorsByType(typeValue: string) {
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
    this.clearContentValidators('sourceControl', 'privateControl');
    this.setContentValidators('testControl', 'privateControl');
    this.viewInput['private-sources'] = false;
    this.viewInput['public-sources'] = true;
    this.viewInput['private-tests'] = true;
    this.viewInput['public-tests'] = true;
  }

  setBlackboxValidators() {
    this.setBugsNumberValidator();
    this.setContentValidators('sourceControl', 'privateControl');
    this.clearContentValidators('testControl', 'privateControl');
    this.setContentValidators('testControl', 'publicControl');
    this.viewInput['private-sources'] = true;
    this.viewInput['public-sources'] = false;
    this.viewInput['private-tests'] = false;
    this.viewInput['public-tests'] = true;
  }

  setTheoryValidators() {
    this.clearBugsNumberValidators();
    this.clearContentValidators('sourceControl', 'privateControl');
    this.clearContentValidators('sourceControl', 'publicControl');
    this.clearContentValidators('testControl', 'privateControl');
    this.clearContentValidators('testControl', 'publicControl');
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

  setBugsNumberValidator() {
    this.exerciseFormGroup.get('intro').get('bugsNumber').setValidators([Validators.required, Validators.min(1)]);
    this.exerciseFormGroup.get('intro').get('bugsNumber').updateValueAndValidity();
  }

  clearBugsNumberValidators() {
    this.exerciseFormGroup.get('intro').get('bugsNumber').clearValidators();
    this.exerciseFormGroup.get('intro').get('bugsNumber').updateValueAndValidity();
  }

  setContentValidators(controlType: string, publicitypControl: string) {
    const array = this.exerciseFormGroup.get(controlType).get(publicitypControl).get('tabContent') as FormArray;
    array.setValidators(Validators.required);
    array.updateValueAndValidity();
    array.controls.forEach(control => {
      control.get('content').setValidators(Validators.required);
      control.get('content').updateValueAndValidity();
    });
  }

  clearContentValidators(controlType: string, publicitypControl: string) {
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

  setupDefaultValidators() {
    this.exerciseFormGroup.get('intro').get('exercise').get('name').setValidators(Validators.required);
    this.exerciseFormGroup.get('intro').get('exercise').get('name').updateValueAndValidity();
    this.exerciseFormGroup.get('intro').get('exercise').get('type').setValidators(Validators.required);
    // this.exerciseFormGroup.get('intro').get('exercise').get('type').get('value').updateValueAndValidity();
    this.exerciseFormGroup.get('intro').get('exercise').get('description').setValidators(Validators.required);
    this.exerciseFormGroup.get('intro').get('exercise').get('description').updateValueAndValidity();
  }

  protected abstract setupValidatorsOnInit();


  async reset() {
    await this.createForm();
    this.setupValidatorsOnInit();
  }

}
