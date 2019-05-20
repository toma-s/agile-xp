import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ExerciseService } from '../shared/exercise/exercise/exercise.service';
import { Exercise } from '../shared/exercise/exercise/exercise.model';
import { ExerciseTypeService } from '../shared/exercise/exercise-type/exercise-type.service';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ExerciseType } from '../shared/exercise/exercise-type/exercise-type.model';
import { PublicSourceService } from '../shared/public/public-source/public-source.service';
import { PublicTestService } from '../shared/public/public-test/public-test.service';
import { PublicFileService } from '../shared/public/public-file/public-file.service';
import { SolutionSource } from '../shared/solution/solution-source/solution-source.model';
import { SolutionTest } from '../shared/solution/solution-test/solution-test.model';
import { SolutionFile } from '../shared/solution/solution-file/solution-file.model';
import { Title } from '@angular/platform-browser';

@Component({
  selector: 'exercise-solve',
  templateUrl: './exercise-solve.component.html',
  styleUrls: ['./exercise-solve.component.scss']
})
export class ExerciseSolveComponent implements OnInit {

  exercise: Exercise;
  exerciseType: ExerciseType;
  solutionFormGroup: FormGroup;
  solutionSources: Array<SolutionSource> = new Array<SolutionSource>();
  solutionTests: Array<SolutionTest> = new Array<SolutionTest>();
  solutionFiles: Array<SolutionFile> = new Array<SolutionFile>();

  constructor(
    private titleService: Title,
    private route: ActivatedRoute,
    private exerciseService: ExerciseService,
    private publicSourceService: PublicSourceService,
    private publicTestService: PublicTestService,
    private publicFileService: PublicFileService,
    private exerciseTypeService: ExerciseTypeService,
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.route.params.subscribe(() => this.reload());
  }

  async reload() {
    this.resetFormGroup();
    this.exercise = await this.getExercise();
    this.setTitle();
    this.exerciseType = await this.getExerciseType();
    await this.getSolutionItems();
    this.createForm();
  }

  resetFormGroup() {
    this.solutionFormGroup = null;
  }

  getExercise(): Promise<Exercise> {
    return new Promise<Exercise>((resolve, reject) => {
      this.route.params.subscribe(params =>
        this.exerciseService.getExerciseById(params['exerciseId']).subscribe(
          data => resolve(data),
          error => reject(error)
        )
      );
    });
  }

  setTitle() {
    this.titleService.setTitle(`${this.exercise.name} | AgileXP`);
  }

  getExerciseType(): Promise<ExerciseType> {
    return new Promise<ExerciseType>((resolve, reject) => {
      this.exerciseTypeService.getExerciseTypeById(this.exercise.typeId).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  async getSolutionItems() {
    switch (this.exerciseType.value) {
      case 'theory': {
        break;
      }
      case 'whitebox': {
        this.solutionSources = await this.getSolutionSources();
        this.solutionTests = await this.getSolutionTests();
        break;
      }
      case 'whitebox-file': {
        this.solutionSources = await this.getSolutionSources();
        this.solutionTests = await this.getSolutionTests();
        this.solutionFiles = await this.getSolutionFiles();
        break;
      }
      case 'blackbox': {
        this.solutionTests = await this.getSolutionTests();
        break;
      }
      case 'blackbox-file': {
        this.solutionTests = await this.getSolutionTests();
        this.solutionFiles = await this.getSolutionFiles();
        break;
      }
      default: {
        console.log('defaut: exercise type was not found');
      }
    }
  }

  getSolutionSources(): Promise<Array<SolutionSource>> {
    return new Promise<Array<SolutionSource>>((resolve, reject) => {
      this.publicSourceService.getPublicSourcesByExerciseId(this.exercise.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  getSolutionTests(): Promise<Array<SolutionTest>> {
    return new Promise<Array<SolutionTest>>((resolve, reject) => {
      this.publicTestService.getPublicTestsByExerciseId(this.exercise.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  getSolutionFiles(): Promise<Array<SolutionFile>> {
    return new Promise<Array<SolutionFile>>((resolve, reject) => {
      this.publicFileService.getPublicFilesByExerciseId(this.exercise.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  createForm() {
    this.solutionFormGroup = this.fb.group({});
    this.setExerciseIntro();
    this.setSolutionControl('source', this.solutionSources);
    this.setSolutionControl('test', this.solutionTests);
    this.setSolutionControl('file', this.solutionFiles);
  }

  setExerciseIntro() {
    this.solutionFormGroup.addControl(
      'intro', this.fb.group({
        exerciseId: [this.exercise.id],
        exerciseIndex: [this.exercise.index],
        exerciseName: [this.exercise.name],
        exerciseDescription: [this.exercise.description],
        exerciseType: [this.exerciseType.value],
        solved: [false],
        value: ['0%']
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
