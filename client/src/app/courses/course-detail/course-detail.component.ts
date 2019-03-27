import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap, filter, map } from 'rxjs/operators';

import { CourseService } from '../shared/course.service';
import { LessonService } from '../lessons/shared/lesson.service';
import { ExerciseService } from '../lessons/exercises/shared/exercise.service';
import { Exercise } from '../lessons/exercises/shared/exercise.model';
import { Course } from '../shared/course.model';
import { Lesson } from '../lessons/shared/lesson.model';
import { ExerciseTypeService } from '../lessons/exercises/shared/exercise-type.service';
import { ExerciseType } from '../lessons/exercises/shared/exercise-type.model';

@Component({
  selector: 'app-course-detail',
  templateUrl: './course-detail.component.html',
  styleUrls: ['./course-detail.component.scss']
})

export class CourseDetailComponent implements OnInit {

  course$: Observable<Course>;
  lessons$: Observable<Lesson>;
  exercises$: Observable<Exercise>;
  exerciseTypes$: Observable<ExerciseType>;

  constructor(
    private courseService: CourseService,
    private lessonService: LessonService,
    private exerciseService: ExerciseService,
    private exerciseTypeService: ExerciseTypeService,
    private route: ActivatedRoute
  ) { }

  ngOnInit() {
    this.getCourse();
    this.getLessons();
    this.getExercises();
    this.getExerciseTypeNames();
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

  getExerciseTypeNames() {
    this.exerciseTypeService.getExericseTypesList()
      .subscribe(
        data => {
          this.exerciseTypes$ = data;
          console.log(data);
        },
        error => console.log(error)
      );
  }

  getExercisesByLessonId(lessonId: number) {
    const x = new Array<Exercise>();
    this.exercises$.forEach(ex => {
      if (ex.lessonId === lessonId) {
        x.push(ex);
      }
    });
    return x;
  }

  getExerciseTypeName(value: string) {
    let typeName = '';
    this.exerciseTypes$.forEach(et => {
      if (et.value === value) {
        typeName = et.name;
      }
    });
    return typeName;
  }
  
  delete(lesson: Lesson) {
    this.lessonService.deleteLesson(lesson.id).subscribe(
      data => {
        console.log(data);
        this.getLessons();
      },
      error => console.log(error)
    );
  }

}
