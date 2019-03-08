import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LessonEditComponent } from './lesson-edit/lesson-edit.component';
import { LessonsRoutingModule } from './lessons-routing.module';

@NgModule({
  declarations: [LessonEditComponent],
  imports: [
    CommonModule,
    LessonsRoutingModule
  ]
})
export class LessonsModule { }
