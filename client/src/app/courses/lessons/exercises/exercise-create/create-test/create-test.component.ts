import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormArray, FormControl } from '@angular/forms';
import { MatDialogRef, MatDialog } from '@angular/material';
import { DialogComponent } from '../create-source/dialog/dialog.component';

@Component({
  selector: 'create-test',
  templateUrl: './create-test.component.html',
  styleUrls: ['./create-test.component.scss']
})
export class CreateTestComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };
  dialogRef: MatDialogRef<DialogComponent>;

  constructor(
    private fb: FormBuilder,
    public dialog: MatDialog
  ) { }

  ngOnInit() {
    this.setTests();
  }

  setTests() {
    this.exerciseFormGroup.addControl(
      'tests', this.fb.array([this.createTest()])
    );
  }

  createTest(): FormGroup {
    return this.fb.group({
      filename: ['TestFilename.java'],
      content: ['', Validators.compose([Validators.required])]
    });
  }


  removeTest(index: number) {
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

  addSource() {
    const sources = this.exerciseFormGroup.get('sources') as FormArray;
    sources.push(this.createTest());
  }

}
