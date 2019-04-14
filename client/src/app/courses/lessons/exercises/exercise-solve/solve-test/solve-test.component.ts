import { Component, OnInit, Input } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { SolutonTestService } from '../../shared/solution-test/solution-test.service';

@Component({
  selector: 'solve-test',
  templateUrl: './solve-test.component.html',
  styleUrls: ['./solve-test.component.scss']
})
export class SolveTestComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };

  constructor(
    private fb: FormBuilder,
    private solutionTestService: SolutonTestService
  ) { }

  async ngOnInit() {
    await this.updForm();
  }

  async updForm() {
    const exerciseId = this.solutionFormGroup.get('intro').get('exerciseLoadSolutionTests').value;
    if (exerciseId === -1) {
      this.setControl(this.solutionFormGroup.controls.exerciseTests.controls);
    } else {
      this.solutionTestService.getSolutionTestsByExerciseId(exerciseId).subscribe(
        data => {
          this.setControl(this.getGroup(data));
        },
        error => console.log(error)
      );
    }
  }

  setControl(control) {
    this.solutionFormGroup.addControl(
      'solutionTests', this.fb.array(control)
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
