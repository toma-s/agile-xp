import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, ControlContainer, FormArray } from '@angular/forms';
import { MatDialog, MatDialogRef, MatDialogConfig } from '@angular/material';
import { LoadSolutionDialogComponent } from '../load-solution-dialog/load-solution-dialog.component';
import { SolutionContent } from '../../shared/solution/solution-content/solution-content.model';
import { PublicSourceService } from '../../shared/public/public-source/public-source.service';
import { PublicTestService } from '../../shared/public/public-test/public-test.service';
import { PublicFileService } from '../../shared/public/public-file/public-file.service';
import { ExerciseService } from '../../shared/exercise/exercise/exercise.service';
import { LessonService } from '../../../shared/lesson.service';
import { Exercise } from '../../shared/exercise/exercise/exercise.model';
import { Lesson } from '../../../shared/lesson.model';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'solve-editor',
  templateUrl: './solve-editor.component.html',
  styleUrls: ['./solve-editor.component.scss']
})
export class SolveEditorComponent implements OnInit {

  @Input() solutionFormGroup: FormGroup;
  form: FormGroup;
  editorOptions = { theme: 'vs', language: 'java' };
  dialogRef: MatDialogRef<LoadSolutionDialogComponent>;
  lessons: Array<Lesson>;
  exercises: Map<string, Array<Exercise>> = new Map();

  constructor(
    public controlContainer: ControlContainer,
    public dialog: MatDialog,
    private lessonService: LessonService,
    private exerciseService: ExerciseService,
    private publicSourceService: PublicSourceService,
    private publicTestService: PublicTestService,
    private publicFileService: PublicFileService,
    private route: ActivatedRoute
  ) { }

  async ngOnInit() {
    this.form = <FormGroup>this.controlContainer.control;
    console.log(this.form);
    this.setEditorOptions();
    this.getLessons();
  }

  setEditorOptions() {
    if (this.form.get('solutionControl').get('solutionType').value.search('file') !== -1) {
      this.editorOptions.language = 'text';
    } else {
      this.editorOptions.language = 'java';
    }
  }


  getLessons() {
    const courseId = Number(this.route.snapshot.params['courseId']);
    this.lessonService.getLessonsByCourseId(courseId).subscribe(
      data => {
        console.log(data);
        this.lessons = data;
        this.getExercises();
      },
      error => console.log(error)
    );
  }

  getExercises() {
    this.lessons.forEach(lesson => {
      this.exerciseService.getExercisesByLessonId(lesson.id).subscribe(
        data => {
          this.exercises[lesson.id] = data;
        },
        error => console.log(error)
      );
    });
  }


  reset() {
    const exerciseId = this.solutionFormGroup.get('intro').get('exerciseId').value;
    switch (this.form.get('solutionControl').get('solutionType').value) {
      case 'source': {
        this.publicSourceService.getPublicSourcesByExerciseId(exerciseId).subscribe(
          data => this.form.get('solutionControl').get('tabContent').setValue(data),
          error => console.log(error)
        );
        break;
      }
      case 'test': {
        this.publicTestService.getPublicTestsByExerciseId(exerciseId).subscribe(
          data => this.form.get('solutionControl').get('tabContent').setValue(data),
          error => console.log(error)
        );
        break;
      }
      case 'file': {
        this.publicFileService.getPublicFilesByExerciseId(exerciseId).subscribe(
          data => this.form.get('solutionControl').get('tabContent').setValue(data),
          error => console.log(error)
        );
        break;
      }
    }
  }

  showLoadSolutionDialog(exercise: Exercise) {
    const config = new MatDialogConfig();
    this.dialogRef = this.dialog.open(LoadSolutionDialogComponent, config);
    this.dialogRef.componentInstance.exerciseId = this.getDialogExerciseId(exercise);
    this.dialogRef.componentInstance.solutionType = this.form.get('solutionControl').get('solutionType').value;
    this.dialogRef.afterClosed().subscribe(result => {
      if (result === undefined) {
        return;
      }
      this.updateContent(result);
      console.log(result);
    });
  }

  getDialogExerciseId(exercise: Exercise) {
    if (exercise === null) {
      return Number(this.solutionFormGroup.get('intro').get('exerciseId').value);
    }
    return exercise.id;
  }

  updateContent(newSolutionContent: SolutionContent) {
    const currentContents: Array<SolutionContent> = this.form.get('solutionControl').get('tabContent').value;
    for (let i = 0; i < currentContents.length; i++) {
      const currentContent = currentContents[i];
      if (currentContent.filename === newSolutionContent.filename) {
        const control = this.form.get('solutionControl').get('tabContent') as FormArray;
        const controlItem = control.at(i);
        controlItem.get('content').setValue(newSolutionContent.content);
      }
    }
  }

}
