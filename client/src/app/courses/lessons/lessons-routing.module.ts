import { NgModule } from '@angular/core';
import { CoursesListComponent } from '../courses-list/courses-list.component';
import { Routes, RouterModule } from '@angular/router';

const routes: Routes = [
  {path: '../../', component: CoursesListComponent}
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
