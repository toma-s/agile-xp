import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';

import { CourseService } from '../shared/course.service';
import { LessonService } from '../lessons/shared/lesson.service';
import { ExerciseService } from '../lessons/exercises/shared/exercise.service';

@Component({
  selector: 'app-course-detail',
  templateUrl: './course-detail.component.html',
  styleUrls: ['./course-detail.component.scss']
})

export class CourseDetailComponent implements OnInit {

  course$: Observable<any>;
  lessons$: Observable<any>;
  exercises$: Observable<any>;

  constructor(
    private courseService: CourseService,
    private lessonService: LessonService,
    private exerciseService: ExerciseService,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.getCourse();
    this.getLessons();
    this.getExercises();
  }

  getCourse() {
    const course = this.route.paramMap.pipe(
      switchMap((params: ParamMap) =>
        this.courseService.getCourseById(Number(params.get('id')))
      )
    );
    this.course$ = course;
  }

  getLessons() {
    const lessons = this.route.paramMap.pipe(
      switchMap((params: ParamMap) =>
        this.lessonService.getLessonsByCourseId(Number(params.get('id')))
      )
    );
    this.lessons$ = lessons;
  }

  getExercises() {
    this.exerciseService.getExercisesList()
      .subscribe(
        data => {
          this.exercises$ = data;
          console.log(data);
        },
        error => console.log(error)
      );
  }

}
