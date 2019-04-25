import { Component, OnInit } from '@angular/core';
import { Lesson } from '../shared/lesson.model';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Title } from '@angular/platform-browser';
import { LessonService } from '../shared/lesson.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-lesson-create',
  templateUrl: './lesson-create.component.html',
  styleUrls: ['./lesson-create.component.scss']
})
export class LessonCreateComponent implements OnInit {

  lesson: Lesson;
  submitted = false;
  lessonForm: FormGroup;

  constructor(
    private titleService: Title,
    private lessonService: LessonService,
    private route: ActivatedRoute,
    private fb: FormBuilder
  ) { }

  ngOnInit() {
    this.setTitle();
    this.createForm();
  }

  setTitle() {
    this.titleService.setTitle(`Create lesson | AgileXP`);
  }

  createForm() {
    this.lessonForm = this.fb.group({
      name: ['', Validators.required],
      description: ['', Validators.required]
    });
  }


  submit() {
    this.createLesson();
    this.saveLesson();
  }

  createLesson() {
    this.lesson = new Lesson();
    this.lesson.name = this.lessonForm.get('name').value;
    this.lesson.description = this.lessonForm.get('description').value;
    this.lesson.courseId = Number(this.route.snapshot.params['courseId']);
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
    this.lesson = new Lesson();
    this.submitted = false;
    this.createForm();
  }

}
