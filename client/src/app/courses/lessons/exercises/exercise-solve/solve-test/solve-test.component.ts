import { Component, OnInit, Input } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { PublicTestService } from '../../shared/public-test/public-test.service';

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
    private publicTestService: PublicTestService
  ) { }

  async ngOnInit() {
    await this.updForm();
  }

  async updForm() {
    const exerciseId = Number(this.solutionFormGroup.get('intro').get('exerciseId').value);
    this.publicTestService.getPublicTestsByExerciseId(exerciseId).subscribe(
      data => {
        console.log(data);
        this.setControl(this.getGroup(data));
      },
      error => console.log(error)
    );
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
