import { Component, OnInit } from '@angular/core';
import { Course } from '../shared/course.model';
import { CourseService } from '../shared/course.service';
import { FormGroup, FormBuilder, Validators, FormArray } from '@angular/forms';
import { Lesson } from '../lessons/shared/lesson.model';
import { LessonService } from '../lessons/shared/lesson.service';
import { Title } from '@angular/platform-browser';


@Component({
  selector: 'app-course-create',
  templateUrl: './course-create.component.html',
  styleUrls: ['./course-create.component.scss']
})
export class CourseCreateComponent implements OnInit {

  course = new Course();
  submitted = false;

  constructor(
    private titleService: Title,
    private courseService: CourseService
  ) {}

  ngOnInit(): void {
    this.setTitle();
  }

  setTitle() {
    this.titleService.setTitle(`Create course | AgileXP`);
  }

  submit() {
    console.log(this.course);
    this.saveCourse();
    this.submitted = true;
  }

  saveCourse() {
    this.courseService.createCourse(this.course)
      .subscribe(
        data => {
          console.log(data);
          // this.reset();
        },
        error => console.log(error)
      );
  }

  // reset() {
  //   this.course = new Course();
  // }
}
