import { Component, OnInit } from '@angular/core';
import { Course } from '../shared/course.model';
import { CourseService } from '../shared/course.service';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';


@Component({
  selector: 'course-create-edit',
  templateUrl: './course-create-edit.component.html',
  styleUrls: ['./course-create-edit.component.scss']
})
export class CourseCreateEditComponent implements OnInit {

  course = new Course();
  submitted = false;
  mode: string;

  constructor(
    private titleService: Title,
    private courseService: CourseService,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    this.setMode();
    this.setTitle();
    if (this.mode === 'edit') {
      this.loadCourse();
    }
  }

  setMode() {
    this.mode = this.route.snapshot.params['mode'];
    console.log(this.mode);
  }

  setTitle() {
    const mode = this.capitalise(this.mode);
    this.titleService.setTitle(`${mode} course | AgileXP`);
  }

  capitalise(s: string) {
    return s.toUpperCase()[0].concat(s.slice(1, s.length));
  }


  loadCourse() {
    const courseId = Number(this.route.snapshot.params['courseId']);
    this.courseService.getCourseById(courseId).subscribe(
      data => {
        this.course = data;
      },
      error => console.log(error)
    );
  }


  submit() {
    console.log(this.course);
    if (this.mode === 'create') {
      this.saveCourse();
    } else if (this.mode === 'edit') {
      this.updateCourse();
    }
  }

  saveCourse() {
    this.courseService.createCourse(this.course)
      .subscribe(
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


  reset() {
    this.course = new Course();
    this.submitted = false;
  }
}
