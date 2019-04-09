import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, FormArray, FormControl, Validators } from '@angular/forms';
import { MatDialog, MatDialogRef } from '@angular/material';
import { DialogComponent } from '../dialog/dialog.component';

@Component({
  selector: 'create-source',
  templateUrl: './create-source.component.html',
  styleUrls: ['./create-source.component.scss']
})
export class CreateSourceComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };
  dialogRef: MatDialogRef<DialogComponent>;

  constructor(
    private fb: FormBuilder,
    public dialog: MatDialog
  ) { }

  ngOnInit() {
    this.setSources();
  }

  setSources() {
    this.exerciseFormGroup.addControl(
      'sources', this.fb.array([this.createSource()])
    );
  }

  createSource(): FormGroup {
    return this.fb.group({
      filename: ['SourceCodeFilename.java'],
      content: ['', Validators.compose([Validators.required])]
    });
  }


  removeSource(index: number) {
    const sources = this.exerciseFormGroup.get('sources') as FormArray;
    sources.removeAt(index);
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
    sources.push(this.createSource());
  }

}
