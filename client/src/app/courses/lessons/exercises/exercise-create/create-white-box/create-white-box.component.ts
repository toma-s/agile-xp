import { Component, OnInit, Input, Inject } from '@angular/core';
import { ControlContainer, FormGroupDirective, FormGroup, FormBuilder, Validators, FormControl, FormArray } from '@angular/forms';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';

@Component({
  selector: 'create-white-box',
  templateUrl: './create-white-box.component.html',
  styleUrls: ['./create-white-box.component.scss'],
  viewProviders: [ {
    provide: ControlContainer,
    useExisting: FormGroupDirective
  }]
})
export class CreateWhiteBoxComponent implements OnInit {

  editorOptions = {theme: 'vs', language: 'java'};

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
      'sources', this.fb.array([this.createSource(), this.createSource(), this.createSource()])
    );
    this.exerciseFormGroup.addControl(
      'tests', this.fb.array([this.createTest(), this.createTest()])
    );
  }

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
        <input matInput [(ngModel)]="fileName">
      </mat-form-field>.java
      <div mat-dialog-actions>
        <button mat-button [mat-dialog-close]="fileName" cdkFocusInitial>Submit</button>
        <button mat-button (click)="onNoClick()">No Thanks</button>
      </div>
    </div>`,
})
export class DialogOverviewExampleDialogComponent {

  constructor(
    public dialogRef: MatDialogRef<DialogOverviewExampleDialogComponent>,
    // @Inject(MAT_DIALOG_DATA) public fileName: string
    ) {}

  onNoClick(): void {
    this.dialogRef.close();
  }
}
