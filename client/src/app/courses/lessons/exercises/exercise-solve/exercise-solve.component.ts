import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';
import { ExerciseService } from '../shared/exercise/exercise.service';
import { Exercise } from '../shared/exercise/exercise.model';
import { ExerciseTypeService } from '../shared/exercise-type/exercise-type.service';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ExerciseType } from '../shared/exercise-type/exercise-type.model';
import { ExerciseSource } from '../shared/exercise-source/exercise-source.model';
import { ExerciseTest } from '../shared/exercise-test/exercise-test.model';
import { ExerciseConfig } from '../shared/exercise-config/exercise-config.model';
import { ExerciseSourceService } from '../shared/exercise-source/exercise-source.service';
import { ExerciseTestService } from '../shared/exercise-test/exercise-test.service';
import { ExerciseConfigService } from '../shared/exercise-config/exercise-config.service';

@Component({
  selector: 'exercise-solve',
  templateUrl: './exercise-solve.component.html',
  styleUrls: ['./exercise-solve.component.scss']
})
export class ExerciseSolveComponent implements OnInit {

  exercise: Exercise;
  exerciseSources: Array<ExerciseSource> = new Array<ExerciseSource>();
  exerciseTests: Array<ExerciseTest> = new Array<ExerciseTest>();
  exerciseConfigs: Array<ExerciseConfig> = new Array<ExerciseConfig>();

  exerciseType: ExerciseType;
  solutionFormGroup: FormGroup;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService,
    private exerciseCodeService: ExerciseSourceService,
    private exerciseTestService: ExerciseTestService,
    private exerciseConfigService: ExerciseConfigService,
    private exerciseTypeService: ExerciseTypeService,
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.getExercise();
  }

  getExercise() {
    const exercise$ = this.route.paramMap.pipe(
      switchMap(((params: ParamMap) =>
        this.exerciseService.getExerciseById(Number(params.get('exerciseId')))
      ))
    );
    exercise$.subscribe(
      data => {
        console.log(data);
        this.exercise = data;
        this.getExerciseType();
      },
      error => console.log(error)
    );
  }

  getExerciseType() {
    this.exerciseTypeService.getExerciseTypeById(this.exercise.typeId).subscribe(
      data => {
        console.log(data);
        this.exerciseType = data;
        this.getSourceCodes();
      },
      error => console.log(error)
    );
  }

  getSourceCodes() {
    this.exerciseCodeService.getExerciseSourcesByExerciseId(this.exercise.id)
      .subscribe(
        data => {
          this.exerciseSources = data;
          this.getSourceTests();
        },
        error => console.log(error)
      );
  }

  getSourceTests() {
    this.exerciseTestService.getExerciseTestsByExerciseId(this.exercise.id).subscribe(
      data => {
        this.exerciseTests = data;
        this.getSourceConfigs();
      }
    );
  }

  getSourceConfigs() {
    this.exerciseConfigService.getExerciseConfigsByExerciseId(this.exercise.id).subscribe(
      data => {
        console.log(data);
        this.exerciseConfigs = data;
        this.createForm();
      },
      error => console.log(error)
    );
  }


  createForm() {
    this.solutionFormGroup = this.fb.group({
    });
    this.setIntro();
    switch (this.exerciseType.value) {
      case 'source-test': {
        this.setSources();
        this.setTests();
        break;
      }
      case 'source-test-file': {
        this.setSources();
        this.setTests();
        this.setFiles();
        break;
      }
      case 'test': {
        this.setTests();
        break;
      }
      case 'test-file': {
        this.setTests();
        this.setFiles();
        break;
      }
      case 'single-quiz': {
        // TODO | single-quiz case
        break;
      }
      case 'multiple-quiz': {
        // TODO | multiple-quiz case
        break;
      }
      default: {
        console.log('defaut: exercise type was not found');
      }
    }
    console.log(this.solutionFormGroup);
  }

  setIntro() {
    this.solutionFormGroup.addControl(
      'intro', this.fb.group({
        exerciseName: [this.exercise.name],
        exerciseDescription: [this.exercise.description]
      })
    );
  }

  setSources() {
    this.solutionFormGroup.addControl(
      'exerciseSources', this.fb.array(this.exerciseSources)
    );
  }

  setTests() {
    this.solutionFormGroup.addControl(
      'exerciseTests', this.fb.array(this.exerciseTests)
    );
  }

  setFiles() {
    this.solutionFormGroup.addControl(
      'exerciseFiles', this.fb.array(this.exerciseConfigs)
    );
  }

}
