import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormArray, FormControl } from '@angular/forms';
import { MatDialogRef, MatDialog } from '@angular/material';
import { DialogComponent } from '../dialog/dialog.component';
import { Lesson } from '../../../shared/lesson.model';
import { Exercise } from '../../shared/exercise/exercise.model';
import { LessonService } from '../../../shared/lesson.service';
import { ExerciseService } from '../../shared/exercise/exercise.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'create-test',
  templateUrl: './create-test.component.html',
  styleUrls: ['./create-test.component.scss']
})
export class CreateTestComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };
  dialogRef: MatDialogRef<DialogComponent>;
  lessons: Array<Lesson>;
  exercises: Array<Exercise>;

  constructor(
    private fb: FormBuilder,
    public dialog: MatDialog,
    private lessonService: LessonService,
    private exerciseService: ExerciseService,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.setTests();
    this.setLessons();
    this.onLessonIdChange();
  }

  setTests() {
    this.exerciseFormGroup.addControl(
      'tests', this.fb.array([this.create()])
    );
    this.exerciseFormGroup.addControl(
      'loadTests', this.fb.group({
        checked: this.fb.control(false),
        lessonId: new FormControl(null),
        exerciseId: new FormControl(null)
      })
    );
    this.setupValidators();
  }


  setupValidators() {
    this.exerciseFormGroup.get('intro').get('type').valueChanges.subscribe(typeValue => {
      if (typeValue.value.search('test') !== -1) {
        console.log('found');
        this.exerciseFormGroup.get('tests').controls.forEach(control => {
          control.get('content').setValidators(Validators.required);
        });
      } else {
        this.exerciseFormGroup.get('tests').controls.forEach(control => {
          control.get('content').clearValidators();
        });
      }
    });
  }


  async setLessons() {
    this.lessons = await this.getLessons();
  }

  getLessons() {
    const course = this.route.snapshot.params['courseId'];
    return new Promise<Array<Lesson>>((resolve, reject) => {
      this.lessonService.getLessonsByCourseId(course).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  onLessonIdChange() {
    this.exerciseFormGroup.get('loadTests').get('lessonId').valueChanges.subscribe((lessonId) => {
      this.exerciseService.getExercisesByLessonId(lessonId).subscribe(
        data => this.exercises = data,
        error => console.log(error)
      );
    });
  }


  create(): FormGroup {
    return this.fb.group({
      filename: ['TestFilename.java'],
      content: ['', Validators.compose([Validators.required])]
    });
  }


  remove(index: number) {
    const tests = this.exerciseFormGroup.get('tests') as FormArray;
    tests.removeAt(index);
  }

  editFilename(formControl: FormControl) {
    this.dialogRef = this.dialog.open(DialogComponent);
    this.dialogRef.afterClosed().subscribe(result => {
      if (result === undefined) {
        return;
      }
      formControl.setValue(`${result}.java`);
    });
  }

  add() {
    const tests = this.exerciseFormGroup.get('tests') as FormArray;
    tests.push(this.create());
  }

}
