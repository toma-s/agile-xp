import { Component, OnInit } from '@angular/core';
import { CourseService } from '../shared/course.service';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup } from '@angular/forms';
import { LessonService } from '../lessons/shared/lesson.service';

@Component({
  selector: 'upsert'
})
export abstract class UpsertComponent implements OnInit {

  private title: string;
  protected abstract module: string;
  protected abstract mode: string;
  protected abstract routerLink: string;
  protected abstract formGroup: FormGroup;
  protected abstract content;
  protected abstract submitted;

  constructor(
    protected titleService: Title,
    protected courseService: CourseService,
    protected lessonService: LessonService,
    protected route: ActivatedRoute,
    protected fb: FormBuilder
  ) { }

  async ngOnInit() {
    this.setTitle();
    this.createForm();
  }


  setTitle() {
    const capitalisedMode = this.capitalise(this.mode);
    this.title = capitalisedMode.concat(' ').concat(this.module);
    this.titleService.setTitle(`${this.title} | AgileXP`);
  }

  capitalise(s: string) {
    return s.toUpperCase()[0].concat(s.slice(1, s.length));
  }

  protected abstract createForm();

  protected abstract submit();

  reset() {
    this.submitted = false;
    this.createForm();
  }
}
