import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';

@Component({
  selector: 'solve-multiple-quiz',
  templateUrl: './solve-multiple-quiz.component.html',
  styleUrls: ['./solve-multiple-quiz.component.scss']
})
export class SolveMultipleQuizComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;

  constructor(
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.updForm();
  }

  updForm() {
    this.solutionFormGroup.addControl(
      'solutionMultipleQuiz', this.fb.array([this.createSolutionMultipleQuiz()])
    );
  }

  createSolutionMultipleQuiz() {
    console.log('createSolutionMultipleQuiz');
  }

}
