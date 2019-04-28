import { FormGroup } from '@angular/forms';
import { Injectable } from '@angular/core';
import { Exercise } from '../../shared/exercise/exercise/exercise.model';
import { ExerciseService } from '../../shared/exercise/exercise/exercise.service';
import { PrivateSourceService } from '../../shared/exercise/private-source/private-source.service';
import { PrivateTestService } from '../../shared/exercise/private-test/private-test.service';
import { PrivateFileService } from '../../shared/exercise/private-file/private-file.service';
import { PublicSourceService } from '../../shared/public/public-source/public-source.service';
import { PublicTestService } from '../../shared/public/public-test/public-test.service';
import { PublicFileService } from '../../shared/public/public-file/public-file.service';
import { PrivateSource } from '../../shared/exercise/private-source/private-source.model';
import { forkJoin } from 'rxjs';
import { PrivateTest } from '../../shared/exercise/private-test/private-test.model';
import { PublicTest } from '../../shared/public/public-test/public-test.model';
import { PrivateFile } from '../../shared/exercise/private-file/private-file.model';
import { ExerciseSaverService } from './exercise-saver.service';
import { PublicSource } from '../../shared/public/public-source/public-source.model';
import { PublicFile } from '../../shared/public/public-file/public-file.model';

@Injectable({
  providedIn: 'root'
})
export class ExerciseUpdaterService extends ExerciseSaverService {

  protected form: FormGroup;
  protected exercise: Exercise;

  constructor(
    protected exerciseService: ExerciseService,
    protected privateSourceService: PrivateSourceService,
    protected privateTestService: PrivateTestService,
    protected privateFileService: PrivateFileService,
    protected publicSourceService: PublicSourceService,
    protected publicTestService: PublicTestService,
    protected publicFileService: PublicFileService
  ) {
    super(exerciseService, privateSourceService, privateTestService, privateFileService,
      publicSourceService, publicTestService, publicFileService);
  }

  protected saveExercise(): Promise<Exercise> {
    const exercise = this.createExercise();

    return new Promise((resolve, reject) => {
      this.exerciseService.updateExercise(exercise.id, exercise).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  createExercise(): Exercise {
    const exercise = new Exercise();
    const exerciseData = this.form.get('intro').get('exercise');
    exercise.id = exerciseData.get('id').value;
    exercise.name = exerciseData.get('name').value;
    exercise.description = exerciseData.get('description').value;
    exercise.typeId = exerciseData.get('type').value['id'];
    exercise.index = exerciseData.get('index').value;
    exercise.lessonId = exerciseData.get('lessonId').value;
    exercise.solved = this.toBoolean(exerciseData.get('name').value);
    exercise.created = new Date(exerciseData.get('created').value);
    return exercise;
  }

  toBoolean(string: string) {
    return string === 'true';
  }


  protected savePrivateSources(): Promise<{}> {
    const sources: Array<PrivateSource> = this.form.get('sourceControl').get('privateControl').get('tabContent').value;
    const observables = [];
    observables.push(this.deletePrivateSources());
    sources.forEach(s => {
      observables.push(this.createPrivateSource(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  deletePrivateSources() {
    return this.privateSourceService.deletePrivateSourcesByExerciseId(this.exercise.id);
  }


  protected savePublicSources(): Promise<{}> {
    const sources: Array<PublicSource> = this.form.get('sourceControl').get('publicControl').get('tabContent').value;
    const observables = [];
    observables.push(this.deletePublicSources());
    sources.forEach(s => {
      observables.push(this.createPublicSource(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  deletePublicSources() {
    return this.publicSourceService.deletePublicSourcesByExerciseId(this.exercise.id);
  }


  protected savePrivateTests(): Promise<{}> {
    const tests: Array<PrivateTest> = this.form.get('testControl').get('privateControl').get('tabContent').value;
    const observables = [];
    observables.push(this.deletePrivateTests());
    tests.forEach(s => {
      observables.push(this.createPrivateTest(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  deletePrivateTests() {
    return this.privateTestService.deletePrivateTestsByExerciseId(this.exercise.id);
  }


  protected savePublicTests(publicTests: Array<PublicTest>): Promise<{}> {
    const observables = [];
    observables.push(this.deletePublicTests());
    publicTests.forEach(s => {
      observables.push(this.createPublicTest(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  deletePublicTests() {
    return this.publicTestService.deletePublicTestsByExerciseId(this.exercise.id);
  }


  protected savePrivateFiles(): Promise<{}> {
    const files: Array<PrivateFile> = this.form.get('fileControl').get('privateControl').get('tabContent').value;
    const observables = [];
    observables.push(this.deletePrivateFiles());
    files.forEach(s => {
      observables.push(this.createPrivateFile(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  deletePrivateFiles() {
    return this.privateFileService.deletePrivateFilesByExerciseId(this.exercise.id);
  }


  protected savePublicFiles(publicFiles: Array<PublicFile>): Promise<{}> {
    const observables = [];
    observables.push(this.deletePublicFiles());
    publicFiles.forEach(s => {
      observables.push(this.createPublicFile(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  deletePublicFiles() {
    return this.publicFileService.deletePublicFilesByExerciseId(this.exercise.id);
  }

}
