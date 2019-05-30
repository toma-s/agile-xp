import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, ControlContainer, FormArray, FormControl, FormBuilder, Validators } from '@angular/forms';
import { DialogComponent } from '../dialog/dialog.component';
import { MatDialogRef, MatDialog, MatDialogConfig } from '@angular/material';

@Component({
  selector: 'editor',
  templateUrl: './editor.component.html',
  styleUrls: ['./editor.component.scss']
})
export class EditorComponent implements OnInit {

  @Input() editorOptions;
  fileExtention = '';
  form: FormGroup;
  dialogRef: MatDialogRef<DialogComponent>;

  constructor(
    private fb: FormBuilder,
    public dialog: MatDialog,
    public controlContainer: ControlContainer
  ) { }

  ngOnInit() {
    this.form = <FormGroup>this.controlContainer.control;
    this.setFileExtention();
  }

  setFileExtention() {
    if (this.editorOptions.language.search('text') !== -1) {
      this.fileExtention = 'txt';
    } else if (this.editorOptions.language.search('java') !== -1) {
      this.fileExtention = 'java';
    }
  }

  remove(index: number) {
    const formArray = this.form.get('tabContent') as FormArray;
    formArray.removeAt(index);
  }

  editFilename(formControl: FormControl) {
    const config = new MatDialogConfig();
    this.dialogRef = this.dialog.open(DialogComponent, config);
    this.dialogRef.componentInstance.fileExtention = this.fileExtention;
    this.dialogRef.afterClosed().subscribe(result => {
      if (result === undefined) {
        return;
      }
      formControl.setValue(`${result}.${this.fileExtention}`);
    });
  }

  add() {
    const formArray = this.form.get('tabContent') as FormArray;
    formArray.push(this.create());
  }

  create(): FormGroup {
    return this.fb.group({
      filename: [`filename.${this.fileExtention}`],
      content: ['']
    });
  }

}
