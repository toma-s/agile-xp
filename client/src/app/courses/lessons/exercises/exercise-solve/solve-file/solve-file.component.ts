import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { PublicFileService } from '../../shared/public-file/public-file.service';

@Component({
  selector: 'solve-file',
  templateUrl: './solve-file.component.html',
  styleUrls: ['./solve-file.component.scss']
})
export class SolveFileComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  editorOptions = { theme: 'vs', /*, minimap: {'enabled': false}*/ };

  constructor(
    private fb: FormBuilder,
    private publicFileService: PublicFileService
  ) { }

  async ngOnInit() {
    await this.updForm();
  }

  async updForm() {
    const exerciseId = Number(this.solutionFormGroup.get('intro').get('exerciseId').value);
    this.publicFileService.getPublicFilesByExerciseId(exerciseId).subscribe(
      data => {
        console.log(data);
        this.setControl(this.getGroup(data));
      },
      error => console.log(error)
    );
  }

  setControl(control) {
    this.solutionFormGroup.addControl(
      'solutionFiles', this.fb.array(control)
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
