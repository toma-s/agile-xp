import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SendTaskComponent } from './tasks/send-task/send-task.component';
import { TasksListComponent } from './tasks/tasks-list/tasks-list.component';
import { CoursesComponent } from './courses/courses.component';

const routes: Routes = [
  { path: '', redirectTo: 'courses', pathMatch: 'full'},
  { path: 'courses', component: CoursesComponent},
  { path: 'sendTask', component: SendTaskComponent},
  { path: 'tasksList', component: TasksListComponent}
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes)
  ],
  exports: [
    RouterModule
  ],
  declarations: []
})

export class AppRoutingModule { }
