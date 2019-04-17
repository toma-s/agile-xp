import { Component, OnInit, Input } from '@angular/core';
import { FormGroup } from '@angular/forms';

@Component({
  selector: 'solve-intro',
  templateUrl: './solve-intro.component.html',
  styleUrls: ['./solve-intro.component.scss']
})
export class SolveIntroComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  exerciseName: string;
  exerciseDescription: string;

  constructor(
  ) { }

  ngOnInit() {
    this.getValues();
  }

  getValues() {
    this.exerciseName = this.solutionFormGroup.controls.intro.controls.exerciseName.value;
    this.exerciseDescription = this.solutionFormGroup.controls.intro.controls.exerciseDescription.value;
  }

}
