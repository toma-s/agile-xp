import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, ControlContainer } from '@angular/forms';

@Component({
  selector: 'solve-editor',
  templateUrl: './solve-editor.component.html',
  styleUrls: ['./solve-editor.component.scss']
})
export class SolveEditorComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  form: FormGroup;

  constructor(
    public controlContainer: ControlContainer
  ) { }

  ngOnInit() {
    this.form = <FormGroup>this.controlContainer.control;
  }

}
