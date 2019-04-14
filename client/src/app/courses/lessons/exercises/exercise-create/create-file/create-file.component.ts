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
  selector: 'create-file',
  templateUrl: './create-file.component.html',
  styleUrls: ['./create-file.component.scss']
})
export class CreateFileComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  editorOptions = { theme: 'vs', /*, minimap: {'enabled': false}*/ };
  dialogRef: MatDialogRef<DialogComponent>;
  files = 'files';
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
    this.set();
    this.setLessons();
    this.onLessonIdChange();
  }

  set() {
    this.exerciseFormGroup.addControl(
      this.files, this.fb.array([this.create()])
    );
    this.exerciseFormGroup.addControl(
      'loadFiles', this.fb.group({
        checked: this.fb.control(false),
        lessonId: new FormControl(null),
        exerciseId: new FormControl(null)
      })
    );
    this.setupValidators();
  }

  create(): FormGroup {
    return this.fb.group({
      filename: ['FileFilename.java'],
      content: ['', Validators.compose([Validators.required])]
    });
  }

  setupValidators() {
    this.exerciseFormGroup.get('intro').get('type').valueChanges.subscribe(typeValue => {
      if (typeValue.value.search('file') !== -1) {
        this.exerciseFormGroup.get('files').controls.forEach(control => {
          control.get('content').setValidators(Validators.required);
        });
      } else {
        this.exerciseFormGroup.get('files').controls.forEach(control => {
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
    this.exerciseFormGroup.get('loadFiles').get('lessonId').valueChanges.subscribe((lessonId) => {
      this.exerciseService.getExercisesByLessonId(lessonId).subscribe(
        data => this.exercises = data,
        error => console.log(error)
      );
    });
  }


  remove(index: number) {
    const files = this.exerciseFormGroup.get(this.files) as FormArray;
    files.removeAt(index);
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
    const files = this.exerciseFormGroup.get(this.files) as FormArray;
    files.push(this.create());
  }

}
