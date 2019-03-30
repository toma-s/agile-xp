import { Component, OnInit, Input } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';

@Component({
  selector: 'solve-source',
  templateUrl: './solve-source.component.html',
  styleUrls: ['./solve-source.component.scss']
})
export class SolveSourceComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;

  constructor(
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.updForm();
  }

  updForm() {
    this.solutionFormGroup.addControl(
      'solutionSources', this.fb.array([this.createSolutionSource()])
    );
  }

  createSolutionSource() {
    console.log('createSolutionSource');
  }

}
