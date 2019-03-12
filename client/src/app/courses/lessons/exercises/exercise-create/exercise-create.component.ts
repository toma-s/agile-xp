import { Component, OnInit } from '@angular/core';
import { ExerciseType } from '../shared/exercise-type.model';
import { ExerciseTypeService } from '../shared/exercise-type.service';
import { Exercise } from '../shared/exercise.model';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ExerciseService } from '../shared/exercise.service';
import { ActivatedRoute } from '@angular/router';
import { ExerciseSource } from '../shared/exercise-source.model';
import { ExerciseSourceService } from '../shared/exercise-source.service';
import { ExerciseTestService } from '../shared/exercise-test.service';
import { ExerciseTest } from '../shared/exercise-test.model';

@Component({
  selector: 'app-exercise-create',
  templateUrl: './exercise-create.component.html',
  styleUrls: ['./exercise-create.component.scss']
})
export class ExerciseCreateComponent implements OnInit {

  submitted = false;
  types = new Array<ExerciseType>();
  exerciseFormGroup: FormGroup;

  constructor(
    private exerciseSercise: ExerciseService,
    private exerciseTypeServise: ExerciseTypeService,
    private sourceCodeService: ExerciseSourceService,
    private exerciseTestService: ExerciseTestService,
    private fb: FormBuilder,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.getExerciseTypes();
    this.createForm();
  }

  getExerciseTypes() {
    this.exerciseTypeServise.getExericseTypesList()
      .subscribe(
        data => {
          this.types = data;
        },
        error => console.log(error)
      );
  }

  createForm() {
    this.exerciseFormGroup = this.fb.group({
      name: ['', Validators.required],
      description: ['', Validators.required],
      selectedTypeValue: ['', Validators.required],
      sourceFilename: [],
      sourceCode: [],
      testFilename: [],
      testCode: []
    });
  }

  submit() {
    console.log(this.exerciseFormGroup.value.name);
    console.log(this.exerciseFormGroup.value.description);

    switch (this.exerciseFormGroup.value.selectedTypeValue) {
      case 'white-box': {
        const exercise = this.createExercise();
        console.log(exercise);
        this.saveExercise(exercise);
        break;
      }
      // todo
      default: {
        console.log('default');
        console.log(this.exerciseFormGroup.value.sourceFilename); // todo
        break;
      }
    }
  }

  createExercise(): Exercise {
    const exercise = new Exercise();
    exercise.name = this.exerciseFormGroup.value.name;
    exercise.lessonId = this.route.snapshot.params['lessonId'];
    exercise.type = this.exerciseFormGroup.value.selectedTypeValue;
    exercise.description = this.exerciseFormGroup.value.description;
    return exercise;
  }

  saveExercise(exercise: Exercise) {
    this.exerciseSercise.createExercise(exercise)
      .subscribe(
        data => {
          console.log(data);
          const sourceCode = this.createSourceCodeObject(data.id);
          this.saveSourceCode(sourceCode);
          const exerciseTest = this.createExerciseTestObject(data.id);
          this.saveExerciseTest(exerciseTest);
        },
        error => console.log(error)
      );
  }

  createSourceCodeObject(exerciseId: number): ExerciseSource {
    const sourceCode = new ExerciseSource();
    sourceCode.fileName = this.exerciseFormGroup.value.sourceFilename;
    sourceCode.code = this.exerciseFormGroup.value.sourceCode;
    sourceCode.exerciseId = exerciseId;
    console.log(sourceCode);
    return sourceCode;
  }

  saveSourceCode(sourceCode: ExerciseSource) {
    this.sourceCodeService.createSourceCode(sourceCode)
      .subscribe(
        data => {
          console.log(data);
        },
        error => console.log(error)
      );
  }

  createExerciseTestObject(exerciseId: number): ExerciseTest {
    const exerciseTest = new ExerciseTest();
    exerciseTest.fileName = this.exerciseFormGroup.value.testFilename;
    exerciseTest.code = this.exerciseFormGroup.value.testCode;
    exerciseTest.exerciseId = exerciseId;
    console.log(exerciseTest);
    return exerciseTest;
  }

  saveExerciseTest(exerciseTest: ExerciseTest) {
    this.exerciseTestService.createExerciseTest(exerciseTest)
      .subscribe(
        data => {
          console.log(data);
        },
        error => console.log(error)
      );
  }

}
