import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { ExerciseUpsertComponent } from '../exercise-upsert.component';

@Component({
  selector: 'exercise-create',
  templateUrl: '../exercise-upsert.component.html',
  styleUrls: ['../exercise-upsert.component.scss']
})
export class ExerciseCreateComponent extends ExerciseUpsertComponent {

  protected mode = 'create';

  constructor(
    protected titleService: Title,
    protected fb: FormBuilder
  ) {
    super(titleService,  fb);
  }

  setTitle() {
    this.titleService.setTitle(`Create exercise | AgileXP`);
  }

  async getIntroGroup() {
    return this.fb.group({
      name: ['', Validators.compose([Validators.required])],
      description: ['', Validators.compose([Validators.required])],
      type: [null, Validators.compose([Validators.required])],
      mode: 'create'
    });
  }


  getExerciseGroup(exerciseType: string) {
    return this.fb.group({
      exerciseType: [exerciseType],
      privateControl: this.fb.group({
        tabContent: this.fb.array([this.create()], Validators.required)
      }),
      publicType: this.fb.group({
        chosen: ['same', Validators.compose([Validators.required])]
      }),
      publicControl: this.fb.group({
        tabContent: this.fb.array([this.create()], Validators.required)
      })
    });
  }

  create(): FormGroup {
    return this.fb.group({
      filename: ['filename.java'],
      content: ['']
    });
  }


  setupValidatorsOnInit() {}

}
