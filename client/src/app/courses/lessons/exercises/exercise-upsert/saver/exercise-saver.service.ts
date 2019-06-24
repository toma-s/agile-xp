import { ExerciseService } from '../../shared/exercise/exercise/exercise.service';
import { PrivateSourceService } from '../../shared/exercise/private-source/private-source.service';
import { PrivateTestService } from '../../shared/exercise/private-test/private-test.service';
import { PrivateFileService } from '../../shared/exercise/private-file/private-file.service';
import { PublicSourceService } from '../../shared/public/public-source/public-source.service';
import { PublicTestService } from '../../shared/public/public-test/public-test.service';
import { PublicFileService } from '../../shared/public/public-file/public-file.service';
import { Injectable } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { Exercise } from '../../shared/exercise/exercise/exercise.model';
import { PublicTest } from '../../shared/public/public-test/public-test.model';
import { PrivateSource } from '../../shared/exercise/private-source/private-source.model';
import { Observable } from 'rxjs';
import { PublicSource } from '../../shared/public/public-source/public-source.model';
import { PrivateTest } from '../../shared/exercise/private-test/private-test.model';
import { PrivateFile } from '../../shared/exercise/private-file/private-file.model';
import { PublicFile } from '../../shared/public/public-file/public-file.model';
import { BugsNumberService } from '../../shared/exercise/bugs-number/bugs-number.service';
import { BugsNumber } from '../../shared/exercise/bugs-number/bugs-number.model';

@Injectable({
  providedIn: 'root'
})
export abstract class ExerciseSaverService {

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
  }

  async save(form: FormGroup) {
    const result = {success: true};

    this.form = form;

    await this.saveExercise()
      .then(data => this.exercise = data)
      .catch(error => {
        result.success = false;
      });
    if (!result.success) {
      return result;
    }

    await this.saveExerciseItems()
      .catch(error => {
        result.success = false;
      });
    return result;
  }

  protected abstract async saveExercise(): Promise<Exercise>;

  async saveExerciseItems() {
    const exerciseTypeValue = this.form.get('intro').get('exercise').get('type').value['value'];
    switch (exerciseTypeValue) {
      case 'whitebox': {
        await this.savePublicSources().then().catch(error => Promise.reject(error));
        await this.savePrivateTests().then().catch(error => Promise.reject(error));
        await this.savePublicTestsByType().then().catch(error => Promise.reject(error));
        break;
      }
      case 'whitebox-file': {
        await this.savePublicSources().then().catch(error => Promise.reject(error));
        await this.savePrivateTests().then().catch(error => Promise.reject(error));
        await this.savePublicTestsByType().then().catch(error => Promise.reject(error));
        await this.savePrivateFiles().then().catch(error => Promise.reject(error));
        await this.savePublicFilesByType().then().catch(error => Promise.reject(error));
        break;
      }
      case 'blackbox': {
        await this.saveBugsNumber().then().catch(error => Promise.reject(error));
        await this.savePrivateSources().then().catch(error => Promise.reject(error));
        const publicTests: Array<PublicTest> = this.form.get('testControl').get('publicControl').get('tabContent').value;
        await this.savePublicTests(publicTests).then().catch(error => Promise.reject(error));
        break;
      }
      case 'blackbox-file': {
        await this.saveBugsNumber().then().catch(error => Promise.reject(error));
        await this.savePrivateSources().then().catch(error => Promise.reject(error));
        const publicTests: Array<PublicTest> = this.form.get('testControl').get('publicControl').get('tabContent').value;
        await this.savePublicTests(publicTests).then().catch(error => Promise.reject(error));
        await this.savePrivateFiles().then().catch(error => Promise.reject(error));
        await this.savePublicFilesByType().then().catch(error => Promise.reject(error));
        break;
      }
      default: {
        console.log('defaut: Solution type was not found');
      }
    }
  }

  saveBugsNumber(): Promise<{}> {
    const bugsNumber = this.form.get('intro').get('bugsNumber').value;
    return new Promise((resolve, reject) => {
      this.bugsNumberService.saveBugsNumber(this.exercise.id, bugsNumber).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  protected abstract savePrivateSources(): Promise<{}>;

  createPrivateSource(source: PrivateSource): Observable<{}> {
    source.exerciseId = this.exercise.id;
    return this.privateSourceService.createPrivateSource(source);
  }

  protected abstract savePublicSources(): Promise<{}>;

  createPublicSource(source: PublicSource): Observable<{}> {
    source.exerciseId = this.exercise.id;
    return this.publicSourceService.createPublicSource(source);
  }

  protected abstract savePrivateTests(): Promise<{}>;

  createPrivateTest(test: PrivateTest): Observable<{}> {
    test.exerciseId = this.exercise.id;
    return this.privateTestService.createPrivateTest(test);
  }

  async savePublicTestsByType(): Promise<{}> {
    return new Promise(async (resolve, reject) => {
      const publicTestsType: string = this.form.get('testControl').get('publicType').get('chosen').value;
      if (publicTestsType === 'same') {
        const privateTests: Array<PublicTest> = this.form.get('testControl').get('privateControl').get('tabContent').value;
        await this.savePublicTests(privateTests).then().catch(error => reject(error));
      } else if (publicTestsType === 'custom') {
        const publicTests: Array<PublicTest> = this.form.get('testControl').get('publicControl').get('tabContent').value;
        await this.savePublicTests(publicTests).then().catch(error => reject(error));
      }
      resolve();
    });
  }

  protected abstract savePublicTests(publicTests: Array<PublicTest>): Promise<{}>;

  createPublicTest(test: PublicTest): Observable<{}> {
    test.exerciseId = this.exercise.id;
    return this.publicTestService.createPublicTest(test);
  }


  protected abstract savePrivateFiles(): Promise<{}>;

  createPrivateFile(file: PrivateFile): Observable<{}> {
    file.exerciseId = this.exercise.id;
    return this.privateFileService.createPrivateFile(file);
  }

  async savePublicFilesByType(): Promise<{}> {
    return new Promise(async (resolve, reject) => {
      const shownFilesType: string = this.form.get('fileControl').get('publicType').get('chosen').value;
      if (shownFilesType === 'same') {
        const publicFiles: Array<PublicTest> = this.form.get('fileControl').get('privateControl').get('tabContent').value;
        this.savePublicFiles(publicFiles).catch(error => reject(error));
      } else if (shownFilesType === 'custom') {
        const publicFiles: Array<PublicTest> = this.form.get('fileControl').get('publicControl').get('tabContent').value;
        this.savePublicFiles(publicFiles).catch(error => reject(error));
      }
      resolve();
    });
  }

  protected abstract savePublicFiles(publicFiles: Array<PublicFile>): Promise<{}>;

  createPublicFile(file: PublicFile): Observable<{}> {
    file.exerciseId = this.exercise.id;
    return this.publicFileService.createPublicFile(file);
  }

}
