import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ExerciseFileService } from '../../shared/exercise-file/exercise-file.service';
import { ExerciseFile } from '../../shared/exercise-file/exercise-file.model';

@Component({
  selector: 'solve-file',
  templateUrl: './solve-file.component.html',
  styleUrls: ['./solve-file.component.scss']
})
export class SolveFileComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };

  constructor(
    private fb: FormBuilder,
    private exerciseFileService: ExerciseFileService
  ) { }

  ngOnInit() {
    this.updForm();
  }


  updForm() {
    this.setSolutionFiles();
  }

  setSolutionFiles() {
    const exerciseFiles = this.solutionFormGroup.controls.exerciseFiles.controls;
    this.solutionFormGroup.addControl(
      'solutionFiles', this.fb.array(exerciseFiles)
    );
  }

}
