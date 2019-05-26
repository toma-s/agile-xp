import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { ExerciseUpsertComponent } from '../exercise-upsert.component';
import { ActivatedRoute } from '@angular/router';
import { Exercise } from '../../shared/exercise/exercise/exercise.model';
import { ExerciseType } from '../../shared/exercise/exercise-type/exercise-type.model';
import { ExerciseTypeService } from '../../shared/exercise/exercise-type/exercise-type.service';
import { BugsNumber } from '../../shared/exercise/bugs-number/bugs-number.model';

@Component({
  selector: 'exercise-create',
  templateUrl: '../exercise-upsert.component.html',
  styleUrls: ['../exercise-upsert.component.scss']
})
export class ExerciseCreateComponent extends ExerciseUpsertComponent {

  protected mode = 'create';
  protected types;

  constructor(
    protected titleService: Title,
    protected fb: FormBuilder,
    protected exerciseTypeServise: ExerciseTypeService,
    private route: ActivatedRoute
  ) {
    super(titleService, fb, exerciseTypeServise);
  }

  setTitle() {
    this.titleService.setTitle(`Create exercise | AgileXP`);
  }

  async getIntroGroup() {
    const exercise = new Exercise();
    exercise.index = this.route.snapshot.params['index'];
    exercise.lessonId = this.route.snapshot.params['lessonId'];
    return this.fb.group({
      exercise: this.getGroupForExercise(exercise, this.types[0]),
      mode: 'create',
      bugsNumber: new BugsNumber()
    });
  }

  getExerciseGroup(exerciseType: string) {
    return this.fb.group({
      exerciseType: [exerciseType],
      privateControl: this.fb.group({
        tabContent: this.fb.array([this.create()], Validators.required)
      }),
      publicType: this.fb.group({
        chosen: ['same', Validators.required]
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


  setupValidatorsOnInit() { }

}
