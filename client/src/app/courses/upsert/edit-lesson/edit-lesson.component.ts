import { UpsertComponent } from '../upsert.component';
import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { CourseService } from '../../shared/course.service';
import { LessonService } from '../../lessons/shared/lesson.service';
import { ActivatedRoute } from '@angular/router';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Course } from '../../shared/course.model';
import { Lesson } from '../../lessons/shared/lesson.model';


@Component({
  selector: 'edit-lesson',
  templateUrl: '../upsert.component.html',
  styleUrls: ['../upsert.component.scss']
})
export class EditLessonComponent extends UpsertComponent {

  protected module = 'lesson';
  protected mode = 'edit';
  protected routerLink = '../../..';
  protected formGroup: FormGroup;
  protected content: Course;
  protected submitted = false;
  private lessonId: number;

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
    this.content = await this.loadLesson();
    this.formGroup = this.fb.group({
      name: [this.content.name, Validators.required],
      description: [this.content.description, Validators.required]
    });
  }

  loadLesson(): Promise<Lesson> {
    this.lessonId = this.route.snapshot.params['lessonId'];
    return new Promise<Lesson>((resolve, reject) => {
      this.lessonService.getLessonById(this.lessonId).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }


  submit() {
    this.content.name = this.formGroup.get('name').value;
    this.content.description = this.formGroup.get('description').value;
    this.saveLesson();
  }

  saveLesson() {
    this.lessonService.updateLesson(this.lessonId, this.content).subscribe(
      data => {
        console.log(data);
        this.submitted = true;
      },
      error => console.log(error)
    );
  }

}
