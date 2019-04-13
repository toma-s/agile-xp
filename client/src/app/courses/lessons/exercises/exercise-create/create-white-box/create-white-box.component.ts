import { Component, OnInit, Input } from '@angular/core';
import { ControlContainer, FormGroupDirective, FormGroup, FormBuilder, Validators, FormControl, FormArray } from '@angular/forms';
import { MatDialog, MatDialogRef } from '@angular/material';

@Component({
  selector: 'create-white-box',
  templateUrl: './create-white-box.component.html',
  styleUrls: ['./create-white-box.component.scss'],
  viewProviders: [{
    provide: ControlContainer,
    useExisting: FormGroupDirective
  }]
})
export class CreateWhiteBoxComponent implements OnInit {

  editorOptions = { theme: 'vs', language: 'java' };

  @Input() exerciseFormGroup: FormGroup;

  constructor(
    private fb: FormBuilder,
    public dialog: MatDialog
  ) { }

  ngOnInit(): void {
    console.log(this.exerciseFormGroup);
    this.updForm();
  }

  updForm() {
    this.exerciseFormGroup.addControl(
      'sources', this.fb.array([this.createSource()])
    );
    this.exerciseFormGroup.addControl(
      'tests', this.fb.array([this.createTest()])
    );
  }

  // ------------------

  createSource() {
    return this.fb.group({
      sourceFilename: ['SourceCodeFileName.java', Validators.compose([Validators.required])],
      sourceCode: ['', Validators.compose([Validators.required])]
    });
  }

  createTest() {
    return this.fb.group({
      testFilename: ['TestFileName.java', Validators.compose([Validators.required])],
      testCode: ['', Validators.compose([Validators.required])]
    });
  }

  editFileName(formControl: FormControl) {
    const dialogRef = this.dialog.open(DialogOverviewExampleDialogComponent);
    dialogRef.afterClosed().subscribe(result => {
      if (result === undefined) { return; }
      formControl.setValue(`${result}.java`);
    });
  }

  removeSourceFile(index) {
    const sources = this.exerciseFormGroup.get('sources') as FormArray;
    sources.removeAt(index);
  }

  removeTestFile(index) {
    const tests = this.exerciseFormGroup.get('tests') as FormArray;
    tests.removeAt(index);
  }

  addSourceFile() {
    const sources = this.exerciseFormGroup.get('sources') as FormArray;
    sources.push(this.createSource());
  }

  addTestFile() {
    const tests = this.exerciseFormGroup.get('tests') as FormArray;
    tests.push(this.createTest());
  }

}

@Component({
  selector: 'dialog-result-example-dialog',
  template: `
    <div>
      <p mat-dialog-title>Enter new file name:</p>
      <mat-form-field>
        <input autofocus matInput [(ngModel)]="filename">
      </mat-form-field>.java
      <div mat-dialog-actions>
        <button mat-button [mat-dialog-close]="filename">Save</button>
        <button mat-button (click)="onNoClick()">Cancel</button>
      </div>
    </div>`,
})
export class DialogOverviewExampleDialogComponent {

  constructor(
    public dialogRef: MatDialogRef<DialogOverviewExampleDialogComponent>
  ) { }

  onNoClick(): void {
    this.dialogRef.close();
  }
}
