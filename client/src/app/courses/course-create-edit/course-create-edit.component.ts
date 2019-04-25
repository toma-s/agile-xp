import { Component, OnInit } from '@angular/core';
import { Course } from '../shared/course.model';
import { CourseService } from '../shared/course.service';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';


@Component({
  selector: 'course-create-edit',
  templateUrl: './course-create-edit.component.html',
  styleUrls: ['./course-create-edit.component.scss']
})
export class CourseCreateEditComponent implements OnInit {

  course = new Course();
  submitted = false;
  mode: string;
  courseForm: FormGroup;

  constructor(
    private titleService: Title,
    private courseService: CourseService,
    private route: ActivatedRoute,
    private fb: FormBuilder
  ) {}

  async ngOnInit() {
    this.setMode();
    this.setTitle();
    await this.setCourse();
    this.createForm();
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

  async setCourse() {
    if (this.mode === 'edit') {
      this.course = await this.loadCourse();
      console.log(this.course);
    } else if (this.mode === 'create') {
      this.course = new Course();
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
    this.courseForm = this.fb.group({
      name: [this.course.name, Validators.required],
      description: [this.course.description, Validators.required]
    });
  }


  submit() {
    console.log(this.course);
    this.course.name = this.courseForm.get('name').value;
    this.course.description = this.courseForm.get('description').value;
    if (this.mode === 'create') {
      this.saveCourse();
    } else if (this.mode === 'edit') {
      this.updateCourse();
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


  reset() {
    this.course = new Course();
    this.submitted = false;
    this.createForm();
  }
}
