import { Component, OnInit } from '@angular/core';
import { ExerciseType } from '../shared/exercise-type.model';
import { ExerciseTypeService } from '../shared/exercise-type.service';
import { Exercise } from '../shared/exercise.model';
import { FormBuilder, FormGroup, Validators, FormArray } from '@angular/forms';
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
  exercise: Exercise = new Exercise();

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
      selectedTypeValue: ['', Validators.required]
    });
  }

  submit() {
    console.log(this.exerciseFormGroup.value.name);
    console.log(this.exerciseFormGroup.value.description);

    switch (this.exerciseFormGroup.value.selectedTypeValue) {
      case 'white-box': {
        this.setExerciseValues();
        console.log(this.exercise);
        this.saveExercise();
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

  setExerciseValues() {
    this.exercise.name = this.exerciseFormGroup.value.name;
    this.exercise.lessonId = this.route.snapshot.params['lessonId'];
    this.exercise.type = this.exerciseFormGroup.value.selectedTypeValue;
    this.exercise.description = this.exerciseFormGroup.value.description;
  }

  saveExercise() {
    this.exerciseSercise.createExercise(this.exercise)
      .subscribe(
        data => {
          this.exercise.id = data.id;
          console.log(data);
          const exerciseSources = this.createSourceCodeObjects(data.id);
          this.saveSourceCodes(exerciseSources);
          const exerciseTests = this.createExerciseTestObjects(data.id);
          this.saveExerciseTests(exerciseTests);
        },
        error => console.log(error)
      );
  }

  createSourceCodeObjects(exerciseId: number): Array<ExerciseSource> {
    const exerciseSourceObjects = new Array<ExerciseSource>();
    const exerciseSources: FormArray = this.exerciseFormGroup.get('sources') as FormArray;
    console.log(exerciseSources);
    exerciseSources.value.forEach(es => {
      const exerciseSource = new ExerciseSource();
      exerciseSource.fileName = es.sourceFilename;
      exerciseSource.code = es.sourceCode;
      exerciseSource.exerciseId = exerciseId;
      exerciseSourceObjects.push(exerciseSource);
    });
    console.log(exerciseSourceObjects);
    return exerciseSourceObjects;
  }

  saveSourceCodes(exerciseSources: Array<ExerciseSource>) {
    exerciseSources.forEach(es => {
      this.sourceCodeService.createExerciseSource(es)
        .subscribe(
          data => {
            console.log(data);
          },
          error => console.log(error)
        );
    })
  }

  createExerciseTestObjects(exerciseId: number): Array<ExerciseTest> {
    const exerciseTestObjects = new Array<ExerciseTest>();
    const exerciseTests: FormArray = this.exerciseFormGroup.get('tests') as FormArray;
    exerciseTests.value.forEach(et => {
      const exerciseTest = new ExerciseTest();
      exerciseTest.fileName = et.testFilename;
      exerciseTest.code = et.testCode;
      exerciseTest.exerciseId = exerciseId;
      exerciseTestObjects.push(exerciseTest);
    });
    console.log(exerciseTestObjects);
    return exerciseTestObjects;
  }

  saveExerciseTests(exerciseTests: Array<ExerciseTest>) {
    exerciseTests.forEach(et => {
      this.exerciseTestService.createExerciseTest(et)
        .subscribe(
          data => {
            console.log(data);
          },
          error => console.log(error)
        );
    })
  }

}
