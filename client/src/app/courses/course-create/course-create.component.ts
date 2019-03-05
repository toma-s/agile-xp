import { Component, OnInit } from '@angular/core';
import { Course } from '../shared/course.model';
import { CourseService } from '../shared/course.service';
import { FormGroup, FormBuilder, Validators, FormArray } from '@angular/forms';
import { Lesson } from '../shared/lesson.model';
import { LessonService } from '../shared/lesson.service';


@Component({
  selector: 'app-course-create',
  templateUrl: './course-create.component.html',
  styleUrls: ['./course-create.component.scss']
})
export class CourseCreateComponent implements OnInit {

  public lessonsFormGroup: FormGroup;
  public lessonsArray: FormArray;

  course = new Course();
  lessons = new Array<Lesson>();

  get lessonFormGroup() {
    return this.lessonsFormGroup.get('lessons') as FormArray;
  }

  constructor(
    private fb: FormBuilder,
    private courseService: CourseService,
    private lessonService: LessonService
  ) {}

  createLesson(): FormGroup {
    return this.fb.group({
      lessonName: [null, Validators.compose([Validators.required])],
      lessonDescription: [null, Validators.compose([Validators.required])]
    });
  }

  createExercise(): FormGroup {
    return this.fb.group({
      exerciseName: [null, Validators.compose([Validators.required])],
      exerciseDescription: [null, Validators.compose([Validators.required])]
    });
  }

  ngOnInit(): void {
    this.lessonsFormGroup = this.fb.group({
      lessons: this.fb.array([this.createLesson()])
    });
    this.lessonsArray = this.lessonsFormGroup.get('lessons') as FormArray;
  }

  addLesson() {
    this.lessonsArray.push(this.createLesson());
  }

  removeLesson(index) {
    this.lessonsArray.removeAt(index);
  }

  getLessonsFormGroup(index): FormGroup {
    const formGroup = this.lessonsArray.controls[index] as FormGroup;
    return formGroup;
  }

  changedLessonType(index) {
    const validators = Validators.compose([Validators.required]);
    this.getLessonsFormGroup(index).controls['value'].setValidators(validators);
    this.getLessonsFormGroup(index).controls['value'].updateValueAndValidity();
  }

  submit() {
    console.log(this.lessonsFormGroup.value);
    console.log(this.course);
    this.createLessons();
    console.log(this.lessons);
    this.saveCourse();

    // this.reset();
  }

  createLessons() {
    this.lessonsFormGroup.value.lessons.forEach(lessonItem => {
      console.log(lessonItem);
      const lesson = new Lesson();
      lesson.name = lessonItem.lessonName;
      lesson.description = lessonItem.lessonDescription;
      this.lessons.push(lesson);
    });
  }

  saveCourse() {
    this.courseService.createCourse(this.course)
      .subscribe(
        data => {
          console.log(data);
          this.saveLessons(data.id);
          this.reset();
        },
        error => console.log(error)
      );
  }

  saveLessons(courseId: number) {
    console.log(courseId);
    console.log(this.lessons);
    this.lessons.forEach(lessonObject => {
      lessonObject.courseId = courseId;
      this.lessonService.createLesson(lessonObject)
        .subscribe(
          data => {
            console.log(data);
          },
          error => console.log(error)
        );
    });
  }

  reset() {
    this.course = new Course();
    this.lessons = new Array<Lesson>();
  }


  // course: Course = new Course();
  // submitted = false;
  // response = undefined;

  // constructor(private courseService: CourseService) { }

  // ngOnInit(): void {
  // }

  // newCourse(): void {
  //   this.course = new Course();
  //   this.submitted = false;
  //   this.response = undefined;
  // }

  // save() {
  //   this.courseService.createCourse(this.course)
  //     .subscribe(
  //       data => console.log(data),
  //       error => console.log(error)
  //     );
  // }

  // onSubmit() {
  //   this.submitted = true;
  //   this.save();
  // }

}
