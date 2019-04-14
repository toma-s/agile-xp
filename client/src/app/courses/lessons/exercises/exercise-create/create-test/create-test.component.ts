import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormArray, FormControl } from '@angular/forms';
import { MatDialogRef, MatDialog } from '@angular/material';
import { DialogComponent } from '../dialog/dialog.component';
import { Lesson } from '../../../shared/lesson.model';
import { Exercise } from '../../shared/exercise/exercise.model';

@Component({
  selector: 'create-test',
  templateUrl: './create-test.component.html',
  styleUrls: ['./create-test.component.scss']
})
export class CreateTestComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };
  dialogRef: MatDialogRef<DialogComponent>;
  lessons: Array<Lesson>;
  exercises: Array<Exercise>;

  constructor(
    private fb: FormBuilder,
    public dialog: MatDialog
  ) { }

  ngOnInit() {
    this.setTests();
  }

  setTests() {
    this.exerciseFormGroup.addControl(
      'exerciseTests', this.fb.array([this.createExerciseTests()])
    );
    this.exerciseFormGroup.addControl(
      'shownTestsType', this.fb.group({
        chosen: ['same', Validators.compose([Validators.required])]
      })
    );
    this.exerciseFormGroup.addControl(
      'shownTests', this.fb.array([this.createShownTests()])
    );
    this.setupValidators();
  }

  createExerciseTests(): FormGroup {
    return this.fb.group({
      filename: ['TestFilename.java'],
      content: ['', Validators.compose([Validators.required])]
    });
  }

  createShownTests(): FormGroup {
    return this.fb.group({
      filename: ['TestFilename.java'],
      content: ['']
    });
  }

  setupValidators() {
    this.exerciseFormGroup.get('intro').get('type').valueChanges.subscribe(typeValue => {
      if (typeValue.value.search('test') !== -1) {
        this.exerciseFormGroup.get('exerciseTests').controls.forEach(control => {
          control.get('content').setValidators(Validators.required);
          control.get('content').updateValueAndValidity();
        });
      } else {
        this.exerciseFormGroup.get('exerciseTests').controls.forEach(control => {
          control.get('content').clearValidators();
          control.get('content').updateValueAndValidity();
        });
      }
    });
    this.exerciseFormGroup.get('shownTestsType').get('chosen').valueChanges.subscribe(chosenValue => {
      if (chosenValue === 'custom') {
        this.exerciseFormGroup.get('shownTests').controls.forEach(control => {
          control.get('content').setValidators(Validators.required);
          control.get('content').updateValueAndValidity();
        });
      } else if (chosenValue === 'same') {
        this.exerciseFormGroup.get('shownTests').controls.forEach(control => {
          control.get('content').clearValidators();
          control.get('content').updateValueAndValidity();
        });
      }
    });
  }


  remove(index: number) {
    const tests = this.exerciseFormGroup.get('tests') as FormArray;
    tests.removeAt(index);
  }

  editFilename(formControl: FormControl) {
    this.dialogRef = this.dialog.open(DialogComponent);
    this.dialogRef.afterClosed().subscribe(result => {
      if (result === undefined) {
        return;
      }
      formControl.setValue(`${result}.java`);
    });
  }

  add() {
    const tests = this.exerciseFormGroup.get('tests') as FormArray;
    tests.push(this.createExerciseTests());
  }

}
