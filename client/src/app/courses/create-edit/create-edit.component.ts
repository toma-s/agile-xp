import { Component, OnInit } from '@angular/core';
import { Course } from '../shared/course.model';
import { CourseService } from '../shared/course.service';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Lesson } from '../lessons/shared/lesson.model';
import { LessonService } from '../lessons/shared/lesson.service';


@Component({
  selector: 'create-edit',
  templateUrl: './create-edit.component.html',
  styleUrls: ['./create-edit.component.scss']
})
export class CreateEditComponent implements OnInit {

  course = new Course();
  lesson = new Lesson();
  submitted = false;
  module: string;
  mode: string;
  title: string;
  dataForm: FormGroup;

  constructor(
    private titleService: Title,
    private courseService: CourseService,
    private lessonService: LessonService,
    private route: ActivatedRoute,
    private fb: FormBuilder
  ) { }

  async ngOnInit() {
    this.setModule();
    this.setMode();
    this.setTitle();
    await this.setOriginal();
    this.createForm();
  }

  setModule() {
    this.module = this.route.snapshot.params['module'];
    console.log(this.module);
  }

  setMode() {
    this.mode = this.route.snapshot.params['mode'];
    console.log(this.mode);
  }

  setTitle() {
    const capitalisedMode = this.capitalise(this.mode);
    this.title = capitalisedMode.concat(' ').concat(this.module);
    this.titleService.setTitle(`${this.title} | AgileXP`);
  }

  capitalise(s: string) {
    return s.toUpperCase()[0].concat(s.slice(1, s.length));
  }

  async setOriginal() {
    if (this.module === 'course') {
      await this.setCourse();
    }
  }

  async setCourse() {
    if (this.mode === 'edit') {
      this.course = await this.loadCourse();
    }
  }

  loadCourse(): Promise<Course> {
    const courseId = Number(this.route.snapshot.params['courseId']);
    return new Promise<Course>((resolve, reject) => {
      this.courseService.getCourseById(courseId).subscribe(
        data => resolve(data),
        error => reject(error)
      );
    });
  }

  createForm() {
    console.log(this.course);
    this.dataForm = this.fb.group({
      name: [this.course.name, Validators.required],
      description: [this.course.description, Validators.required]
    });
  }


  submit() {
    console.log(this.course);
    if (this.module === 'course') {
      this.course.name = this.dataForm.get('name').value;
      this.course.description = this.dataForm.get('description').value;
      if (this.mode === 'create') {
        this.saveCourse();
      } else if (this.mode === 'edit') {
        this.updateCourse();
      }
    } else if (this.module === 'lesson') {
      this.lesson.name = this.dataForm.get('name').value;
      this.lesson.description = this.dataForm.get('description').value;
      this.lesson.courseId = Number(this.route.snapshot.params['courseId']);
      this.saveLesson();
    }
  }

  saveCourse() {
    this.courseService.createCourse(this.course).subscribe(
      data => {
        console.log(data);
        this.submitted = true;
      },
      error => console.log(error)
    );
  }

  updateCourse() {
    this.courseService.updateCourse(this.course.id, this.course).subscribe(
      data => {
        console.log(data);
        this.submitted = true;
      },
      error => console.log(error)
    );
  }

  saveLesson() {
    this.lessonService.createLesson(this.lesson).subscribe(
      data => {
        console.log(data);
        this.submitted = true;
      },
      error => console.log(error)
    );
  }


  reset() {
    this.course = new Course();
    this.lesson = new Lesson();
    this.submitted = false;
    this.createForm();
  }
}