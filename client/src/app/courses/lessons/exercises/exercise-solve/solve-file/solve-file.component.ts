import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ExerciseConfigService } from '../../shared/exercise-config/exercise-config.service';
import { ExerciseConfig } from '../../shared/exercise-config/exercise-config.model';

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
    private exerciseConfigService: ExerciseConfigService
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
