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
    private exerciseFileService: ExerciseFileService
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
    exercise.index = this.exerciseFormGroup.get('params').get('index').value;
    exercise.lessonId = this.exerciseFormGroup.get('params').get('lessonId').value;
    console.log(exercise);
    return exercise;
  }

  async saveExerciseItems() {
    const exerciseTypeValue = this.exerciseFormGroup.get('intro').get('type').value['value'];
    switch (exerciseTypeValue) {
      case 'source-test': {
        await this.saveSources();
        await this.saveTests();
        break;
      }
      case 'source-test-file': {
        await this.saveSources();
        await this.saveTests();
        await this.saveFiles();
        break;
      }
      case 'test': {
        await this.saveTests();
        break;
      }
      case 'test-file': {
        await this.saveTests();
        await this.saveFiles();
        break;
      }
      default: {
        console.log('defaut: Solution type was not found');
      }
    }
  }

  saveSources(): Promise<{}> {
    const sources: Array<ExerciseSource> = this.exerciseFormGroup.get('sources').value;
    const observables = [];
    sources.forEach(s => {
      observables.push(this.saveSource(s));
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

  saveSource(source: ExerciseSource): Observable<{}> {
    source.exerciseId = this.exercise.id;
    console.log(source);
    return this.exerciseSourceService.createExerciseSource(source);
  }

  saveTests(): Promise<{}> {
    const tests: Array<ExerciseTest> = this.exerciseFormGroup.get('tests').value;
    const observables = [];
    tests.forEach(s => {
      observables.push(this.saveTest(s));
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

  saveTest(test: ExerciseTest): Observable<{}> {
    test.exerciseId = this.exercise.id;
    console.log(test);
    return this.exerciseTestService.createExerciseTest(test);
  }

  saveFiles(): Promise<{}> {
    const files: Array<ExerciseTest> = this.exerciseFormGroup.get('files').value;
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


  setSuccess() {
    this.exerciseFormGroup.get('params').get('success').setValue(true);
  }

}
