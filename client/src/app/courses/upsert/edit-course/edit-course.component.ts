import { UpsertComponent } from '../upsert.component';
import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { CourseService } from '../../shared/course.service';
import { LessonService } from '../../lessons/shared/lesson.service';
import { ActivatedRoute } from '@angular/router';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Course } from '../../shared/course.model';


@Component({
  selector: 'edit-course',
  templateUrl: '../upsert.component.html',
  styleUrls: ['../upsert.component.scss']
})
export class EditCourseComponent extends UpsertComponent {

  protected module = 'course';
  protected mode = 'edit';
  protected routerLink = '../../../';
  protected formGroup: FormGroup;
  protected content: Course;
  protected submitted = false;
  private courseId: number;

  constructor(
    protected titleService: Title,
    protected courseService: CourseService,
    protected lessonService: LessonService,
    protected route: ActivatedRoute,
    protected fb: FormBuilder
  ) {
    super(titleService, courseService, lessonService, route, fb);
  }


  async createForm() {
    const course = await this.loadCourse();
    this.formGroup = this.fb.group({
      name: [course.name, Validators.required],
      description: [course.description, Validators.required]
    });
  }

  loadCourse(): Promise<Course> {
    this.courseId = this.route.snapshot.params['courseId'];
    return new Promise<Course>((resolve, reject) => {
      this.courseService.getCourseById(this.courseId).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  submit() {
    this.content = new Course();
    this.content.name = this.formGroup.get('name').value;
    this.content.description = this.formGroup.get('description').value;
    this.saveCourse();
  }

  saveCourse() {
    this.courseService.updateCourse(this.courseId, this.content).subscribe(
      data => this.submitted = true,
      error => console.log(error)
    );
  }

}
