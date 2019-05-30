import { Component } from '@angular/core';
import { ManageComponent } from '../manage.component';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';
import { Course } from '../../shared/course.model';
import { CourseService } from '../../shared/course.service';

@Component({
  selector: 'manage-exercises',
  templateUrl: '../manage.component.html',
  styleUrls: ['../manage.component.scss']
})
export class ManageCoursesComponent extends ManageComponent {

  protected module = 'courses';
  protected routerLinkBack = '../';
  protected parent: null;
  protected content: Array<Course>;
  protected parentName = null;
  protected contentName = 'course';
  protected reorderable = false;
  protected routerLinkCreate: any;

  constructor(
    protected titleService: Title,
    protected route: ActivatedRoute,
    private courseService: CourseService,
  ) {
    super(titleService, route);
  }

  async readParams() {
  }

  async getContent() {
    this.content = await this.getCourses();
  }

  getCourses(): Promise<Array<Course>> {
    return new Promise<Array<Course>>((resolve, reject) => {
      this.courseService.getCoursesList().subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  getRouterLinkCreate() {
    this.routerLinkCreate = `create/${this.contentName}`;
  }


  reorder(newExercisesArray) {
  }


  delete(courseId) {
    this.courseService.deleteCourse(courseId).subscribe(
      data => this.load(),
      error => console.log(error)
    );
  }

}
