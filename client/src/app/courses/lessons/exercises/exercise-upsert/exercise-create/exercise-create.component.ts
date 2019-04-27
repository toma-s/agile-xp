import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';
import { ExerciseService } from '../../shared/exercise/exercise/exercise.service';
import { PublicSourceService } from '../../shared/public/public-source/public-source.service';
import { PublicTestService } from '../../shared/public/public-test/public-test.service';
import { PublicFileService } from '../../shared/public/public-file/public-file.service';
import { ExerciseTypeService } from '../../shared/exercise/exercise-type/exercise-type.service';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { ExerciseUpsertComponent } from '../exercise-upsert.component';
import { Exercise } from '../../shared/exercise/exercise/exercise.model';

@Component({
  selector: 'exercise-create',
  templateUrl: '../exercise-upsert.component.html',
  styleUrls: ['../exercise-upsert.component.scss']
})
export class ExerciseCreateComponent extends ExerciseUpsertComponent {

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
      type: [null, Validators.compose([Validators.required])]
    });
  }


  getExerciseGroup(exerciseType: string) {
    return this.fb.group({
      exerciseType: [exerciseType],
      privateControl: this.fb.group({
        tabContent: this.fb.array([this.create(null)])
      }),
      publicType: this.fb.group({
        chosen: ['same', Validators.compose([Validators.required])]
      }),
      publicControl: this.fb.group({
        tabContent: this.fb.array([this.create(null)])
      })
    });
  }

  create(validators): FormGroup {
    return this.fb.group({
      filename: ['filename.java'],
      content: ['', validators]
    });
  }


  setupValidatorsOnInit() {}

}
