import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';
import { ExerciseService } from '../../shared/exercise/exercise/exercise.service';
import { PublicSourceService } from '../../shared/public/public-source/public-source.service';
import { PublicTestService } from '../../shared/public/public-test/public-test.service';
import { PublicFileService } from '../../shared/public/public-file/public-file.service';
import { ExerciseTypeService } from '../../shared/exercise/exercise-type/exercise-type.service';
import { FormBuilder, Validators, FormArray, FormGroup } from '@angular/forms';
import { ExerciseUpsertComponent } from '../exercise-upsert.component';
import { Exercise } from '../../shared/exercise/exercise/exercise.model';
import { ExerciseType } from '../../shared/exercise/exercise-type/exercise-type.model';
import { SolutionSource } from '../../shared/solution/solution-source/solution-source.model';
import { SolutionTest } from '../../shared/solution/solution-test/solution-test.model';
import { SolutionFile } from '../../shared/solution/solution-file/solution-file.model';
import { PrivateSource } from '../../shared/exercise/private-source/private-source.model';
import { PrivateSourceService } from '../../shared/exercise/private-source/private-source.service';
import { PrivateTestService } from '../../shared/exercise/private-test/private-test.service';
import { PrivateFileService } from '../../shared/exercise/private-file/private-file.service';
import { PrivateTest } from '../../shared/exercise/private-test/private-test.model';
import { PrivateFile } from '../../shared/exercise/private-file/private-file.model';
import { PublicSource } from '../../shared/public/public-source/public-source.model';
import { PublicTest } from '../../shared/public/public-test/public-test.model';
import { PublicFile } from '../../shared/public/public-file/public-file.model';

@Component({
  selector: 'exercise-edit',
  templateUrl: '../exercise-upsert.component.html',
  styleUrls: ['../exercise-upsert.component.scss']
})
export class ExerciseEditComponent extends ExerciseUpsertComponent {

  protected mode = 'edit';

  private exercise: Exercise;
  private exerciseType: ExerciseType;
  private privateSources: Array<PrivateSource>;
  private privateTests: Array<PrivateTest>;
  private privateFiles: Array<PrivateFile>;
  private publicSources: Array<PublicSource>;
  private publicTests: Array<PublicTest>;
  private publicFiles: Array<PublicFile>;

  constructor(
    protected titleService: Title,
    protected fb: FormBuilder,
    private route: ActivatedRoute,
    private exerciseService: ExerciseService,
    private exerciseTypeService: ExerciseTypeService,
    private privateSourceService: PrivateSourceService,
    private privateTestService: PrivateTestService,
    private privateFileService: PrivateFileService,
    private publicSourceService: PublicSourceService,
    private publicTestService: PublicTestService,
    private publicFileService: PublicFileService
  ) {
    super(titleService, fb);
  }

  setTitle() {
    this.titleService.setTitle(`Edit exercise | AgileXP`);
  }

  async getIntroGroup() {
    this.exercise = await this.getExercise();
    this.exerciseType = await this.getExerciseType();
    this.privateSources = await this.getPrivateSources();
    this.privateTests = await this.getPrivateTests();
    this.privateFiles = await this.getPrivateFiles();
    this.publicSources = await this.getPublicSources();
    this.publicTests = await this.getPublicTests();
    this.publicFiles = await this.getPublicFiles();
    return this.fb.group({
      name: [this.exercise.name, Validators.compose([Validators.required])],
      description: [this.exercise.description, Validators.compose([Validators.required])],
      type: [this.exerciseType.value, Validators.compose([Validators.required])],
      mode: 'edit'
    });
  }

  getExercise(): Promise<Exercise> {
    const exerciseId = this.route.snapshot.params['exerciseId'];
    return new Promise<Exercise>((resolve, reject) => {
      this.exerciseService.getExerciseById(exerciseId).subscribe(
        data => resolve(data),
        error => reject (error)
      );
    });
  }

  getExerciseType(): Promise<ExerciseType> {
    return new Promise<ExerciseType>((resolve, reject) => {
      this.exerciseTypeService.getExerciseTypeById(this.exercise.typeId).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  getPrivateSources(): Promise<Array<PrivateSource>> {
    return new Promise<Array<PrivateSource>>((resolve, reject) => {
      this.privateSourceService.getPrivateSourcesByExerciseId(this.exercise.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  getPrivateTests(): Promise<Array<PrivateTest>> {
    return new Promise<Array<PrivateTest>>((resolve, reject) => {
      this.privateTestService.getPrivateTestsByExerciseId(this.exercise.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  getPrivateFiles(): Promise<Array<PrivateFile>> {
    return new Promise<Array<PrivateFile>>((resolve, reject) => {
      this.privateFileService.getPrivateFilesByExerciseId(this.exercise.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  getPublicSources(): Promise<Array<PublicSource>> {
    return new Promise<Array<PublicSource>>((resolve, reject) => {
      this.publicSourceService.getPublicSourcesByExerciseId(this.exercise.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  getPublicTests(): Promise<Array<PublicTest>> {
    return new Promise<Array<PublicTest>>((resolve, reject) => {
      this.publicTestService.getPublicTestsByExerciseId(this.exercise.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  getPublicFiles(): Promise<Array<PublicFile>> {
    return new Promise<Array<PublicFile>>((resolve, reject) => {
      this.publicFileService.getPublicFilesByExerciseId(this.exercise.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  getExerciseGroup(exerciseType: string) {
    return this.fb.group({
      exerciseType: [exerciseType],
      privateControl: this.fb.group({
        tabContent: this.fb.array(this.getGroup(this.getPrivate(exerciseType))),
      }),
      publicType: this.fb.group({
        chosen: ['same', Validators.compose([Validators.required])]
      }),
      publicControl: this.fb.group({
        tabContent: this.fb.array(this.getGroup(this.getPublic(exerciseType))),
      })
    });
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

  create(validators): FormGroup {
    return this.fb.group({
      filename: ['filename.java'],
      content: ['', validators]
    });
  }

  getPrivate(exerciseType: string) {
    if (exerciseType === 'sources') {
      return this.privateSources;
    } else if (exerciseType === 'tests') {
      return this.privateTests;
    } else if (exerciseType === 'files') {
      return this.privateFiles;
    }
  }

  getPublic(exerciseType: string) {
    if (exerciseType === 'sources') {
      return this.publicSources;
    } else if (exerciseType === 'tests') {
      return this.publicTests;
    } else if (exerciseType === 'files') {
      return this.publicFiles;
    }
  }


  setupValidatorsOnInit() {
    const typeValue = this.exerciseFormGroup.get('intro').get('type').value;
    this.setupValidatorsByType(typeValue);
  }

}
