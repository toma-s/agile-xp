import { Component, OnInit, Input } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';

@Component({
  selector: 'solve-test',
  templateUrl: './solve-test.component.html',
  styleUrls: ['./solve-test.component.scss']
})
export class SolveTestComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };

  constructor(
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.updForm();
  }

  updForm() {
    this.setSolutionTests();
  }

  setSolutionTests() {
    const exerciseTests = this.solutionFormGroup.controls.exerciseTests.controls;
    this.solutionFormGroup.addControl(
      'solutionTests', this.fb.array(exerciseTests)
    );
  }

}
