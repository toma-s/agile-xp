import { Component } from '@angular/core';
import { ManageComponent } from '../manage.component';
import { Title } from '@angular/platform-browser';
import { CourseService } from 'src/app/courses/shared/course.service';
import { LessonService } from '../../shared/lesson.service';
import { ActivatedRoute } from '@angular/router';
import { Course } from 'src/app/courses/shared/course.model';
import { Lesson } from '../../shared/lesson.model';
import { forkJoin } from 'rxjs';

@Component({
  selector: 'manage-lessons',
  templateUrl: '../manage.component.html',
  styleUrls: ['../manage.component.scss']
})
export class ManageLessonsComponent extends ManageComponent {

  protected module = 'lessons';
  protected routerLink = '../';
  protected parent: Course;
  protected content: Array<Lesson>;
  protected parentName;
  protected contentName;

  constructor(
    protected titleService: Title,
    protected route: ActivatedRoute,
    private courseService: CourseService,
    private lessonServise: LessonService
  ) {
    super(titleService, route);
  }


  setNames() {
    this.parentName = 'course';
    this.contentName = 'lesson';
  }


  async readParams() {
    this.parent = await this.getCourse();
  }

  getCourse(): Promise<Course> {
    const courseId = this.route.snapshot.params['courseId'];
    return new Promise<Course>((resolve, reject) => {
      this.courseService.getCourseById(courseId).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  async getContent() {
    this.content = await this.getLessons();
  }

  getLessons(): Promise<Array<Lesson>> {
    return new Promise<Array<Lesson>>((resolve, reject) => {
      this.lessonServise.getLessonsByCourseId(this.parent.id).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  reorder(newExercisesArray) {
    const observables = [];
    for (let i = 0; i < this.content.length; i++) {
      this.content[i].index = i;
      observables.push(
        this.lessonServise.updateLesson(this.content[i].id, this.content[i])
      );
    }
    forkJoin(observables).subscribe(
      data => {
        console.log(data);
      },
      error => {
        console.log(error);
        this.content = Object.assign([], newExercisesArray);
      }
    );
  }


  delete(lessonId) {
    this.lessonServise.deleteLesson(lessonId).subscribe(
      data => {
        console.log(data);
        this.load();
      },
      error => console.log(error)
    );
  }


}
