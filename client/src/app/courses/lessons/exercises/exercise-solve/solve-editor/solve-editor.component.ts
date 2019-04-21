import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, ControlContainer, FormArray } from '@angular/forms';
import { MatDialog, MatDialogRef, MatDialogConfig } from '@angular/material';
import { LoadSolutionDialogComponent } from '../load-solution-dialog/load-solution-dialog.component';
import { SolutionContent } from '../../shared/solution/solution-content/solution-content.model';
import { PublicSourceService } from '../../shared/public/public-source/public-source.service';
import { PublicTestService } from '../../shared/public/public-test/public-test.service';
import { PublicFileService } from '../../shared/public/public-file/public-file.service';

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
    public dialog: MatDialog,
    private publicSourceService: PublicSourceService,
    private publicTestService: PublicTestService,
    private publicFileService: PublicFileService,
  ) { }

  async ngOnInit() {
    this.form = <FormGroup>this.controlContainer.control;
    console.log(this.form);
  }

  reset() {
    const exerciseId = this.solutionFormGroup.get('intro').get('exerciseId').value;
    switch (this.form.get('solutionType').value) {
      case 'source': {
        this.publicSourceService.getPublicSourcesByExerciseId(exerciseId).subscribe(
          data => this.form.get('solutionControl').setValue(data),
          error => console.log(error)
        );
        break;
      }
      case 'test': {
        this.publicTestService.getPublicTestsByExerciseId(exerciseId).subscribe(
          data => this.form.get('solutionControl').setValue(data),
          error => console.log(error)
        );
        break;
      }
      case 'file': {
        this.publicFileService.getPublicFilesByExerciseId(exerciseId).subscribe(
          data => this.form.get('solutionControl').setValue(data),
          error => console.log(error)
        );
        break;
      }
    }
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
      this.updateContent(result);
      console.log(result);
    });
  }

  updateContent(newSolutionContent: SolutionContent) {
    const currentContents: Array<SolutionContent> = this.form.get('solutionControl').value;
    for (let i = 0; i < currentContents.length; i++) {
      const currentContent = currentContents[i];
      if (currentContent.filename === newSolutionContent.filename) {
        const control = this.form.get('solutionControl') as FormArray;
        const controlItem = control.at(i);
        controlItem.get('content').setValue(newSolutionContent.content);
      }
    }
  }

}
