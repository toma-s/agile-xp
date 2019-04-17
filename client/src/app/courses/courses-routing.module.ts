import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CourseCreateComponent } from './course-create/course-create.component';
import { CoursesListComponent } from './courses-list/courses-list.component';
import { CourseDetailComponent } from './course-detail/course-detail.component';
import { LessonEditComponent } from './lessons/lesson-edit/lesson-edit.component';
import { ExerciseSolveComponent } from './lessons/exercises/exercise-solve/exercise-solve.component';

const routes: Routes = [
  { path: '', redirectTo: 'courses', pathMatch: 'full'},
  { path: 'courseCreate', component: CourseCreateComponent},
  { path: 'courses', component: CoursesListComponent},
  { path: 'courseDetail/:id', component: CourseDetailComponent},
  { path: 'courseDetail/:courseId/lessonEdit/:lessonId', component: LessonEditComponent},
  { path: 'courseDetail/:courseId/lesson/:lessonId/exerciseSolve/:exerciseId', component: ExerciseSolveComponent},
  { path: '../', redirectTo: 'courses' }
];

@NgModule({
  imports: [
    RouterModule.forChild(routes)
  ],
  exports: [
    RouterModule
  ]
})

export class CoursesRoutingModule { }
