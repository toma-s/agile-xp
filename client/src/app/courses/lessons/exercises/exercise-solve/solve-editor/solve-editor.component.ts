import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, ControlContainer } from '@angular/forms';
import { MatDialog, MatDialogRef, MatDialogConfig } from '@angular/material';
import { LoadSolutionDialogComponent } from '../load-solution-dialog/load-solution-dialog.component';

@Component({
  selector: 'solve-editor',
  templateUrl: './solve-editor.component.html',
  styleUrls: ['./solve-editor.component.scss']
})
export class SolveEditorComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  form: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };
  dialogRef: MatDialogRef<LoadSolutionDialogComponent>;

  constructor(
    public controlContainer: ControlContainer,
    public dialog: MatDialog
  ) { }

  async ngOnInit() {
    this.form = <FormGroup>this.controlContainer.control;
  }

  reset() {
    // TODO | todo reset()
  }

  showLoadSolutionDialog() {
    const config = new MatDialogConfig();
    this.dialogRef = this.dialog.open(LoadSolutionDialogComponent, config);
    this.dialogRef.componentInstance.exerciseId = Number(this.solutionFormGroup.get('intro').get('exerciseId').value);
    this.dialogRef.componentInstance.solutionType = this.form.get('solutionType').value;
    this.dialogRef.afterClosed().subscribe(result => {
      if (result === undefined) {
        return;
      }
      console.log(result);
    });
  }

}
