import { NgModule } from '@angular/core';
import { CoursesListComponent } from '../courses-list/courses-list.component';
import { Routes, RouterModule } from '@angular/router';
import { ExerciseCreateComponent } from './exercises/exercise-create/exercise-create.component';

const routes: Routes = [
  {path: '../../', component: CoursesListComponent},
  {path: 'courses/courseDetail/:courseId/lessonEdit/:lessonId/exerciseCreate/:index', component: ExerciseCreateComponent}
];

@NgModule({
  imports: [
    RouterModule.forChild(routes)
  ],
  exports: [
    RouterModule
  ]
})
export class LessonsRoutingModule { }
