import { Component, OnInit } from '@angular/core';
import { Course } from '../shared/course.model';
import { CourseService } from '../shared/course.service';


@Component({
  selector: 'app-course-create',
  templateUrl: './course-create.component.html',
  styleUrls: ['./course-create.component.scss']
})
export class CourseCreateComponent implements OnInit {

  course: Course = new Course();
  submitted = false;
  response = undefined;

  constructor(private courseService: CourseService) { }

  ngOnInit(): void {
  }

  newCourse(): void {
    this.course = new Course();
    this.submitted = false;
    this.response = undefined;
  }

  save() {
    this.courseService.createCourse(this.course)
      .subscribe(
        data => console.log(data),
        error => console.log(error)
      );
  }

  onSubmit() {
    this.submitted = true;
    this.save();
  }

}
