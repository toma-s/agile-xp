import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { switchMap } from 'rxjs/operators';
import { Title } from '@angular/platform-browser';
import { CourseService } from '../shared/course.service';
import { LessonService } from '../lessons/shared/lesson.service';
import { ExerciseService } from '../lessons/exercises/shared/exercise/exercise/exercise.service';
import { Exercise } from '../lessons/exercises/shared/exercise/exercise/exercise.model';
import { Course } from '../shared/course.model';
import { Lesson } from '../lessons/shared/lesson.model';
import { ExerciseTypeService } from '../lessons/exercises/shared/exercise/exercise-type/exercise-type.service';
import { ExerciseType } from '../lessons/exercises/shared/exercise/exercise-type/exercise-type.model';

@Component({
  selector: 'app-course-detail',
  templateUrl: './course-detail.component.html',
  styleUrls: ['./course-detail.component.scss']
})

export class CourseDetailComponent implements OnInit {

  course: Course;
  lessons: Array<Lesson>;
  exercises: Map<number, Array<Exercise>>;
  exerciseTypes: Array<ExerciseType>;

  constructor(
    private titleService: Title,
    private courseService: CourseService,
    private lessonService: LessonService,
    private exerciseService: ExerciseService,
    private exerciseTypeService: ExerciseTypeService,
    private route: ActivatedRoute
  ) {  }

  async ngOnInit() {
    await this.setCourse();
    this.setTitle();
    await this.setLessons();
    this.getExercises();
    this.getExerciseTypes();
  }

  async setCourse() {
    const course$ = this.route.paramMap.pipe(
      switchMap((params: ParamMap) =>
        this.courseService.getCourseById(Number(params.get('id')))
      )
    );
    this.course = await this.getCourse(course$);
  }

  setTitle() {
    this.titleService.setTitle(`${this.course.name} | AgileXP`);
  }

  getCourse(course$): Promise<Course> {
    return new Promise<Course>((resolve, reject) => {
      course$.subscribe(
        data => {
          resolve(data);
        },
        error => reject(error)
      );
    });
  }


  async setLessons() {
    const lessons$ = this.route.paramMap.pipe(
      switchMap((params: ParamMap) =>
        this.lessonService.getLessonsByCourseId(Number(params.get('id')))
      )
    );
    this.lessons = await this.getLessons(lessons$);
  }

  getLessons(lessons$) {
    return new Promise<Array<Lesson>>((resolve, reject) => {
      lessons$.subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  getExercises() {
    this.exercises = new Map();
    this.lessons.forEach(async lesson => {
      const exercises = await this.getExercisesArrayByLessonId(lesson.id);
      this.exercises.set(lesson.id, exercises);
    });
  }

  getExercisesArrayByLessonId(lessonId: number): Promise<Array<Exercise>> {
    return new Promise<Array<Exercise>>((resolve, reject) => {
      this.exerciseService.getExercisesByLessonId(lessonId).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  getExerciseTypes() {
    this.exerciseTypeService.getExericseTypesList()
      .subscribe(
        data => {
          this.exerciseTypes = data;
        },
        error => console.log(error)
      );
  }

  getExercisesByLessonId(lessonId: number): Array<Exercise> {
    return this.exercises.get(lessonId);
  }

  getExerciseTypeName(typeId: number) {
    return this.exerciseTypes.filter(et => et.id === typeId)[0].name;
  }

  delete(lesson: Lesson) {
    this.lessonService.deleteLesson(lesson.id).subscribe(
      data => {
        this.setLessons();
      },
      error => console.log(error)
    );
  }

}
