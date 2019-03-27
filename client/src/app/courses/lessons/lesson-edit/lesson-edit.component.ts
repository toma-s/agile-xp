import { Component, OnInit } from '@angular/core';
import { LessonService } from '../shared/lesson.service';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';
import { ExerciseService } from '../exercises/shared/exercise.service';
import { Lesson } from '../shared/lesson.model';
import { Exercise } from '../exercises/shared/exercise.model';

@Component({
  selector: 'app-lesson-edit',
  templateUrl: './lesson-edit.component.html',
  styleUrls: ['./lesson-edit.component.scss']
})
export class LessonEditComponent implements OnInit {

  lesson: Lesson;
  exercises: Array<Exercise>;
  index: number;

  constructor(
    private lessonServise: LessonService,
    private exerciseService: ExerciseService,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.getLessonByIdParam();
  }

  getLessonByIdParam() {
    const lesson$ = this.route.paramMap.pipe(
      switchMap((params: ParamMap) =>
        this.lessonServise.getLessonById(Number(params.get('lessonId')))
      )
    );
    lesson$
      .subscribe(
        data => {
          console.log(data);
          this.lesson = data;
          this.getExercises();
        },
        error => console.log(error)
      );
  }

  getExercises() {
    this.exerciseService.getExercisesByLessonId(this.lesson.id)
      .subscribe(
        data => {
          console.log(data);
          this.exercises = data;
          this.getIndex();
        },
        error => console.log(error)
      )
  }

  getIndex() {
    this.index = this.exercises.length;
  }

}
