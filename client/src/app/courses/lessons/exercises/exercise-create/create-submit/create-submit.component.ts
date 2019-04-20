import { Component, OnInit, Input } from '@angular/core';
import { Observable, forkJoin } from 'rxjs';
import { FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Exercise } from '../../shared/exercise/exercise/exercise.model';
import { ExerciseService } from '../../shared/exercise/exercise/exercise.service';
import { PublicSource } from '../../shared/public/public-source/public-source.model';
import { PublicTest } from '../../shared/public/public-test/public-test.model';
import { PrivateSource } from '../../shared/exercise/private-source/private-source.model';
import { PrivateTest } from '../../shared/exercise/private-test/private-test.model';
import { PrivateFile } from '../../shared/exercise/private-file/private-file.model';
import { PrivateSourceService } from '../../shared/exercise/private-source/private-source.service';
import { PrivateTestService } from '../../shared/exercise/private-test/private-test.service';
import { PrivateFileService } from '../../shared/exercise/private-file/private-file.service';
import { PublicSourceService } from '../../shared/public/public-source/public-source.service';
import { PublicTestService } from '../../shared/public/public-test/public-test.service';
import { PublicFileService } from '../../shared/public/public-file/public-file.service';

@Component({
  selector: 'create-submit',
  templateUrl: './create-submit.component.html',
  styleUrls: ['./create-submit.component.scss']
})
export class CreateSubmitComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  private exercise: Exercise;
  // private error = '';

  constructor(
    private exerciseService: ExerciseService,
    private privateSourceService: PrivateSourceService,
    private privateTestService: PrivateTestService,
    private privateFileService: PrivateFileService,
    private publicSourceService: PublicSourceService,
    private publicTestService: PublicTestService,
    private publicFileService: PublicFileService,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
  }

  async submit() {
    this.resetErrorMessage();
    this.exercise = await this.saveExercise();
    await this.saveExerciseItems();
    if (this.exerciseFormGroup.get('error').get('errorMessage').value === '') {
      this.setSuccess();
    }
  }

  resetErrorMessage() {
    this.exerciseFormGroup.get('error').get('errorMessage').setValue('');
  }

  saveExercise(): Promise<Exercise> {
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
    exercise.name = this.exerciseFormGroup.get('intro').get('name').value;
    exercise.description = this.exerciseFormGroup.get('intro').get('description').value;
    exercise.typeId = this.exerciseFormGroup.get('intro').get('type').value['id'];
    exercise.index = Number(this.route.snapshot.params['index']);
    exercise.lessonId = Number(this.route.snapshot.params['lessonId']);
    return exercise;
  }

  async saveExerciseItems() {
    const exerciseTypeValue = this.exerciseFormGroup.get('intro').get('type').value['value'];
    switch (exerciseTypeValue) {
      case 'whitebox': {
        await this.savePublicSourcesByType();
        await this.savePrivateTests();
        await this.savePublicTestsByType();
        break;
      }
      case 'whitebox-file': {
        await this.savePublicSourcesByType();
        await this.savePrivateTests();
        await this.savePublicTestsByType();
        await this.savePrivateFiles();
        await this.savePublicFilesByType();
        break;
      }
      case 'blackbox': {
        await this.savePrivateSources().catch(error => this.handleError(error));
        await this.savePublicTestsByType();
        break;
      }
      case 'blackbox-file': {
        await this.savePrivateSources().catch(error => this.handleError(error));
        await this.savePublicTestsByType();
        await this.savePrivateFiles();
        await this.savePublicFilesByType();
        break;
      }
      default: {
        console.log('defaut: Solution type was not found');
      }
    }
  }

  savePrivateSources(): Promise<{}> {
    const sources: Array<PrivateSource> = this.exerciseFormGroup.get('sourceControl').get('privateControl').get('tabContent').value;
    const observables = [];
    sources.forEach(s => {
      observables.push(this.savePrivateSource(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  savePrivateSource(source: PrivateSource): Observable<{}> {
    source.exerciseId = this.exercise.id;
    return this.privateSourceService.createPrivateSource(source);
  }

  savePublicSourcesByType() {
    const shownSourcesType: string = this.exerciseFormGroup.get('sourceControl').get('publicType').get('chosen').value;
    if (shownSourcesType === 'same') {
      const shownSources: Array<PublicSource> = this.exerciseFormGroup.get('sourceControl').get('privateControl').get('tabContent').value;
      this.saveShownSources(shownSources);
    } else if (shownSourcesType === 'custom') {
      const shownSources: Array<PrivateSource> = this.exerciseFormGroup.get('sourceControl').get('publicControl').get('tabContent').value;
      this.saveShownSources(shownSources);
    }
  }

  saveShownSources(shownSources: Array<PublicSource>): Promise<{}> {
    const observables = [];
    shownSources.forEach(s => {
      observables.push(this.saveShownSource(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  saveShownSource(source: PrivateSource): Observable<{}> {
    source.exerciseId = this.exercise.id;
    return this.publicSourceService.createPublicSource(source);
  }


  savePrivateTests(): Promise<{}> {
    const exerciseTests: Array<PrivateTest> = this.exerciseFormGroup.get('testControl').get('privateControl').get('tabContent').value;
    const observables = [];
    exerciseTests.forEach(s => {
      observables.push(this.saveExerciseTest(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  saveExerciseTest(test: PrivateTest): Observable<{}> {
    test.exerciseId = this.exercise.id;
    return this.privateTestService.createPrivateTest(test);
  }

  savePublicTestsByType() {
    const shownTestsType: string = this.exerciseFormGroup.get('testControl').get('publicType').get('chosen').value;
    if (shownTestsType === 'same') {
      const shownTests: Array<PublicTest> = this.exerciseFormGroup.get('testControl').get('privateControl').get('tabContent').value;
      this.saveShownTests(shownTests);
    } else if (shownTestsType === 'custom') {
      const shownTests: Array<PublicTest> = this.exerciseFormGroup.get('testControl').get('publicControl').get('tabContent').value;
      this.saveShownTests(shownTests);
    }
  }

  saveShownTests(shownTests: Array<PublicTest>): Promise<{}> {
    const observables = [];
    shownTests.forEach(s => {
      observables.push(this.saveShownTest(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  saveShownTest(test: PublicTest): Observable<{}> {
    test.exerciseId = this.exercise.id;
    return this.publicTestService.createPublicTest(test);
  }

  savePrivateFiles(): Promise<{}> {
    const files: Array<PrivateTest> = this.exerciseFormGroup.get('fileControl').get('privateControl').get('tabContent').value;
    const observables = [];
    files.forEach(s => {
      observables.push(this.saveFile(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  saveFile(file: PrivateFile): Observable<{}> {
    file.exerciseId = this.exercise.id;
    return this.privateFileService.createPrivateFile(file);
  }

  savePublicFilesByType() {
    const shownFilesType: string = this.exerciseFormGroup.get('fileControl').get('publicType').get('chosen').value;
    if (shownFilesType === 'same') {
      const shownFiles: Array<PublicTest> = this.exerciseFormGroup.get('fileControl').get('privateControl').get('tabContent').value;
      this.saveShownFiles(shownFiles);
    } else if (shownFilesType === 'custom') {
      const shownFiles: Array<PublicTest> = this.exerciseFormGroup.get('fileControl').get('publicControl').get('tabContent').value;
      this.saveShownFiles(shownFiles);
    }
  }

  saveShownFiles(shownFiles: Array<PublicTest>): Promise<{}> {
    const observables = [];
    shownFiles.forEach(s => {
      observables.push(this.saveFile(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  saveShownFile(file: PrivateFile): Observable<{}> {
    file.exerciseId = this.exercise.id;
    return this.publicFileService.createPublicFile(file);
  }


  setSuccess() {
    this.exerciseFormGroup.get('params').get('success').setValue(true);
  }

  handleError(error) {
    console.log(error);
    this.exerciseFormGroup.get('error').get('errorMessage').setValue(error.message);
  }

}
