import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, ControlContainer } from '@angular/forms';
import { SolutionContent } from '../../shared/solution/solution-content/solution-content.model';
import { SolutonSourceService } from '../../shared/solution/solution-source/solution-source.service';
import { SolutonTestService } from '../../shared/solution/solution-test/solution-test.service';
import { SolutionFileService } from '../../shared/solution/solution-file/solution-file.service';

@Component({
  selector: 'solve-editor',
  templateUrl: './solve-editor.component.html',
  styleUrls: ['./solve-editor.component.scss']
})
export class SolveEditorComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  form: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };
  loadedSolutions: Array<SolutionContent>;

  constructor(
    public controlContainer: ControlContainer,
    private solutionSourceService: SolutonSourceService,
    private solutionTestService: SolutonTestService,
    private solutionFileService: SolutionFileService,
  ) { }

  ngOnInit() {
    this.form = <FormGroup>this.controlContainer.control;
    this.loadSolutions();
  }

  loadSolutions() {
    const exerciseId: number = Number(this.solutionFormGroup.get('intro').get('exerciseId').value);
    switch (this.form.get('solutionType').value) {
      case 'source': {
        this.solutionSourceService.getSolutionSourcesByExerciseId(exerciseId).subscribe(
          data => {
            this.loadedSolutions = data;
            console.log(data);
          },
          error => console.log(error)
        );
        console.log('source');
        break;
      }
      case 'test': {
        console.log('test');
        break;
      }
      case 'file': {
        console.log('file');
        break;
      }
    }
  }

}
