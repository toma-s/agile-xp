import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LessonEditComponent } from '../lesson-edit/lesson-edit.component';
import { NotFoundComponent } from 'src/app/not-found/not-found.component';

const routes: Routes = [
  {path: 'courseDetail/:courseId/lessonEdit/:lessonId', component: LessonEditComponent}
];

@NgModule({
  imports: [
    RouterModule.forChild(routes)
  ],
  exports: [
    RouterModule
  ]
})
export class ExercisesRoutingModule { }
