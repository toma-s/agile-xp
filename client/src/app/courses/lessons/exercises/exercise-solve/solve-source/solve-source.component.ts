import { Component, OnInit, Input } from '@angular/core';
import { FormBuilder, FormGroup, FormArray } from '@angular/forms';
import { SolutionSource } from '../../shared/solution-source/solution-source.model';

@Component({
  selector: 'solve-source',
  templateUrl: './solve-source.component.html',
  styleUrls: ['./solve-source.component.scss']
})
export class SolveSourceComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };

  constructor(
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.updForm();
  }

  updForm() {
    this.setSolutionSources();
  }

  setSolutionSources() {
    const exerciseSources = this.solutionFormGroup.controls.exerciseSources.controls;
    this.solutionFormGroup.addControl(
      'solutionSources', this.fb.array(exerciseSources)
    );
  }

}
