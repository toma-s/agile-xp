import { Component, OnInit, Input } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';

@Component({
  selector: 'solve-test',
  templateUrl: './solve-test.component.html',
  styleUrls: ['./solve-test.component.scss']
})
export class SolveTestComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;

  constructor(
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.updForm();
  }

  updForm() {
    this.solutionFormGroup.addControl(
      'solutionTests', this.fb.array([this.createSolutionTest()])
    );
  }

  createSolutionTest() {
    console.log('createSolutionTest');
  }

}
