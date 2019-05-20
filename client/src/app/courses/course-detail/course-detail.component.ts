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
import { SolutionEstimation } from '../lessons/exercises/shared/solution/solution-estimation/solution-estimation.model';
import { SolutionEstimationService } from '../lessons/exercises/shared/solution/solution-estimation/solution-estimation.service';

@Component({
  selector: 'app-course-detail',
  templateUrl: './course-detail.component.html',
  styleUrls: ['./course-detail.component.scss']
})

export class CourseDetailComponent implements OnInit {

  course: Course;
  lessons: Array<Lesson>;
  exercises: Map<number, Array<Exercise>>;
  // estimations: Map<number, SolutionEstimation>;
  exerciseTypes: Array<ExerciseType>;
  wasDeleted = false;

  constructor(
    private titleService: Title,
    private courseService: CourseService,
    private lessonService: LessonService,
    private exerciseService: ExerciseService,
    private exerciseTypeService: ExerciseTypeService,
    // private solutionEstimationService: SolutionEstimationService,
    private route: ActivatedRoute
  ) {  }

  async ngOnInit() {
    await this.setCourse();
    this.setTitle();
    await this.setLessons();
    this.exercises = await this.getExercises();
    console.log(this.exercises);
    // this.estimations = await this.getEstimations();
    // console.log(this.estimations);
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
    const exercises = new Map();
    this.lessons.forEach(async lesson => {
      const loadedExercises = await this.getExercisesArrayByLessonId(lesson.id);
      exercises.set(lesson.id, loadedExercises);
    });
    return exercises;
  }

  getExercisesArrayByLessonId(lessonId: number): Promise<Array<Exercise>> {
    return new Promise<Array<Exercise>>((resolve, reject) => {
      this.exerciseService.getExercisesByLessonId(lessonId).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  // getEstimations() {
  //   const estimations = new Map();
  //   console.log(this.exercises);
  //   this.exercises.forEach((value: Array<Exercise>, key: number) => {
  //     console.log(key);
  //     console.log(value);
  //     console.log('wwww');
  //     value.forEach(exercise => {
  //       console.log(exercise);
  //       estimations.set(exercise.id, new SolutionEstimation());
  //     });
  //   });
  //   return estimations;
  // }


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


  deleteCourse() {
    this.courseService.deleteCourse(this.course.id).subscribe(
      data => {
        console.log(data);
        this.wasDeleted = true;
      },
      error => console.log(error)
    );
  }

  deleteLesson(lesson: Lesson) {
    this.lessonService.deleteLesson(lesson.id).subscribe(
      data => {
        this.setLessons();
      },
      error => console.log(error)
    );
  }


}
