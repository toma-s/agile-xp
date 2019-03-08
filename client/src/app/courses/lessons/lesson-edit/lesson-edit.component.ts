import { Component, OnInit } from '@angular/core';
import { LessonService } from '../shared/lesson.service';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-lesson-edit',
  templateUrl: './lesson-edit.component.html',
  styleUrls: ['./lesson-edit.component.scss']
})
export class LessonEditComponent implements OnInit {

  lesson$: Observable<any>;

  constructor(
    private lessonServise: LessonService,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.getLessonByIdParam();
  }

  getLessonByIdParam() {
    const lesson = this.route.paramMap.pipe(
      switchMap((params: ParamMap) =>
        this.lessonServise.getLessonById(Number(params.get('lessonId')))
      )
    );
    console.log(lesson);
    this.lesson$ = lesson;
  }

}
