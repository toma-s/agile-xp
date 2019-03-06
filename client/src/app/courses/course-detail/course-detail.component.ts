import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { Router, ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';

import { Course } from '../shared/course.model';
import { CourseService } from '../shared/course.service';
import { LessonService } from '../shared/lesson.service';

@Component({
  selector: 'app-course-detail',
  templateUrl: './course-detail.component.html',
  styleUrls: ['./course-detail.component.scss']
})

export class CourseDetailComponent implements OnInit {

  course$: Observable<any>;
  lessons$: Observable<any>;

  constructor(
    private courseService: CourseService,
    private lessonServise: LessonService,
    private route: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit() {
    const course = this.route.paramMap.pipe(
      switchMap((params: ParamMap) =>
        this.courseService.getCourseById(Number(params.get('id')))
      )
    );
    console.log(course);
    this.course$ = course;

    const lessons = this.route.paramMap.pipe(
      switchMap((params: ParamMap) =>
        this.lessonServise.getLessonsByCourseId(Number(params.get('id')))
      )
    );
    console.log(lessons);
    this.lessons$ = lessons;

    // todo exercises
  }

}
