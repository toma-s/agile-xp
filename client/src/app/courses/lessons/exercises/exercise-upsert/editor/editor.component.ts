import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, ControlContainer, FormArray, FormControl, FormBuilder, Validators } from '@angular/forms';
import { DialogComponent } from '../dialog/dialog.component';
import { MatDialogRef, MatDialog } from '@angular/material';

@Component({
  selector: 'editor',
  templateUrl: './editor.component.html',
  styleUrls: ['./editor.component.scss']
})
export class EditorComponent implements OnInit {

  @Input() type: string;
  @Input() editorOptions;
  form: FormGroup;
  dialogRef: MatDialogRef<DialogComponent>;

  constructor(
    private fb: FormBuilder,
    public dialog: MatDialog,
    public controlContainer: ControlContainer
  ) { }

  ngOnInit() {
    this.form = <FormGroup>this.controlContainer.control;
    console.log(this.form);
  }

  remove(index: number) {
    const formArray = this.form.get('tabContent') as FormArray;
    formArray.removeAt(index);
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
    const formArray = this.form.get('tabContent') as FormArray;
    formArray.push(this.create());
  }

  create(): FormGroup {
    return this.fb.group({
      filename: ['filename.java'],
      content: ['']
    });
  }

}
