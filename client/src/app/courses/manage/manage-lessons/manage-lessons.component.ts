import { Component } from '@angular/core';
import { ManageComponent } from '../manage.component';
import { Title } from '@angular/platform-browser';
import { CourseService } from 'src/app/courses/shared/course.service';
import { ActivatedRoute } from '@angular/router';
import { Course } from 'src/app/courses/shared/course.model';
import { forkJoin } from 'rxjs';
import { Lesson } from '../../lessons/shared/lesson.model';
import { LessonService } from '../../lessons/shared/lesson.service';

@Component({
  selector: 'manage-lessons',
  templateUrl: '../manage.component.html',
  styleUrls: ['../manage.component.scss']
})
export class ManageLessonsComponent extends ManageComponent {

  protected module = 'lessons';
  protected routerLinkBack = '../';
  protected parent: Course;
  protected content: Array<Lesson>;
  protected parentName = 'course';
  protected contentName = 'lesson';
  protected reorderable = true;
  protected routerLinkCreate: any;

  constructor(
    protected titleService: Title,
    protected route: ActivatedRoute,
    private courseService: CourseService,
    private lessonServise: LessonService
  ) {
    super(titleService, route);
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


  getRouterLinkCreate() {
    this.routerLinkCreate = `create/${this.contentName}/${this.index}`;
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
