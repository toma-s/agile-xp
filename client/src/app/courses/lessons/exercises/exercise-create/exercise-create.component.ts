import { Component, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { ExerciseType } from '../shared/exercise-type/exercise-type.model';
import { Exercise } from '../shared/exercise/exercise.model';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';

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
  index: number;

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.getIndex();
    this.createForm();
    console.log(this.exerciseFormGroup);
  }

  createForm() {
    this.exerciseFormGroup = this.fb.group({
      'params': this.fb.group({
        index: [this.getIndex(), Validators.compose([Validators.required])],
        lessonId: [this.getLessonId(), Validators.compose([Validators.required])]
      })
    });
  }

  getIndex() {
    return Number(this.route.snapshot.params['index']);
  }

  getLessonId() {
    return this.route.snapshot.params['lessonId'];
  }

  // submit() {
  //   console.log(this.exerciseFormGroup.value.name);
  //   console.log(this.exerciseFormGroup.value.description);

  //   switch (this.exerciseFormGroup.value.selectedTypeValue) {
  //     case 'white-box': {
  //       this.setExerciseValues();
  //       console.log(this.exercise);
  //       this.saveExercise();
  //       break;
  //     }
  //     // todo
  //     default: {
  //       console.log('default');
  //       console.log(this.exerciseFormGroup.value.sourceFilename); // todo
  //       break;
  //     }
  //   }
  // }

  // setExerciseValues() {
  //   this.exercise.name = this.exerciseFormGroup.value.name;
  //   this.exercise.index = this.index;
  //   this.exercise.lessonId = this.route.snapshot.params['lessonId'];
  //   // TODO
  //   // this.exercise.typeId = this.exerciseFormGroup.value.selectedTypeValue;
  //   this.exercise.description = this.exerciseFormGroup.value.description;
  // }

  // saveExercise() {
  //   this.exerciseSercise.createExercise(this.exercise)
  //     .subscribe(
  //       data => {
  //         this.exercise.id = data.id;
  //         console.log(data);
  //         const exerciseSources = this.createSourceObjects(data.id);
  //         this.saveExerciseSources(exerciseSources);
  //         const exerciseTests = this.createExerciseTestObjects(data.id);
  //         this.saveExerciseTests(exerciseTests);
  //       },
  //       error => console.log(error)
  //     );
  // }

  // createSourceObjects(exerciseId: number): Array<ExerciseSource> {
  //   const exerciseSourceObjects = new Array<ExerciseSource>();
  //   const exerciseSources: FormArray = this.exerciseFormGroup.get('sources') as FormArray;
  //   console.log(exerciseSources);
  //   exerciseSources.value.forEach(es => {
  //     const exerciseSource = new ExerciseSource();
  //     exerciseSource.fileName = es.sourceFilename;
  //     exerciseSource.content = es.sourceCode;
  //     exerciseSource.exerciseId = exerciseId;
  //     exerciseSourceObjects.push(exerciseSource);
  //   });
  //   console.log(exerciseSourceObjects);
  //   return exerciseSourceObjects;
  // }

  // saveExerciseSources(exerciseSources: Array<ExerciseSource>) {
  //   exerciseSources.forEach(es => {
  //     this.exerciseSourceService.createExerciseSource(es)
  //       .subscribe(
  //         data => {
  //           console.log(data);
  //         },
  //         error => console.log(error)
  //       );
  //   });
  // }

  // createExerciseTestObjects(exerciseId: number): Array<ExerciseTest> {
  //   const exerciseTestObjects = new Array<ExerciseTest>();
  //   const exerciseTests: FormArray = this.exerciseFormGroup.get('tests') as FormArray;
  //   exerciseTests.value.forEach(et => {
  //     const exerciseTest = new ExerciseTest();
  //     exerciseTest.fileName = et.testFilename;
  //     exerciseTest.content = et.testCode;
  //     exerciseTest.exerciseId = exerciseId;
  //     exerciseTestObjects.push(exerciseTest);
  //   });
  //   console.log(exerciseTestObjects);
  //   return exerciseTestObjects;
  // }

  // saveExerciseTests(exerciseTests: Array<ExerciseTest>) {
  //   exerciseTests.forEach(et => {
  //     this.exerciseTestService.createExerciseTest(et)
  //       .subscribe(
  //         data => {
  //           console.log(data);
  //         },
  //         error => console.log(error)
  //       );
  //   });
  // }

}
