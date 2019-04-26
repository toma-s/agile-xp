import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';
import { ExerciseService } from '../../shared/exercise/exercise/exercise.service';
import { PublicSourceService } from '../../shared/public/public-source/public-source.service';
import { PublicTestService } from '../../shared/public/public-test/public-test.service';
import { PublicFileService } from '../../shared/public/public-file/public-file.service';
import { ExerciseTypeService } from '../../shared/exercise/exercise-type/exercise-type.service';
import { FormBuilder } from '@angular/forms';
import { ExerciseUpsertComponent } from '../exercise-upsert.component';

@Component({
  selector: 'app-exercise-upsert',
  templateUrl: '../exercise-upsert.component.html',
  styleUrls: ['../exercise-upsert.component.scss']
})
export class ExerciseEditComponent extends ExerciseUpsertComponent {

  constructor(
    protected titleService: Title,
    protected route: ActivatedRoute,
    protected exerciseService: ExerciseService,
    protected publicSourceService: PublicSourceService,
    protected publicTestService: PublicTestService,
    protected publicFileService: PublicFileService,
    protected exerciseTypeService: ExerciseTypeService,
    protected fb: FormBuilder
  ) {
    super(titleService, route, exerciseService, publicSourceService, publicTestService, publicFileService, exerciseTypeService, fb);
  }

}
