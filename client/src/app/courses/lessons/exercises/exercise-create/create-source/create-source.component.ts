import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, FormArray, FormControl, Validators } from '@angular/forms';
import { MatDialog, MatDialogRef } from '@angular/material';
import { DialogComponent } from '../dialog/dialog.component';
import { Lesson } from '../../../shared/lesson.model';
import { ActivatedRoute } from '@angular/router';
import { LessonService } from '../../../shared/lesson.service';
import { Exercise } from '../../shared/exercise/exercise.model';
import { ExerciseService } from '../../shared/exercise/exercise.service';

@Component({
  selector: 'create-source',
  templateUrl: './create-source.component.html',
  styleUrls: ['./create-source.component.scss']
})
export class CreateSourceComponent implements OnInit {

  @Input() exerciseFormGroup: FormGroup;
  editorOptions = { theme: 'vs', language: 'java'/*, minimap: {'enabled': false}*/ };
  dialogRef: MatDialogRef<DialogComponent>;
  lessons: Array<Lesson>;
  exercises: Array<Exercise>;

  constructor(
    private fb: FormBuilder,
    public dialog: MatDialog,
    private route: ActivatedRoute,
    private lessonService: LessonService,
    private exerciseService: ExerciseService
  ) { }

  ngOnInit() {
    this.setSources();
    this.setLessons();
    this.onLessonIdChange();
  }

  setSources() {
    this.exerciseFormGroup.addControl(
      'sources', this.fb.array([this.createSource()]),
    );
    this.exerciseFormGroup.addControl(
      'loadSources', this.fb.group({
        checked: this.fb.control(false),
        lessonId: new FormControl(null),
        exerciseId: new FormControl(null)
      })
    );
    this.setupValidators();
  }

  createSource(): FormGroup {
    return this.fb.group({
      filename: ['SourceCodeFilename.java'],
      content: ['', Validators.compose([Validators.required])]
    });
  }

  setupValidators() {
    this.exerciseFormGroup.get('intro').get('type').valueChanges.subscribe(typeValue => {
      if (typeValue.value.search('source') !== -1) {
        this.exerciseFormGroup.get('sources').controls.forEach(control => {
          control.get('content').setValidators(Validators.required);
        });
      } else {
        this.exerciseFormGroup.get('sources').controls.forEach(control => {
          control.get('content').clearValidators();
        });
      }
    });
  }


  async setLessons() {
    this.lessons = await this.getLessons();
    console.log(this.lessons);
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
    this.exerciseFormGroup.get('loadSources').get('lessonId').valueChanges.subscribe((lessonId) => {
      this.exerciseService.getExercisesByLessonId(lessonId).subscribe(
        data => this.exercises = data,
        error => console.log(error)
      );
    });
  }


  removeSource(index: number) {
    const sources = this.exerciseFormGroup.get('sources') as FormArray;
    sources.removeAt(index);
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

  addSource() {
    const sources = this.exerciseFormGroup.get('sources') as FormArray;
    sources.push(this.createSource());
  }

}
