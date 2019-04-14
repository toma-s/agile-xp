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

  async ngOnInit() {
    await this.updForm();
  }

  async updForm() {
    const exerciseId = this.solutionFormGroup.get('intro').get('exerciseLoadSolutionSources').value;
    if (exerciseId === -1) {
      this.setControl(this.solutionFormGroup.controls.exerciseSources.controls);
    } else {
      this.solutionSourceService.getSolutionSourcesByExerciseId(exerciseId).subscribe(
        data => {
          this.setControl(this.getGroup(data));
        },
        error => console.log(error)
      );
    }
  }

  setControl(control) {
    this.solutionFormGroup.addControl(
      'solutionSources', this.fb.array(control)
    );
  }

  getGroup(array: Array<any>) {
    const fgs = new Array<FormGroup>();
    array.forEach(e => {
      const fg = this.fb.group({
        id: [e.id],
        filename: [e.filename],
        content: [e.content],
        exerciseId: [e.exerciseId]
      });
      fgs.push(fg);
    });
    return fgs;
  }

}
