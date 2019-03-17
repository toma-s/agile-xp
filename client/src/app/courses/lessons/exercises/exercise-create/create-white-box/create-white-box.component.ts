import { Component, OnInit, Input } from '@angular/core';
import { ControlContainer, FormGroupDirective, FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'create-white-box',
  templateUrl: './create-white-box.component.html',
  styleUrls: ['./create-white-box.component.scss'],
  viewProviders: [ {
    provide: ControlContainer,
    useExisting: FormGroupDirective
  }]
})
export class CreateWhiteBoxComponent implements OnInit {

  editorOptions = {theme: 'vs', language: 'java'};

  @Input() exerciseFormGroup: FormGroup;

  constructor(
    private fb: FormBuilder
  ) { }

  ngOnInit(): void {
    console.log(this.exerciseFormGroup);
    this.updForm();
  }

  updForm() {
    this.exerciseFormGroup.addControl(
      'sources', this.fb.array([this.createSource()])
    );
    this.exerciseFormGroup.addControl(
      'tests', this.fb.array([this.createTest()])
    );
  }

  createSource() {
    return this.fb.group({
      sourceFilename: ['SourceCodeFileName.java', Validators.compose([Validators.required])],
      sourceCode: ['null', Validators.compose([Validators.required])]
    });
  }

  createTest() {
    return this.fb.group({
      testFilename: ['TestFileName.java', Validators.compose([Validators.required])],
      testCode: [null, Validators.compose([Validators.required])]
    });
  }

}
