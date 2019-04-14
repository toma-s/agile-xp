import { Component, OnInit, Input } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { SolutonSourceService } from '../../shared/solution-source/solution-source.service';
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
    private fb: FormBuilder,
    private solutionSourceService: SolutonSourceService
  ) { }

  ngOnInit() {
    this.updForm();
  }

  updForm() {
    this.setSolutionSources();
  }

  async setSolutionSources() {
    let exerciseSources;
    const exerciseId = this.solutionFormGroup.get('intro').get('exerciseLoadSolutionSources').value;
    if (exerciseId === -1) {
      console.log('load from exercise');
      exerciseSources = this.solutionFormGroup.controls.exerciseSources.controls;
      // this.solutionFormGroup.addControl(
      //   'solutionSources', this.fb.array(exerciseSources)
      // );
    } else {
      console.log('log from solution');
      exerciseSources = await this.getLoadedSolutionSources(exerciseId);
    }
    this.solutionFormGroup.addControl(
      'solutionSources', this.fb.array(exerciseSources)
    );
  }

  getLoadedSolutionSources(exerciseId: number) {
    return new Promise<Array<SolutionSource>>((resolve, reject) => {
      this.solutionSourceService.getSolutionSourceByExerciseId(exerciseId).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

}
