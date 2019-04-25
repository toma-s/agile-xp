import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CoursesListComponent } from './courses-list/courses-list.component';
import { CourseDetailComponent } from './course-detail/course-detail.component';
import { LessonEditComponent } from './lessons/lesson-edit/lesson-edit.component';
import { ExerciseSolveComponent } from './lessons/exercises/exercise-solve/exercise-solve.component';
import { CourseCreateEditComponent } from './course-create-edit/course-create-edit.component';

const routes: Routes = [
  { path: '', redirectTo: 'courses', pathMatch: 'full'},
  { path: 'courses', component: CoursesListComponent},
  { path: 'courses/:mode', component: CourseCreateEditComponent},
  { path: 'courseDetail/:id', component: CourseDetailComponent},
  { path: 'courseDetail/:courseId/lessonEdit/:lessonId', component: LessonEditComponent},
  { path: 'courseDetail/:courseId/lesson/:lessonId/exerciseSolve/:exerciseId', component: ExerciseSolveComponent},
  { path: 'courseDetail/:courseId/:mode', component: CourseCreateEditComponent},
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
