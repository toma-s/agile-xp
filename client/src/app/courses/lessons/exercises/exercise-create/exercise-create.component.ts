import { Component, OnInit } from '@angular/core';
import { ExerciseType } from '../shared/exercise-type.model';
import { ExerciseTypeService } from '../shared/exercise-type.service';
import { Exercise } from '../shared/exercise.model';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ExerciseService } from '../shared/exercise.service';
import { ActivatedRoute } from '@angular/router';
import { SourceCode } from '../shared/source-code.model';
import { SourceCodeService } from '../shared/source-code.service';
import { HiddenTestService } from '../shared/hidden-test.service';
import { HiddenTest } from '../shared/hidden-test.model';

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
    private sourceCodeService: SourceCodeService,
    private hiddenTestService: HiddenTestService,
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
          const hiddenTest = this.createHiddenTestObject(data.id);
          this.saveHiddenTest(hiddenTest);
        },
        error => console.log(error)
      );
  }

  createSourceCodeObject(exerciseId: number): SourceCode {
    const sourceCode = new SourceCode();
    sourceCode.fileName = this.exerciseFormGroup.value.sourceFilename;
    sourceCode.code = this.exerciseFormGroup.value.sourceCode;
    sourceCode.exerciseId = exerciseId;
    console.log(sourceCode);
    return sourceCode;
  }

  saveSourceCode(sourceCode: SourceCode) {
    this.sourceCodeService.createSourceCode(sourceCode)
      .subscribe(
        data => {
          console.log(data);
        },
        error => console.log(error)
      );
  }

  createHiddenTestObject(exerciseId: number): HiddenTest {
    const hiddenTest = new HiddenTest();
    hiddenTest.fileName = this.exerciseFormGroup.value.testFilename;
    hiddenTest.code = this.exerciseFormGroup.value.testCode;
    hiddenTest.exerciseId = exerciseId;
    console.log(hiddenTest);
    return hiddenTest;
  }

  saveHiddenTest(hiddenTest: HiddenTest) {
    this.hiddenTestService.createHiddenTest(hiddenTest)
      .subscribe(
        data => {
          console.log(data);
        },
        error => console.log(error)
      );
  }

}
