import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CoursesComponent } from './courses.component';
import { CourseCreateComponent } from './course-create/course-create.component';
import { CoursesListComponent } from './courses-list/courses-list.component';
import { CourseDetailComponent } from './course-detail/course-detail.component';
import { LessonEditComponent } from './lessons/lesson-edit/lesson-edit.component';

const routes: Routes = [
  { path: '', redirectTo: 'courses', pathMatch: 'full'},
  { path: 'courses', component: CoursesComponent},
  { path: 'courses/courseCreate', component: CourseCreateComponent},
  { path: 'courses/coursesList', component: CoursesListComponent},
  { path: 'courses/courseDetail/:id', component: CourseDetailComponent},
  { path: 'courses/courseDetail/:courseId/lessonEdit/:lessonId', component: LessonEditComponent},
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
