import { Component, OnInit, Input } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { PublicSourceService } from '../../shared/public-source/public-source.service';

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
    private publicSourceService: PublicSourceService
  ) { }

  async ngOnInit() {
    await this.updForm();
  }

  async updForm() {
    const exerciseId = Number(this.solutionFormGroup.get('intro').get('exerciseId').value);
    this.publicSourceService.getPublicSourcesByExerciseId(exerciseId).subscribe(
      data => {
        console.log(data);
        this.setControl(this.getGroup(data));
      },
      error => console.log(error)
    );
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
