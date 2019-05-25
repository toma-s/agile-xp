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
import { PublicFile } from '../../shared/public/public-file/public-file.model';
import { PublicSource } from '../../shared/public/public-source/public-source.model';
import { BugsNumberService } from '../../shared/exercise/bugs-number/bugs-number.service';

@Injectable({
  providedIn: 'root'
})
export class ExerciseCreatorService extends ExerciseSaverService {

  protected form: FormGroup;
  protected exercise: Exercise;

  constructor(
    protected exerciseService: ExerciseService,
    protected bugsNumberService: BugsNumberService,
    protected privateSourceService: PrivateSourceService,
    protected privateTestService: PrivateTestService,
    protected privateFileService: PrivateFileService,
    protected publicSourceService: PublicSourceService,
    protected publicTestService: PublicTestService,
    protected publicFileService: PublicFileService
  ) {
    super(exerciseService, bugsNumberService, privateSourceService, privateTestService, privateFileService,
      publicSourceService, publicTestService, publicFileService);
  }

  protected saveExercise(): Promise<Exercise> {
    const exercise = this.createExercise();

    return new Promise((resolve, reject) => {
      this.exerciseService.createExercise(exercise).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  createExercise(): Exercise {
    const exercise = new Exercise();
    exercise.name = this.form.get('intro').get('exercise').get('name').value;
    exercise.description = this.form.get('intro').get('exercise').get('description').value;
    exercise.typeId = this.form.get('intro').get('exercise').get('type').value['id'];
    exercise.index = this.form.get('intro').get('exercise').get('index').value;
    exercise.lessonId = this.form.get('intro').get('exercise').get('lessonId').value;
    return exercise;
  }


  protected savePrivateSources(): Promise<{}> {
    const sources: Array<PrivateSource> = this.form.get('sourceControl').get('privateControl').get('tabContent').value;
    const observables = [];
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


  protected savePublicSources() {
    const shownSources: Array<PublicSource> = this.form.get('sourceControl').get('publicControl').get('tabContent').value;
    const observables = [];
    shownSources.forEach(s => {
      observables.push(this.createPublicSource(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  protected savePrivateTests(): Promise<{}> {
    const exerciseTests: Array<PrivateTest> = this.form.get('testControl').get('privateControl').get('tabContent').value;
    const observables = [];
    exerciseTests.forEach(s => {
      observables.push(this.createPrivateTest(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  protected savePublicTests(publicTests: Array<PublicTest>): Promise<{}> {
    const observables = [];
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


  protected savePrivateFiles(): Promise<{}> {
    const files: Array<PrivateFile> = this.form.get('fileControl').get('privateControl').get('tabContent').value;
    const observables = [];
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


  protected savePublicFiles(publicFiles: Array<PublicFile>): Promise<{}> {
    const observables = [];
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

}
