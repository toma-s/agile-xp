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
import { ExerciseFile } from '../shared/exercise-file/exercise-file.model';
import { ExerciseSourceService } from '../shared/exercise-source/exercise-source.service';
import { ExerciseTestService } from '../shared/exercise-test/exercise-test.service';
import { ExerciseFileService } from '../shared/exercise-file/exercise-file.service';

@Component({
  selector: 'exercise-solve',
  templateUrl: './exercise-solve.component.html',
  styleUrls: ['./exercise-solve.component.scss']
})
export class ExerciseSolveComponent implements OnInit {

  exercise: Exercise;
  exerciseSources: Array<ExerciseSource> = new Array<ExerciseSource>();
  exerciseTests: Array<ExerciseTest> = new Array<ExerciseTest>();
  exerciseFiles: Array<ExerciseFile> = new Array<ExerciseFile>();

  exerciseType: ExerciseType;
  solutionFormGroup: FormGroup;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService,
    private exerciseSourceService: ExerciseSourceService,
    private exerciseTestService: ExerciseTestService,
    private exerciseFileService: ExerciseFileService,
    private exerciseTypeService: ExerciseTypeService,
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.getExercise();
  }

  getExercise() {
    const exerciseId = Number(this.route.snapshot.params['exerciseId']);
    this.exerciseService.getExerciseById(exerciseId).subscribe(
      data => {
        this.exercise = data;
        this.getExerciseType();
      },
      error => console.log(error)
    );
  }

  getExerciseType() {
    this.exerciseTypeService.getExerciseTypeById(this.exercise.typeId).subscribe(
      data => {
        this.exerciseType = data;
        console.log(data);
        this.getSourceContent();
      },
      error => console.log(error)
    );
  }

  getSourceContent() {
    this.exerciseSourceService.getExerciseSourcesByExerciseId(this.exercise.id)
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
        this.getSourceFiles();
      }
    );
  }

  getSourceFiles() {
    this.exerciseFileService.getExerciseFilesByExerciseId(this.exercise.id).subscribe(
      data => {
        this.exerciseFiles = data;
        this.createForm();
      },
      error => console.log(error)
    );
  }


  createForm() {
    this.solutionFormGroup = this.fb.group({
    });
    this.setExerciseIntro();
    switch (this.exerciseType.value) {
      case 'whitebox': {
        this.setExerciseSources();
        this.setExerciseTests();
        break;
      }
      case 'whitebox-file': {
        this.setExerciseSources();
        this.setExerciseTests();
        this.setExerciseFiles();
        break;
      }
      case 'blackbox': {
        this.setExerciseTests();
        break;
      }
      case 'blackbox-file': {
        this.setExerciseTests();
        this.setExerciseFiles();
        break;
      }
      default: {
        console.log('defaut: exercise type was not found');
      }
    }
    console.log(this.solutionFormGroup);
  }

  setExerciseIntro() {
    this.solutionFormGroup.addControl(
      'intro', this.fb.group({
        exerciseId: [this.exercise.id],
        exerciseName: [this.exercise.name],
        exerciseDescription: [this.exercise.description],
        exerciseType: [this.exerciseType.value],
        exerciseLoadSolutionSources: [this.exercise.loadSolutionSources],
        exerciseLoadSolutionTests: [this.exercise.loadSolutionTests],
        exerciseLoadSolutionFiles: [this.exercise.loadSolutionFiles]
      })
    );
  }

  setExerciseSources() {
    this.solutionFormGroup.addControl(
      'exerciseSources', this.fb.array(this.getGroup(this.exerciseSources))
    );
  }

  setExerciseTests() {
    this.solutionFormGroup.addControl(
      'exerciseTests', this.fb.array(this.getGroup(this.exerciseTests))
    );
  }

  setExerciseFiles() {
    this.solutionFormGroup.addControl(
      'exerciseFiles', this.fb.array(this.getGroup(this.exerciseFiles))
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
