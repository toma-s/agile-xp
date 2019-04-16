import { Component, OnInit, Input } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { Exercise } from '../../shared/exercise/exercise.model';
import { ExerciseService } from '../../shared/exercise/exercise.service';
import { forkJoin, Observable } from 'rxjs';
import { ExerciseSource } from '../../shared/exercise-source/exercise-source.model';
import { ExerciseSourceService } from '../../shared/exercise-source/exercise-source.service';
import { ExerciseTestService } from '../../shared/exercise-test/exercise-test.service';
import { ExerciseFileService } from '../../shared/exercise-file/exercise-file.service';
import { ExerciseTest } from '../../shared/exercise-test/exercise-test.model';
import { ExerciseFile } from '../../shared/exercise-file/exercise-file.model';
import { ActivatedRoute } from '@angular/router';
import { ShownTest } from '../../shared/shown-test/shown-test.model';
import { ShownTestService } from '../../shared/shown-test/shown-test.service';
import { ShownSourceService } from '../../shared/shown-source/shown-source.service';
import { ShownSource } from '../../shared/shown-source/shown-source.model';

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
    private shownSourceService: ShownSourceService,
    private shownTestService: ShownTestService,
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
      case 'source-test': {
        await this.saveExerciseSources();
        await this.saveShownSourcesByType();
        await this.saveExerciseTests();
        await this.saveShownTestsByType();
        break;
      }
      case 'source-test-file': {
        await this.saveExerciseSources();
        await this.saveShownSourcesByType();
        await this.saveExerciseTests();
        await this.saveShownTestsByType();
        await this.saveExerciseFiles();
        await this.saveShownFilesByType();
        break;
      }
      case 'test': {
        await this.saveExerciseSources();
        await this.saveShownTestsByType();
        break;
      }
      case 'test-file': {
        await this.saveExerciseSources();
        await this.saveShownTestsByType();
        await this.saveExerciseFiles();
        await this.saveShownFilesByType();
        break;
      }
      default: {
        console.log('defaut: Solution type was not found');
      }
    }
  }

  saveExerciseSources(): Promise<{}> {
    const sources: Array<ExerciseSource> = this.exerciseFormGroup.get('sourceControl').get('exercise').value;
    const observables = [];
    sources.forEach(s => {
      observables.push(this.saveExerciseSource(s));
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

  saveExerciseSource(source: ExerciseSource): Observable<{}> {
    source.exerciseId = this.exercise.id;
    console.log(source);
    return this.exerciseSourceService.createExerciseSource(source);
  }

  saveShownSourcesByType() {
    const shownSourcesType: string = this.exerciseFormGroup.get('sourceControl').get('shownType').get('chosen').value;
    console.log(shownSourcesType);
    if (shownSourcesType === 'same') {
      console.log('same run');
      const shownSources: Array<ShownSource> = this.exerciseFormGroup.get('sourceControl').get('exercise').value;
      this.saveShownSources(shownSources);
    } else if (shownSourcesType === 'custom') {
      const shownSources: Array<ExerciseSource> = this.exerciseFormGroup.get('sourceControl').get('shown').value;
      this.saveShownSources(shownSources);
    }
  }

  saveShownSources(shownSources: Array<ShownSource>): Promise<{}> {
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
    return this.shownSourceService.createShownSource(source);
  }


  saveExerciseTests(): Promise<{}> {
    const exerciseTests: Array<ExerciseTest> = this.exerciseFormGroup.get('testControl').get('exercise').value;
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

  saveShownTestsByType() {
    const shownTestsType: string = this.exerciseFormGroup.get('testControl').get('shownType').get('chosen').value;
    console.log(shownTestsType);
    if (shownTestsType === 'same') {
      const shownTests: Array<ShownTest> = this.exerciseFormGroup.get('testControl').get('exercise').value;
      console.log('same run');
      this.saveShownTests(shownTests);
    } else if (shownTestsType === 'custom') {
      const shownTests: Array<ShownTest> = this.exerciseFormGroup.get('testControl').get('shown').value;
      this.saveShownTests(shownTests);
    }
  }

  saveShownTests(shownTests: Array<ShownTest>): Promise<{}> {
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

  saveShownTest(test: ShownTest): Observable<{}> {
    test.exerciseId = this.exercise.id;
    console.log(test);
    return this.shownTestService.createShownTest(test);
  }

  saveExerciseFiles(): Promise<{}> {
    const files: Array<ExerciseTest> = this.exerciseFormGroup.get('fileControl').get('exercise').value;
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

  saveShownFilesByType() {
    const shownFilesType: string = this.exerciseFormGroup.get('fileControl').get('shownType').get('chosen').value;
    console.log(shownFilesType);
    if (shownFilesType === 'same') {
      const shownFiles: Array<ShownTest> = this.exerciseFormGroup.get('fileControl').get('exercise').value;
      console.log('same run');
      this.saveShownFiles(shownFiles);
    } else if (shownFilesType === 'custom') {
      const shownFiles: Array<ShownTest> = this.exerciseFormGroup.get('fileControl').get('shown').value;
      this.saveShownFiles(shownFiles);
    }
  }

  saveShownFiles(shownFiles: Array<ShownTest>): Promise<{}> {
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
    return this.exerciseFileService.createExerciseFile(file);
  }


  setSuccess() {
    this.exerciseFormGroup.get('params').get('success').setValue(true);
  }

}
