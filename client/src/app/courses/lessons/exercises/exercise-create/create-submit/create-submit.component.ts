import { Component, OnInit, Input } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { Exercise } from '../../shared/exercise/exercise/exercise.model';
import { ExerciseService } from '../../shared/exercise/exercise/exercise.service';
import { forkJoin, Observable } from 'rxjs';
import { ExerciseSource } from '../../shared/exercise/exercise-source/exercise-source.model';
import { ExerciseSourceService } from '../../shared/exercise/exercise-source/exercise-source.service';
import { ExerciseTestService } from '../../shared/exercise/exercise-test/exercise-test.service';
import { ExerciseFileService } from '../../shared/exercise/exercise-file/exercise-file.service';
import { ExerciseTest } from '../../shared/exercise/exercise-test/exercise-test.model';
import { ExerciseFile } from '../../shared/exercise/exercise-file/exercise-file.model';
import { ActivatedRoute } from '@angular/router';
import { PublicTest } from '../../shared/public/public-test/public-test.model';
import { PublicTestService } from '../../shared/public/public-test/public-test.service';
import { PublicSourceService } from '../../shared/public/public-source/public-source.service';
import { PublicSource } from '../../shared/public/public-source/public-source.model';
import { PublicFileService } from '../../shared/public/public-file/public-file.service';

@Component({
  selector: 'create-submit',
  templateUrl: './create-submit.component.html',
  styleUrls: ['./create-submit.component.scss']
})
export class CreateSubmitComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  private exercise: Exercise;

  constructor(
    private exerciseService: ExerciseService,
    private exerciseSourceService: ExerciseSourceService,
    private exerciseTestService: ExerciseTestService,
    private exerciseFileService: ExerciseFileService,
    private publicSourceService: PublicSourceService,
    private publicTestService: PublicTestService,
    private publicFileService: PublicFileService,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
  }

  async submit() {
    this.exercise = await this.saveExercise();
    await this.saveExerciseItems();
    this.setSuccess();
  }

  saveExercise(): Promise<Exercise> {
    const exercise = this.createExercise();

    return new Promise((resolve, reject) => {
      this.exerciseService.createExercise(exercise).subscribe(
        data => {
          console.log(data);
          resolve(data);
        },
        error => {
          console.log(error);
          reject(error);
        }
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
    console.log(exercise);
    return exercise;
  }

  async saveExerciseItems() {
    const exerciseTypeValue = this.exerciseFormGroup.get('intro').get('type').value['value'];
    switch (exerciseTypeValue) {
      case 'whitebox': {
        await this.savePrivateSources();
        await this.savePublicSourcesByType();
        await this.savePrivateTests();
        await this.savePublicTestsByType();
        break;
      }
      case 'whitebox-file': {
        await this.savePrivateSources();
        await this.savePublicSourcesByType();
        await this.savePrivateTests();
        await this.savePublicTestsByType();
        await this.savePrivateFiles();
        await this.savePublicFilesByType();
        break;
      }
      case 'blackbox': {
        await this.savePrivateSources();
        await this.savePublicTestsByType();
        break;
      }
      case 'blackbox-file': {
        await this.savePrivateSources();
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
    const sources: Array<ExerciseSource> = this.exerciseFormGroup.get('sourceControl').get('privateControl').get('tabContent').value;
    const observables = [];
    sources.forEach(s => {
      observables.push(this.savePrivateSource(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => {
          resolve(data);
          console.log(data);
        },
        error => reject(error)
      );
    });
  }

  savePrivateSource(source: ExerciseSource): Observable<{}> {
    source.exerciseId = this.exercise.id;
    console.log(source);
    return this.exerciseSourceService.createExerciseSource(source);
  }

  savePublicSourcesByType() {
    const shownSourcesType: string = this.exerciseFormGroup.get('sourceControl').get('publicType').get('chosen').value;
    console.log(shownSourcesType);
    if (shownSourcesType === 'same') {
      console.log('same run');
      const shownSources: Array<PublicSource> = this.exerciseFormGroup.get('sourceControl').get('privateControl').get('tabContent').value;
      this.saveShownSources(shownSources);
    } else if (shownSourcesType === 'custom') {
      const shownSources: Array<ExerciseSource> = this.exerciseFormGroup.get('sourceControl').get('publicControl').get('tabContent').value;
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
        data => {
          resolve(data);
          console.log(data);
        },
        error => reject(error)
      );
    });
  }

  saveShownSource(source: ExerciseSource): Observable<{}> {
    source.exerciseId = this.exercise.id;
    console.log(source);
    return this.publicSourceService.createPublicSource(source);
  }


  savePrivateTests(): Promise<{}> {
    const exerciseTests: Array<ExerciseTest> = this.exerciseFormGroup.get('testControl').get('privateControl').get('tabContent').value;
    const observables = [];
    exerciseTests.forEach(s => {
      observables.push(this.saveExerciseTest(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => {
          resolve(data);
          console.log(data);
        },
        error => reject(error)
      );
    });
  }

  saveExerciseTest(test: ExerciseTest): Observable<{}> {
    test.exerciseId = this.exercise.id;
    console.log(test);
    return this.exerciseTestService.createExerciseTest(test);
  }

  savePublicTestsByType() {
    const shownTestsType: string = this.exerciseFormGroup.get('testControl').get('publicType').get('chosen').value;
    console.log(shownTestsType);
    if (shownTestsType === 'same') {
      const shownTests: Array<PublicTest> = this.exerciseFormGroup.get('testControl').get('privateControl').get('tabContent').value;
      console.log('same run');
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
        data => {
          resolve(data);
          console.log(data);
        },
        error => reject(error)
      );
    });
  }

  saveShownTest(test: PublicTest): Observable<{}> {
    test.exerciseId = this.exercise.id;
    console.log(test);
    return this.publicTestService.createPublicTest(test);
  }

  savePrivateFiles(): Promise<{}> {
    const files: Array<ExerciseTest> = this.exerciseFormGroup.get('fileControl').get('privateControl').get('tabContent').value;
    const observables = [];
    files.forEach(s => {
      observables.push(this.saveFile(s));
    });
    return new Promise((resolve, reject) => {
      forkJoin(observables).subscribe(
        data => {
          resolve(data);
          console.log(data);
        },
        error => reject(error)
      );
    });
  }

  saveFile(file: ExerciseFile): Observable<{}> {
    file.exerciseId = this.exercise.id;
    console.log(file);
    return this.exerciseFileService.createExerciseFile(file);
  }

  savePublicFilesByType() {
    const shownFilesType: string = this.exerciseFormGroup.get('fileControl').get('publicType').get('chosen').value;
    console.log(shownFilesType);
    if (shownFilesType === 'same') {
      const shownFiles: Array<PublicTest> = this.exerciseFormGroup.get('fileControl').get('publicControl').get('tabContent').value;
      console.log('same run');
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
        data => {
          resolve(data);
          console.log(data);
        },
        error => reject(error)
      );
    });
  }

  saveShownFile(file: ExerciseFile): Observable<{}> {
    file.exerciseId = this.exercise.id;
    console.log(file);
    return this.publicFileService.createPublicFile(file);
  }


  setSuccess() {
    this.exerciseFormGroup.get('params').get('success').setValue(true);
  }

}
