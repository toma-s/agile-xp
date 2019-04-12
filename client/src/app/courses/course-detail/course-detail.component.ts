import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';

import { CourseService } from '../shared/course.service';
import { LessonService } from '../lessons/shared/lesson.service';
import { ExerciseService } from '../lessons/exercises/shared/exercise/exercise.service';
import { Exercise } from '../lessons/exercises/shared/exercise/exercise.model';
import { Course } from '../shared/course.model';
import { Lesson } from '../lessons/shared/lesson.model';
import { ExerciseTypeService } from '../lessons/exercises/shared/exercise-type/exercise-type.service';
import { ExerciseType } from '../lessons/exercises/shared/exercise-type/exercise-type.model';

@Component({
  selector: 'app-course-detail',
  templateUrl: './course-detail.component.html',
  styleUrls: ['./course-detail.component.scss']
})

export class CourseDetailComponent implements OnInit {

  course: Course;
  lessons: Array<Lesson>;
  exercises: Array<Exercise>;
  exerciseTypes: Array<ExerciseType>;

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
    this.getExerciseTypes();
  }

  getCourse() {
    const course$ = this.route.paramMap.pipe(
      switchMap((params: ParamMap) =>
        this.courseService.getCourseById(Number(params.get('id')))
      )
    );
    course$.subscribe(
      data => {
        this.course = data;
        console.log(this.course);
      },
      error => console.log(error)
    );
  }

  getLessons() {
    const lessons$ = this.route.paramMap.pipe(
      switchMap((params: ParamMap) =>
        this.lessonService.getLessonsByCourseId(Number(params.get('id')))
      )
    );
    lessons$.subscribe(
      data => {
        this.lessons = data;
        console.log(this.lessons);
      },
      error => console.log(error)
    );
  }

  getExercises() {
    this.exerciseService.getExercisesList()
      .subscribe(
        data => {
          this.exercises = data;
          console.log(data);
        },
        error => console.log(error)
      );
  }

  getExerciseTypes() {
    this.exerciseTypeService.getExericseTypesList()
      .subscribe(
        data => {
          this.exerciseTypes = data;
          console.log(data);
        },
        error => console.log(error)
      );
  }

  getExercisesByLessonId(lessonId: number) {
    const exercises = new Array<Exercise>();
    this.exercises.forEach(ex => {
      if (ex.lessonId === lessonId) {
        exercises.push(ex);
      }
    });
    console.log(exercises);
    return exercises;
  }

  getExerciseTypeName(typeId: number) {
    return this.exerciseTypes.filter(et => et.id === typeId)[0].name;
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
