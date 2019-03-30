import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';

@Component({
  selector: 'solve-file',
  templateUrl: './solve-file.component.html',
  styleUrls: ['./solve-file.component.scss']
})
export class SolveFileComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;

  constructor(
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.updForm();
  }

  updForm() {
    this.solutionFormGroup.addControl(
      'solutionFiles', this.fb.array([this.createSolutionFile()])
    );
  }

  createSolutionFile() {
    console.log('createSolutionFile');
  }

}
