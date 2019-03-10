import { Component, Input, ViewEncapsulation } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { Exercise } from '../../shared/exercise.model';

@Component({
  selector: 'solve-white-box',
  templateUrl: './solve-white-box.component.html',
  styleUrls: ['./solve-white-box.component.scss']
})
export class SolveWhiteBoxComponent {

  @Input() solutionFormGroup: FormGroup;
  @Input() exercise: Exercise;

}
