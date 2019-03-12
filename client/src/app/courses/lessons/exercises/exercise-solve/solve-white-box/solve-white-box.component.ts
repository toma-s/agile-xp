import { Component, Input } from '@angular/core';
import { Exercise } from '../../shared/exercise.model';
import { SolutionSource } from '../../shared/solution-source.model';

@Component({
  selector: 'solve-white-box',
  templateUrl: './solve-white-box.component.html',
  styleUrls: ['./solve-white-box.component.scss']
})
export class SolveWhiteBoxComponent {

  editorOptions = {theme: 'vs', language: 'java'};

  @Input() exercise: Exercise;
  @Input() solutionSourceCodes: Array<SolutionSource>;

}