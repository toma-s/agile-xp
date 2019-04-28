import { UpsertComponent } from '../upsert.component';
import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { CourseService } from '../../shared/course.service';
import { LessonService } from '../../lessons/shared/lesson.service';
import { ActivatedRoute } from '@angular/router';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { Lesson } from '../../lessons/shared/lesson.model';


@Component({
  selector: 'app-create',
  templateUrl: '../upsert.component.html',
  styleUrls: ['../upsert.component.scss']
})
export class CreateLessonComponent extends UpsertComponent {

  protected module = 'lesson';
  protected mode = 'create';
  protected routerLink = '../../..';
  protected formGroup: FormGroup;
  content: Lesson;
  protected submitted = false;

  constructor(
    protected titleService: Title,
    protected courseService: CourseService,
    protected lessonService: LessonService,
    protected route: ActivatedRoute,
    protected fb: FormBuilder
  ) {
    super(titleService, courseService, lessonService, route, fb);
  }


  createForm() {
    this.formGroup = this.fb.group({
      name: ['', Validators.required],
      description: ['', Validators.required]
    });
  }


  submit() {
    this.content = new Lesson();
    this.content.name = this.formGroup.get('name').value;
    this.content.description = this.formGroup.get('description').value;
    this.content.courseId = Number(this.route.snapshot.params['courseId']);
    this.saveLesson();
  }

  saveLesson() {
    this.lessonService.createLesson(this.content).subscribe(
      data => {
        console.log(data);
        this.submitted = true;
      },
      error => console.log(error)
    );
  }

}
