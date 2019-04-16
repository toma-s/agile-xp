import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ExerciseService } from '../shared/exercise/exercise.service';
import { Exercise } from '../shared/exercise/exercise.model';
import { ExerciseTypeService } from '../shared/exercise-type/exercise-type.service';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ExerciseType } from '../shared/exercise-type/exercise-type.model';
import { ExerciseSource } from '../shared/exercise-source/exercise-source.model';
import { ExerciseTest } from '../shared/exercise-test/exercise-test.model';
import { ExerciseFile } from '../shared/exercise-file/exercise-file.model';
import { PublicSourceService } from '../shared/public-source/public-source.service';
import { PublicTestService } from '../shared/public-test/public-test.service';
import { PublicFileService } from '../shared/public-file/public-file.service';

@Component({
  selector: 'exercise-solve',
  templateUrl: './exercise-solve.component.html',
  styleUrls: ['./exercise-solve.component.scss']
})
export class ExerciseSolveComponent implements OnInit {

  exercise: Exercise;
  solutionSources: Array<ExerciseSource> = new Array<ExerciseSource>();
  solutionTests: Array<ExerciseTest> = new Array<ExerciseTest>();
  solutionFiles: Array<ExerciseFile> = new Array<ExerciseFile>();

  exerciseType: ExerciseType;
  solutionFormGroup: FormGroup;

  constructor(
    private route: ActivatedRoute,
    private exerciseService: ExerciseService,
    private publicSourceService: PublicSourceService,
    private publicTestService: PublicTestService,
    private publicFileService: PublicFileService,
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
        this.getSolutionSources();
      },
      error => console.log(error)
    );
  }

  getSolutionSources() {
    this.publicSourceService.getPublicSourcesByExerciseId(this.exercise.id).subscribe(
      data => {
        this.solutionSources = data;
        this.getSolutionTests();
      },
      error => console.log(error)
    );
  }

  getSolutionTests() {
    this.publicTestService.getPublicTestsByExerciseId(this.exercise.id).subscribe(
      data => {
        this.solutionTests = data;
        this.getSolutionFiles();
      }
    );
  }

  getSolutionFiles() {
    this.publicFileService.getPublicFilesByExerciseId(this.exercise.id).subscribe(
      data => {
        this.solutionFiles = data;
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
        this.setSolutionControl('source', this.solutionSources);
        this.setSolutionControl('test', this.solutionTests);
        break;
      }
      case 'whitebox-file': {
        this.setSolutionControl('source', this.solutionSources);
        this.setSolutionControl('test', this.solutionTests);
        this.setSolutionControl('file', this.solutionFiles);
        break;
      }
      case 'blackbox': {
        this.setSolutionControl('test', this.solutionTests);
        break;
      }
      case 'blackbox-file': {
        this.setSolutionControl('test', this.solutionTests);
        this.setSolutionControl('file', this.solutionFiles);
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
        exerciseType: [this.exerciseType.value]
      })
    );
  }

  setSolutionControl(solutionType: string, intialSolution) {
    this.solutionFormGroup.addControl(
      `${solutionType}Control`, this.fb.group({
        solutionType: solutionType,
        solutionControl: this.fb.array(this.getGroup(intialSolution))
      })
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
