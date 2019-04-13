import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormArray, FormControl } from '@angular/forms';
import { MatDialogRef, MatDialog } from '@angular/material';
import { DialogComponent } from '../dialog/dialog.component';

@Component({
  selector: 'create-file',
  templateUrl: './create-file.component.html',
  styleUrls: ['./create-file.component.scss']
})
export class CreateFileComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  editorOptions = { theme: 'vs', /*, minimap: {'enabled': false}*/ };
  dialogRef: MatDialogRef<DialogComponent>;
  files = 'files';

  constructor(
    private fb: FormBuilder,
    public dialog: MatDialog
  ) { }

  ngOnInit() {
    this.set();
  }

  set() {
    this.exerciseFormGroup.addControl(
      this.files, this.fb.array([this.create()])
    );
  }

  create(): FormGroup {
    return this.fb.group({
      filename: ['FileFilename.java'],
      content: ['', Validators.compose([Validators.required])]
    });
  }


  remove(index: number) {
    const files = this.exerciseFormGroup.get(this.files) as FormArray;
    files.removeAt(index);
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
    const files = this.exerciseFormGroup.get(this.files) as FormArray;
    files.push(this.create());
  }

}
