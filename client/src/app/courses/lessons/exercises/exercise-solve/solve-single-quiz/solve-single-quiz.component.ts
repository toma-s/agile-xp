import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';

@Component({
  selector: 'solve-single-quiz',
  templateUrl: './solve-single-quiz.component.html',
  styleUrls: ['./solve-single-quiz.component.scss']
})
export class SolveSingleQuizComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;

  constructor(
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.updForm();
  }

  updForm() {
    this.solutionFormGroup.addControl(
      'solutionSingleQuiz', this.fb.array([this.createSolutionSingleQuiz()])
    );
  }

  createSolutionSingleQuiz() {
    console.log('createSolutionSingleQuiz');
  }

}
