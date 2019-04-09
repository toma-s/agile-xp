import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormArray, FormControl } from '@angular/forms';
import { MatDialogRef, MatDialog } from '@angular/material';
import { DialogComponent } from '../create-source/dialog/dialog.component';

@Component({
  selector: 'create-editor',
  templateUrl: './create-editor.component.html',
  styleUrls: ['./create-editor.component.scss']
})
export class CreateEditorComponent implements OnInit {

  @Input() editorType: string;
  @Input() exerciseFormGroup: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };
  dialogRef: MatDialogRef<DialogComponent>;

  constructor(
    private fb: FormBuilder,
    public dialog: MatDialog
  ) { }

  ngOnInit() {
    console.log(this.editorType);
    this.setFormControls();
  }

  get controlArray(): FormArray {
    return this.exerciseFormGroup.get('source') as FormArray;
    // switch (this.editorType) {
    //   case 'source': {
    //     return this.exerciseFormGroup.get('source') as FormArray;
    //   }
    //   case 'test': {
    //     return this.exerciseFormGroup.get('test') as FormArray;
    //   }
    //   case 'file': {
    //     return this.exerciseFormGroup.get('file') as FormArray;
    //   }
    // }
    // return;
  }

  setFormControls() {
    const item = this.create();
    this.exerciseFormGroup.addControl(
      this.editorType, this.fb.array([item])
    );
  }

  create(): FormGroup {
    return this.fb.group({
      filename: [`${this.editorType}Filename.java`],
      content: ['', Validators.compose([Validators.required])]
    });
  }


  remove(index: number) {
    const formArray = this.exerciseFormGroup.get(this.editorType) as FormArray;
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
    const formArray = this.exerciseFormGroup.get(this.editorType) as FormArray;
    formArray.push(this.create());
  }

}
